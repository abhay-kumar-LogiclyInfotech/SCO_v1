
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/tiles/custom_expansion_tile.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
import 'package:sco_v1/view/main_view/scholarship_in_abroad/post_graduation_outside_uae/post_graduation_outside_uae.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../data/response/status.dart';
import '../../../models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import '../../../models/home/ScoProgramsTileModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/custom_button.dart';
import '../../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/apply_scholarship/getAllActiveScholarshipsViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../../l10n/app_localizations.dart';
import '../../apply_scholarship/fill_scholarship_form_view.dart';
import 'bachelor_outside_uae/bachelors_outside_uae.dart';
import 'doctor_of_medicine_outside_uae/doctor_of_medicine_outside_uae.dart';


class ScholarshipInAbroadView extends StatefulWidget {
  String? code;
  final String? title;

   ScholarshipInAbroadView({super.key,this.code,this.title});

  @override
  State<ScholarshipInAbroadView> createState() => _ScholarshipInAbroadViewState();
}

class _ScholarshipInAbroadViewState extends State<ScholarshipInAbroadView>
    with MediaQueryMixin<ScholarshipInAbroadView> {
  late NavigationServices _navigationServices;
  List<GetAllActiveScholarshipsModel?> academicCareerMenuItemList = [];

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();



    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      final provider = Provider.of<GetAllActiveScholarshipsViewModel>(context, listen: false);
      await provider.getAllActiveScholarships(context: context, langProvider: Provider.of<LanguageChangeViewModel>(context, listen: false));

      _scholarshipsInUaeList.clear();
      _scoProgramsModelsList.clear();
      _initializeScoPrograms();

      setState(() {

      });
    });

    super.initState();
  }





  final List<Widget> _scholarshipsInUaeList = [];
  final List<ScoProgramTileModel> _scoProgramsModelsList = [];



  List<Map<String, dynamic>> createScholarshipList(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    switch(widget.code){
      case 'SCOUGRDEXT':
        return [
          {
            'title': " شروط ومتطلبات التقديم للبعثة - درجة البكالوريوس ",
            'content' : getBachelorTermsAndConditionsExternal(context),
            // 'title': localization.bachelor_degree_scholarship_terms_and_conditions,
            // 'subTitle': "",
            'imagePath': Constants.conditions,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeTermsAndConditions, title: localization.bachelor_degree_scholarship_terms_and_conditions,))),
          },
          {
            'title': " قائمة الجامعات المعتمدة لدى المكتب ",
            'content' : getBachelorApprovedUniversitiesExternal(context),
            'imagePath': Constants.universityList,
          },
          {
            'title': " قائمة التخصّصات المعتمدة لدى المكتب ",
            'content' : getBachelorApprovedMajorsExternal(context),
            // 'imagePath': Constants.universityList,
          },
          {
            'title': " امتيازات البعثة - درجة البكالوريوس ",
            'content' : getBachelorScholarshipPrivilegesExternal(context),
            'imagePath': Constants.privileges,
          },
          {
            'title': " التزامات الطالب للبعثة - درجة البكالوريوس ",
            'content' : getBachelorStudentObligationsExternal(context),
          },
          {
            'title': " إجراءات التقديم للبعثة - درجة البكالوريوس ",
            'content' : getBachelorApplyingProcedureExternal(context),
            'imagePath': Constants.applyingProcedure,
          },

          // {
          //   'title': localization.sco_accredited_universities_and_specializations_list,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeScoAccredited, title: localization.sco_accredited_universities_and_specializations_list,))),
          // },
          // {
          //   'title': localization.bachelor_degree_scholarship_privileges,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeDegreePrivileges, title: localization.bachelor_degree_scholarship_privileges,))),
          // },
          // {
          //   'title': localization.student_obligations_for_bachelor_degree_scholarship,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeDegreeStudentObligations, title: localization.student_obligations_for_bachelor_degree_scholarship,))),
          // },
          // {
          //   'title': localization.important_guidelines_for_high_school_students,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeDegreeImportantGuidelines, title: localization.important_guidelines_for_high_school_students,))),
          // },
          // {
          //   'title': localization.bachelor_degree_applying_procedures,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeDegreeApplyingProcedure, title: localization.bachelor_degree_applying_procedures,))),
          // },
        ];
      case 'SCOPGRDEXT':
        return [
          {
            'title': " شروط ومتطلبات التقديم للبعثة - الدراسات العليا ",
            'content': getGraduateTermsAndConditionsExternal(context),
            'imagePath': Constants.conditions,
          },
          {
            'title': " قائمة الجامعات المعتمدة لدى المكتب " ,
            'content': getGraduateApprovedUniversitiesExternal(context),
            'imagePath': Constants.universityList,
          },
          {
            'title': "  قائمة التخصّصات المعتمدة لدى المكتب " ,
            'content': getGraduateApprovedMajorsExternal(context),
          },
          {
            'title': " امتيازات البعثة - الدراسات العليا  " ,
            'content': getGraduateScholarshipPrivilegesExternal(context),
            'imagePath': Constants.privileges,
          },
          {
            'title': " التزامات الطالب للبعثة - الدراسات العليا " ,
            'content': getGraduateStudentObligationsExternal(context),
          },
          {
            'title': " إجراءات التقديم للبعثة - الدراسات العليا " ,
            'content': getGraduateApplyingProcedureExternal(context),
            'imagePath': Constants.applyingProcedure,
          },
          // {
          //   'title': localization.graduate_outside_uae_terms_and_conditions,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeTermsAndConditions, title: localization.graduate_outside_uae_terms_and_conditions,))),
          // },
          // {
          //   'title': localization.sco_accredited_universities_and_specializations_list,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeUniversityAndSpecializationList, title: localization.sco_accredited_universities_and_specializations_list,))),
          // },
          // {
          //   'title': localization.graduate_outside_uae_scholarship_privileges,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeDegreePrivileges, title: localization.graduate_outside_uae_scholarship_privileges,))),
          // },
          // {
          //   'title': localization.student_obligations_for_graduate_outside_uae_scholarship,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeDegreeStudentObligations, title: localization.student_obligations_for_graduate_outside_uae_scholarship,))),
          // },
          //
          // {
          //   'title': localization.graduate_outside_uae_scholarship_applying_procedures,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeDegreeApplyingProcedure, title: localization.graduate_outside_uae_scholarship_applying_procedures,))),
          // },
        ];
      // case 'SCODDSEXT':
      //   return [
      //     {
      //       'title': " نبذة عن برنامج دكتور فى الطب ",
      //       'content': getDoctorAboutTheProgramExternal(context),
      //       // 'imagePath': Constants.faq,
      //
      //     },
      //     {
      //       'title': " شروط ومتطلبات القبول فى البعثة ",
      //       'content': getDoctorTermsAndConditionsExternal(context),
      //       'imagePath': Constants.conditions,
      //
      //     },
      //     {
      //       'title': " معايير القبول في الجامعات العالمية ",
      //       'content': getDoctorAdmissionCriteriaExternal(context),
      //       'imagePath': Constants.applyingProcedure,
      //     },
      //     {
      //       'title': " الجامعات المعتمدة ",
      //       'content': getDoctorAccreditedUniversitiesExternal(context),
      //       'imagePath': Constants.universityList,
      //
      //     },
      //     // {
      //     //   'title': localization.distinguished_doctors_scholarship_terms_and_conditions,
      //     //   'subTitle': "",
      //     //   //'imagePath': Constants.scholarshipInAbroad,
      //     //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedTermsAndConditions, title: localization.distinguished_doctors_scholarship_terms_and_conditions,))),
      //     // },
      //     // {
      //     //   'title': localization.distinguished_doctors_scholarship_privileges,
      //     //   'subTitle': "",
      //     //   //'imagePath': Constants.scholarshipInAbroad,
      //     //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreePrivileges,title: localization.distinguished_doctors_scholarship_privileges,))),
      //     // },
      //     // {
      //     //   'title': localization.student_obligations_for_distinguished_doctors_scholarship,
      //     //   'subTitle': "",
      //     //   //'imagePath': Constants.scholarshipInAbroad,
      //     //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreeStudentObligations, title: localization.student_obligations_for_distinguished_doctors_scholarship,))),
      //     // },
      //     // {
      //     //   'title': localization.distinguished_doctors_scholarship_applying_procedures,
      //     //   'subTitle': "",
      //     //   //'imagePath': Constants.scholarshipInAbroad,
      //     //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreeApplyingProcedure, title: localization.distinguished_doctors_scholarship_applying_procedures,))),
      //     // },
      //     //
      //     // {
      //     //   'title': localization.medical_licensing_exams,
      //     //   'subTitle': "",
      //     //   //'imagePath': Constants.scholarshipInAbroad,
      //     //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreeMedicalLicensingExam, title: localization.medical_licensing_exams,))),
      //     // },
      //   ];
      case null:
        return [
          {
            'title': localization.externalBachelor,
            // 'subTitle': localization.scholarship_for_outstanding_students,
            'subTitle': '',
            'imagePath': Constants.bachelorsOutsideUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipInAbroadView(code: 'SCOUGRDEXT',title: localization.externalBachelor,))),
          },
          {
            'title': localization.externalPostgraduate,
            // 'subTitle': localization.scholarship_for_postgraduate_studies,
            'subTitle': '',
            'imagePath': Constants.graduatesOutsideUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipInAbroadView(code: 'SCOPGRDEXT',title: localization.externalPostgraduate,))),
          },
          // {
          //   'title': localization.externalDoctors,
          //   // 'subTitle': localization.scholarship_for_outstanding_medical_students,
          //   'subTitle': '',
          //   'imagePath': Constants.distinguishedDoctorsOutsideUae,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipInAbroadView(code: 'SCODDSEXT',title: localization.externalDoctors,))),
          // },
        ];
      default:
        return [];
    }
  }


 bool isExternalScholarship(){
    return   ( widget.code == 'SCOUGRDEXT' || widget.code == 'SCOPGRDEXT' || widget.code == 'SCODDSEXT');
  }

  void _initializeScoPrograms() {
    final scoProgramsMapList = createScholarshipList(context);

    // Map JSON data to models
    for (var map in scoProgramsMapList) {
      _scoProgramsModelsList.add(ScoProgramTileModel.fromJson(map));
    }

    // Create widgets based on models
    for (var model in _scoProgramsModelsList) {




      _scholarshipsInUaeList.add(
        isExternalScholarship() ? CustomExpansionTile(
              leading: Image.asset(model.imagePath ?? Constants.fallback,height: 20,width: 20,),
              title: model.title!,
              expandedContent: model.content ?? const SizedBox(),
          ) :  CustomScoProgramTile(
            imagePath: model.imagePath,
            title: model.title!,
            subTitle: model.subTitle!,
            onTap: model.onTap!,
          )

       ,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final langProvider = context.read<LanguageChangeViewModel>();

    return Scaffold(
      // appBar: CustomSimpleAppBar(titleAsString: widget.title ??  localization.scholarshipExternal,),
      appBar: CustomSimpleAppBar(titleAsString:  localization.scholarshipExternal,),
      body: Consumer<GetAllActiveScholarshipsViewModel>(
    builder: (context,provider,_) {
      if (provider.apiResponse.status == Status.LOADING) {
        return Utils.pageLoadingIndicator(context: context);
      }
      return Stack(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: screenHeight,
            width: screenWidth,
          ),
          _buildUI(localization),
          if (isExternalScholarship() && (context.read<GetAllActiveScholarshipsViewModel>().apiResponse.data?.any((element) => element.configurationKey == widget.code && element.isActive == true,) ?? false))Positioned(
            bottom: 0,
            child: Container(
              // width: double.infinity,
              width: screenWidth,
              padding: EdgeInsets.all(kPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child:  CustomButton(buttonName: localization.submitNewApplication, isLoading: false, textDirection: getTextDirection(langProvider), onTap: ()async{ // fetching all active scholarships:

                _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context) => FillScholarshipFormView(selectedScholarshipConfigurationKey: widget.code, getAllActiveScholarships: provider.apiResponse.data,)));


              }),
            ),
          )
        ],
      );
    }));

  }

  Widget _buildUI(localization) {
    return Directionality(
      textDirection: getTextDirection(context.read<LanguageChangeViewModel>()),
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(kPadding),
          child: isExternalScholarship()
              ? Material(
            color: Colors.transparent,
            //   color: Colors.white,
            // shadowColor: Colors.grey.shade400,
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kCardRadius),side:  const BorderSide(color: AppColors.lightGrey)),
            child: Padding(
              // padding: EdgeInsets.all(kCardPadding),
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  sectionTitle(title: widget.title ?? localization.scholarshipExternal),
                  kSmallSpace,
                  ..._scholarshipsInUaeList.map((scholarshipType) => Padding(
                    padding:  EdgeInsets.only(bottom: kTileSpace),
                    child: scholarshipType,
                  )),
                  const SizedBox(height: 200,)
                ],
              ),
            ),
          )
              : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _scholarshipsInUaeList.length,
            itemBuilder: (context, index) {
              final scholarshipType = _scholarshipsInUaeList[index];
              return Padding(
                padding:  EdgeInsets.only(bottom: kTileSpace),
                child: scholarshipType,
              );
            },
          ),
        ),
      ),
    );
  }

}
