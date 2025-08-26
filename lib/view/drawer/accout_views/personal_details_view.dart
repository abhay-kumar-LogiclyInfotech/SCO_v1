import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:profile_photo/profile_photo.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/apply_scholarship/FillScholarshipFormModels.dart';
import 'package:sco_v1/resources/app_urls.dart';
import 'package:sco_v1/resources/components/account/Custom_inforamtion_container.dart';
import 'package:sco_v1/resources/components/account/profile_with_camera_button.dart';
import 'package:sco_v1/resources/components/custom_checkbox_tile.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/kButtons/edit_button.dart';
import 'package:sco_v1/resources/components/myDivider.dart';
import 'package:sco_v1/resources/components/profile_picture/profile_picture.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import 'package:sco_v1/viewModel/account/personal_details/get_profile_picture_url_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../data/response/status.dart';
import '../../../models/account/personal_details/PersonalDetailsModel.dart';
import '../../../resources/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/authentication/get_roles_viewModel.dart';
import '../../../viewModel/services/navigation_services.dart';
import 'edit_personal_details_view.dart';

class PersonalDetailsView extends StatefulWidget {
  const PersonalDetailsView({super.key});

  @override
  State<PersonalDetailsView> createState() => _PersonalDetailsViewState();
}

class _PersonalDetailsViewState extends State<PersonalDetailsView> with MediaQueryMixin {
  late NavigationServices _navigationServices;


  Future<void> _fetchData() async {
    // fetch student profile Information t prefill the user information
    final studentProfileProvider = Provider.of<GetPersonalDetailsViewModel>(context, listen: false);
    final studentProfilePictureProvider = Provider.of<GetProfilePictureUrlViewModel>(context, listen: false);

    // Getting Fresh Roles
    final getRolesProvider = Provider.of<GetRoleViewModel>(context,listen:false);

    await Future.wait<dynamic>([
      studentProfileProvider.getPersonalDetails(),
      studentProfilePictureProvider.getProfilePictureUrl(),
      getRolesProvider.getRoles(),
    ]);
    if (studentProfilePictureProvider.apiResponse.status == Status.COMPLETED) {
      setState(() {
        // _profilePictureUrl =
        //     studentProfilePictureProvider.apiResponse.data?.url?.toString() ??
        //         '';
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      await _fetchData();
      // initialize navigation services
      GetIt getIt = GetIt.instance;
      _navigationServices = getIt.get<NavigationServices>();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return PopScope(
      child: Scaffold(
          appBar: CustomSimpleAppBar(
            titleAsString: localization.personalDetailsTitle,
          ),
          body: Utils.pageRefreshIndicator(
              child: _buildUi(localization), onRefresh: _fetchData)),
    );
  }

  Widget _buildUi(localization) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Consumer<GetPersonalDetailsViewModel>(
        builder: (context, provider, _) {
      switch (provider.apiResponse.status) {
        case Status.LOADING:
          return Utils.pageLoadingIndicator(context: context);
        case Status.ERROR:
          return Center(
            child: Text(
              localization.somethingWentWrong,
            ),
          );
        case Status.COMPLETED:
          final userInfo = provider.apiResponse.data?.data?.userInfo;
          return Directionality(
            textDirection: getTextDirection(langProvider),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(kPadding),
                child: Column(
                  children: [
                    // Edit Profile Button
                    EditButton(onTap: () {
                      _navigationServices.pushSimpleWithAnimationRoute(
                          CupertinoPageRoute(
                              builder: (context) =>
                              const EditPersonalDetailsView()));
                    }),

                    /// User profile picture without camera button
                    Consumer<GetProfilePictureUrlViewModel>(
                      builder: (context,provider,_){
                        return ProfileWithCameraButton(
                            cameraEnabled: false,
                            profileImage: provider.apiResponse.data?.data?.url != null ? NetworkImage(AppUrls.domainUrl + provider.apiResponse.data!.data!.url!.toString()) : const AssetImage('assets/personal_details/Picture.png'),
                            onTap: () {},
                            onLongPress: () {},
                        );
                      },
                    )
                    ,

                    // ProfilePicture(),
                    kFormHeight,
                    _studentInformationSection(
                        provider: provider, langProvider: langProvider,localization: localization),

                    userInfo?.phoneNumbers != null
                        ? Column(
                            children: [
                              kFormHeight,
                              kFormHeight,
                              _studentPhoneInformationSection(
                                  provider: provider,
                                  langProvider: langProvider,
                              localization: localization),
                            ],
                          )
                        : showVoid,

                    userInfo?.phoneNumbers != null
                        ? Column(
                            children: [
                              kFormHeight,
                              kFormHeight,
                              _studentEmailInformationSection(
                                  provider: provider,
                                  langProvider: langProvider,
                              localization: localization),
                            ],
                          )
                        : showVoid,
                  ],
                ),
              ),
            ),
          );

        case Status.NONE:
          return showVoid;
        case null:
          return showVoid;
      }
    });
  }

