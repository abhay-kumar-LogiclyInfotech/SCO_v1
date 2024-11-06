import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profile_photo/profile_photo.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/account/Custom_inforamtion_container.dart';
import 'package:sco_v1/resources/components/custom_checkbox_tile.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/profile_picture/profile_picture.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';

class PersonalDetailsView extends StatefulWidget {
  const PersonalDetailsView({super.key});

  @override
  State<PersonalDetailsView> createState() => _PersonalDetailsViewState();
}

class _PersonalDetailsViewState extends State<PersonalDetailsView> with MediaQueryMixin {


  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((callback)async{
      // fetch student profile Information t prefill the user information
      final studentProfileProvider = Provider.of<GetPersonalDetailsViewModel>(context, listen: false);
      await studentProfileProvider.getPersonalDetails();
    });


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar:   CustomSimpleAppBar(
        titleAsString: "Personal Details",
      ),
      body: _buildUi(),
    );
  }

  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Consumer<GetPersonalDetailsViewModel>(
      builder: (context,provider,_){
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
            return Directionality(
          textDirection: getTextDirection(langProvider),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset("assets/personal_details/edit_profile.svg")
                    ],
                  ),

                  // ProfilePhoto(
                  //   totalWidth: 80,
                  //   cornerRadius: 80,
                  //   color: Colors.blue,
                  //   outlineColor: Colors.transparent,
                  //   outlineWidth: 5,
                  //   textPadding: 0,
                  //   name: 'Brad V',
                  //   fontColor: Colors.white,
                  //   nameDisplayOption: NameDisplayOptions.initials,
                  //   fontWeight: FontWeight.w100,
                  //   badgeSize: 30,
                  //   badgeAlignment: Alignment.bottomRight,
                  //   image: const AssetImage('assets/personal_details/Picture.png'),
                  //   // badgeImage: const AssetImage('assets/personal_details/camera_icon.png'),
                  //   onTap: () {
                  //     // open profile
                  //   },
                  //   onLongPress: () {
                  //     // popup to message user
                  //   },
                  // ),



                  ProfilePicture(),
                  kFormHeight,
                  _studentInformationSection(provider: provider),
                  kFormHeight,
                  kFormHeight,
                  _studentPhoneInformationSection(provider: provider),
                  kFormHeight,
                  kFormHeight,
                  _studentEmailInformationSection(provider: provider),
                ],
              ),
            ),
          ),
        );

          case Status.NONE:
            return showVoid;
          case null:
            return showVoid;

      }}
    );




  }

  //*------Student Information Section------*
  Widget _studentInformationSection({required GetPersonalDetailsViewModel provider}) {
    final userData =provider.apiResponse.data?.data?.user;
    return CustomInformationContainer(
        title: "Student Information",
        leading: SvgPicture.asset("assets/personal_details/student_information.svg"),
        expandedContent: Column(
          children: [
            CustomInformationContainerField(title: "Full Name", description: "${userData?.firstName} ${userData?.middleName} ${userData?.middleName2} ${userData?.lastName}",),
            CustomInformationContainerField(title: "Emirates ID", description: userData?.emirateId,),
            CustomInformationContainerField(title: "Date of Birth", description: userData?.birthDate,),
            CustomInformationContainerField(title: "Nationality", description: userData?.nationality,),
            CustomInformationContainerField(title: "Gender", description: userData?.gender,),
            CustomInformationContainerField(title: "Default Interface Language", description: "Static Arabic",isLastItem: true),
          ],
        )

    );
  }

  //*------Student Phone Information Section------*
  Widget _studentPhoneInformationSection({required GetPersonalDetailsViewModel provider}) {
    final userData =provider.apiResponse.data?.data?.user;
    return CustomInformationContainer(
        title: "Phone Details",
        leading: SvgPicture.asset("assets/personal_details/phone_details.svg"),
        expandedContent: Column(
          children: [
            CustomInformationContainerField(title: "Phone Number", description: "+${userData?.phoneNumber}",),
            CustomInformationContainerField(title: "Phone Type", description: "---- Not Available on Web",),
            CustomInformationContainerField(title: "Preferred (---- Not Available on Web)",isLastItem: true),
            CustomGFCheckbox(value: false, onChanged: (value){}, text: "")
            ],
        )

    );
  }

  //*------Student Email Information Section------*
  Widget _studentEmailInformationSection({required GetPersonalDetailsViewModel provider}) {
    final userData =provider.apiResponse.data?.data?.user;
    return CustomInformationContainer(
        title: "Email Details",
        leading: SvgPicture.asset("assets/personal_details/email.svg"),
        expandedContent: Column(
          children: [
            CustomInformationContainerField(title: "Email", description: "${userData?.emailAddress}",),
            CustomInformationContainerField(title: "Email Type", description: "----- Not Available on Web",),
            CustomInformationContainerField(title: "Preferred (---- Not Available on Web)",isLastItem: true),
            CustomGFCheckbox(value: false, onChanged: (value){}, text: "") ],
        )

    );
  }
}
