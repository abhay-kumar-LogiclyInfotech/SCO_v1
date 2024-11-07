import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:profile_photo/profile_photo.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/apply_scholarship/FillScholarshipFormModels.dart';
import 'package:sco_v1/resources/components/account/Custom_inforamtion_container.dart';
import 'package:sco_v1/resources/components/custom_checkbox_tile.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/myDivider.dart';
import 'package:sco_v1/resources/components/profile_picture/profile_picture.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/response/status.dart';
import '../../../models/account/personal_details/PersonalDetailsModel.dart';
import '../../../resources/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/services/navigation_services.dart';
import 'edit_personal_details_view.dart';

class PersonalDetailsView extends StatefulWidget {
  const PersonalDetailsView({super.key});

  @override
  State<PersonalDetailsView> createState() => _PersonalDetailsViewState();
}

class _PersonalDetailsViewState extends State<PersonalDetailsView>
    with MediaQueryMixin {
  late NavigationServices _navigationServices;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      // fetch student profile Information t prefill the user information
      final studentProfileProvider = Provider.of<GetPersonalDetailsViewModel>(context, listen: false);
      await studentProfileProvider.getPersonalDetails();

      // initialize navigation services
      GetIt getIt = GetIt.instance;
      _navigationServices = getIt.get<NavigationServices>();


    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
        titleAsString: "Personal Details",
      ),
      body: _buildUi(),
    );
  }



  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Consumer<GetPersonalDetailsViewModel>(
        builder: (context, provider, _) {
      switch (provider.apiResponse.status) {
        case Status.LOADING:
          return Utils.pageLoadingIndicator();

        case Status.ERROR:
          return Center(
            child: Text(
              AppLocalizations.of(context)!.somethingWentWrong,
            ),
          );
        case Status.COMPLETED:

          final userInfo = provider.apiResponse.data?.data?.userInfo;


          return Directionality(
            textDirection: getTextDirection(langProvider),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [


                    // Edit Profile Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              _navigationServices.pushSimpleWithAnimationRoute(CupertinoPageRoute(builder: (context) => const EditPersonalDetailsView()));
                            },
                            child: SvgPicture.asset("assets/personal_details/edit_profile.svg")),
                      ],
                    ),

                    ProfilePhoto(
                      totalWidth: 80,
                      cornerRadius: 80,
                      color: Colors.blue,
                      outlineColor: Colors.transparent,
                      outlineWidth: 5,
                      textPadding: 0,
                      name: 'Brad V',
                      fontColor: Colors.white,
                      nameDisplayOption: NameDisplayOptions.initials,
                      fontWeight: FontWeight.w100,
                      badgeSize: 30,
                      badgeAlignment: Alignment.bottomRight,
                      image: const AssetImage('assets/personal_details/dummy_profile_pic.png'),
                      // badgeImage: const AssetImage('assets/personal_details/camera_icon.png'),
                      onTap: () {
                        // open profile
                      },
                      onLongPress: () {
                        // popup to message user
                      },
                    ),

                    // ProfilePicture(),
                    kFormHeight,
                    _studentInformationSection(provider: provider,langProvider: langProvider),

                    userInfo?.phoneNumbers != null ?   Column(
                      children: [
                        kFormHeight,
                        kFormHeight,
                        _studentPhoneInformationSection(provider: provider,langProvider: langProvider),
                      ],
                    ) : showVoid,

                    userInfo?.phoneNumbers != null ? Column(
                      children: [
                        kFormHeight,
                        kFormHeight,
                        _studentEmailInformationSection(provider: provider,langProvider: langProvider),
                      ],
                    ) : showVoid,
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
      {required GetPersonalDetailsViewModel provider,required langProvider})
  {
    final user = provider.apiResponse.data?.data?.user;
    final userInfo = provider.apiResponse.data?.data?.userInfo;
    return CustomInformationContainer(
        title: "Student Information",
        leading:
            SvgPicture.asset("assets/personal_details/student_information.svg"),
        expandedContent: Column(
          children: [
            CustomInformationContainerField(
              title: "Full Name",
              description:
                  "${user?.firstName} ${user?.middleName} ${user?.middleName2} ${user?.lastName}",
            ),
            CustomInformationContainerField(
              title: "Emirates ID",
              description: user?.emirateId,
            ),
            CustomInformationContainerField(
              title: "Date of Birth",
              description: user?.birthDate,
            ),
            CustomInformationContainerField(
              title: "Nationality",
              description:  getFullNameFromLov(lovCode: 'COUNTRY',code: user?.nationality , langProvider: langProvider ),
            ),
            CustomInformationContainerField(
              title: "Gender",
              description: getFullNameFromLov(lovCode: 'GENDER',code:  user?.gender , langProvider: langProvider ),
            ),
            CustomInformationContainerField(
              title: "Marital Status",
              description: getFullNameFromLov(lovCode: 'MARITAL_STATUS',code:  userInfo?.maritalStatus , langProvider: langProvider ),
            ),
            CustomInformationContainerField(
                title: "Default Interface Language",
                description: userInfo?.languageId ?? '',
                isLastItem: true),
          ],
        ));
  }

  //*------Student Phone Information Section------*
  Widget _studentPhoneInformationSection(
      {required GetPersonalDetailsViewModel provider,required langProvider})
  {
    final userInfo = provider.apiResponse.data?.data?.userInfo;
     List<PhoneNumbers> phoneNumbers = [];
    userInfo?.phoneNumbers?.forEach((element){
      phoneNumbers.add(element);
    });

    return CustomInformationContainer(
        title: "Phone Details",
        leading: SvgPicture.asset("assets/personal_details/phone_details.svg"),
        expandedContent: Column(
          children: phoneNumbers.asMap().entries.map((entry) {
            final index = entry.key;
            final phoneDetail = entry.value;
            final isLastItem = index == phoneNumbers.length - 1;

            return Column(
              children: [
                CustomInformationContainerField(
                  title: "Phone Number",
                  description: "+${phoneDetail.phoneNumber ?? ''}",
                ),
                CustomInformationContainerField(
                  title: "Phone Type",
                  description: getFullNameFromLov(lovCode: 'PHONE_TYPE',code:  phoneDetail.phoneType , langProvider: langProvider ),
                ),
                CustomInformationContainerField(
                  title: "Preferred",
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
        )
    );
  }

  //*------Student Email Information Section------*
  Widget _studentEmailInformationSection({required GetPersonalDetailsViewModel provider,required langProvider}) {
    final userInfo = provider.apiResponse.data?.data?.userInfo;
    List<Emails> emails = [];
    userInfo?.emails?.forEach((element){
      emails.add(element);
    });

    return CustomInformationContainer(
        title: "Email Details",
        leading: SvgPicture.asset("assets/personal_details/email.svg"),
        expandedContent: Column(
          children: emails.asMap().entries.map((entry) {
            final index = entry.key;
            final email = entry.value;
            final isLastItem = index == emails.length - 1;

            return Column(
              children: [
                CustomInformationContainerField(
                  title: "Email",
                  description: "${email.emailId}",
                ),
                CustomInformationContainerField(
                  title: "Email Type",
                  description: getFullNameFromLov(lovCode: 'EMAIL_TYPE',code:  email.emailType , langProvider: langProvider ),
                ),
                CustomInformationContainerField(
                    title: "Preferred",
                    isLastItem: true),
                CustomGFCheckbox(value: email.prefferd ?? false, onChanged: (value) {}, text: ""),
                kFormHeight,
                if (!isLastItem) ...[
                  const MyDivider(color: AppColors.lightGrey),
                  kFormHeight,
                ],
              ],
            );
          }).toList(),
        )

    );
  }

}