  //*------Student Information Section------*
  Widget _studentInformationSection(
      {required GetPersonalDetailsViewModel provider, required langProvider,required AppLocalizations localization}) {
    final user = provider.apiResponse.data?.data?.user;
    final userInfo = provider.apiResponse.data?.data?.userInfo;
    final userInfoType = provider.apiResponse.data?.data?.userInfoType;

    bool lifeRay = userInfoType != null && userInfoType == 'LIFERAY';
    bool peopleSoft = userInfoType != null && userInfoType != 'LIFERAY';
    return CustomInformationContainer(
        title: localization.studentInformation,
        leading: SvgPicture.asset("assets/personal_details/student_information.svg"),
        expandedContent: Column(
          children: [
            CustomInformationContainerField(
              title: localization.fullName,
              description: "${user?.firstName ?? ''} ${user?.middleName ?? ''} ${user?.middleName2 ?? ''} ${user?.lastName ?? ''}",
            ),
            CustomInformationContainerField(
              title: localization.emiratesId,
              description: user?.emirateId,
            ),
            if (lifeRay)
              CustomInformationContainerField(
                title: localization.emailAddress,
                description: user?.emailAddress,
              ),
            CustomInformationContainerField(
              title: localization.brithDate,
              description: user?.birthDate,
            ),
            if (lifeRay)
              CustomInformationContainerField(
                title: localization.studentMobileNumber,
                description: user?.phoneNumber,
              ),
            CustomInformationContainerField(
              title: localization.nationality,
              description: getFullNameFromLov(
                  lovCode: 'COUNTRY',
                  code: user?.nationality,
                  langProvider: langProvider),
            ),
            CustomInformationContainerField(
              title: localization.gender,
              description: getFullNameFromLov(
                  lovCode: 'GENDER',
                  code: user?.gender,
                  langProvider: langProvider),
              isLastItem: lifeRay,
            ),
            peopleSoft
                ? CustomInformationContainerField(
                    title: localization.maritalStatus,
                    description: getFullNameFromLov(
                        lovCode: 'MARITAL_STATUS',
                        code: userInfo?.maritalStatus,
                        langProvider: langProvider),
                    isLastItem: peopleSoft,
                  )
                : showVoid,

            /// Backend Developer has not provided this in api..
            // CustomInformationContainerField(
            //     title: "Default Interface Language",
            //     description: userInfo?.languageId ?? '',
            //     isLastItem: true),
          ],
        ));
  }

  //*------Student Phone Information Section------*
  Widget _studentPhoneInformationSection(
      {required GetPersonalDetailsViewModel provider, required langProvider, required AppLocalizations localization}) {
    final userInfo = provider.apiResponse.data?.data?.userInfo;
    List<PhoneNumbers> phoneNumbers = [];
    userInfo?.phoneNumbers?.forEach((element) {phoneNumbers.add(element);});

    return CustomInformationContainer(
        title: localization.contactInformation,
        leading: SvgPicture.asset("assets/personal_details/phone_details.svg"),
        expandedContent: Column(
          children: phoneNumbers.asMap().entries.map((entry) {
            final index = entry.key;
            final phoneDetail = entry.value;
            final isLastItem = index == phoneNumbers.length - 1;

            return Column(
              children: [
                CustomInformationContainerField(
                  title: localization.phoneNo,
                  description: "+${phoneDetail.phoneNumber ?? ''}",
                ),
                CustomInformationContainerField(
                  title: localization.submissionPhoneType,
                  description: getFullNameFromLov(
                      lovCode: 'PHONE_TYPE',
                      code: phoneDetail.phoneType,
                      langProvider: langProvider),
                ),
                CustomInformationContainerField(
                  title: localization.submissionPreferred,
                  isLastItem: true,
                ),
                CustomGFCheckbox(
                  value: phoneDetail.prefered ?? false,
                  onChanged: (value) {},
                  text: "",
                ),
                kFormHeight,
                if (!isLastItem) ...[
                  const MyDivider(color: AppColors.lightGrey),
                  kFormHeight,
                ],
              ],
            );
          }).toList(),
        ));
  }

  //*------Student Email Information Section------*
  Widget _studentEmailInformationSection(
      {required GetPersonalDetailsViewModel provider, required langProvider, required AppLocalizations localization}) {
    final userInfo = provider.apiResponse.data?.data?.userInfo;
    List<Emails> emails = [];
    userInfo?.emails?.forEach((element) {
      emails.add(element);
    });

    return CustomInformationContainer(
        title: localization.emailInformation,
        leading: SvgPicture.asset("assets/personal_details/email.svg"),
        expandedContent: Column(
          children: emails.asMap().entries.map((entry) {
            final index = entry.key;
            final email = entry.value;
            final isLastItem = index == emails.length - 1;

            return Column(
              children: [
                CustomInformationContainerField(
                  title: localization.registrationEmailAddress,
                  description: "${email.emailId}",
                ),
                CustomInformationContainerField(
                  title: localization.emailType,
                  description: getFullNameFromLov(
                      lovCode: 'EMAIL_TYPE',
                      code: email.emailType,
                      langProvider: langProvider),
                ),
                CustomInformationContainerField(
                    title: localization.submissionPreferred, isLastItem: true),
                CustomGFCheckbox(
                    value: email.prefferd ?? false,
                    onChanged: (value) {},
                    text: ""),
                kFormHeight,
                if (!isLastItem) ...[
                  const MyDivider(color: AppColors.lightGrey),
                  kFormHeight,
                ],
              ],
            );
          }).toList(),
        ));
  }
}
