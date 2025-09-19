import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/tiles/custom_expansion_tile.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/post_graduation_inside_uae/post_graduation_inside_uae.dart';

import '../../../data/response/status.dart';
import '../../../models/home/ScoProgramsTileModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/custom_button.dart';
import '../../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/apply_scholarship/getAllActiveScholarshipsViewModel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../../l10n/app_localizations.dart';
import '../../apply_scholarship/fill_scholarship_form_view.dart';
import '../../apply_scholarship/form_view_Utils.dart';
import 'bachelor_inside_uae/bachelor_inside_uae.dart' hide kSmallSpace,kMinorSpace;
import 'meteorological_inside_uae/meteorological_inside_uae.dart';


class ScholarshipsInUaeView extends StatefulWidget {
  String? code;
  final String? title;
   ScholarshipsInUaeView({super.key,this.code, this.title});

  @override
  State<ScholarshipsInUaeView> createState() => _ScholarshipsInUaeViewState();
}

class _ScholarshipsInUaeViewState extends State<ScholarshipsInUaeView>
    with MediaQueryMixin<ScholarshipsInUaeView> {
  late NavigationServices _navigationServices;



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
      case 'SCOUGRDINT':
        return [
          {
            // 'title': localization.bachelors_degree_scholarship_admission_terms,
            'title': ' شروط ومتطلبات التقديم للمنحة - درجة البكالوريوس ',
            'subTitle': "",
            'content': getBachelorTermsAndConditionsInternal(context),
            'imagePath': Constants.conditions,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsTermsAndConditions,title: localization.bachelors_degree_scholarship_admission_terms,))),
          },
          {
            // 'title': localization.sco_accredited_universities_and_specializations_list,
            'title' : " قائمة الجامعات والتخصصات المعتمدة ",
            'subTitle': "",
            'content': getBachelorUniversityAndMajorsInternal(context),
            'imagePath': Constants.universityList,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsUniversityAndSpecializationList, title: localization.sco_accredited_universities_and_specializations_list,))),
          },
          {
            // 'title': localization.bachelors_degree_scholarship_privileges,
            'title' : ' قائمة الجامعات المعتمدة لدى المكتب ',
            'subTitle': "",
            'imagePath': Constants.universityList,
            'content': getBachelorUniversityAndSpecializationsInternal(context),
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsDegreePrivileges,title: localization.bachelors_degree_scholarship_privileges,))),
          },
          {
            // 'title': localization.student_obligations_for_the_bachelors_degree_scholarship,
            'title': ' قائمة التخصّصات المعتمدة لدى المكتب ',
            'content': getBachelorApprovedSpecializationInternal(context),
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsDegreeStudentObligations, title: localization.student_obligations_for_the_bachelors_degree_scholarship,))),
          },
          {
            'title': ' امتيازات المنحة - درجة البكالوريوس ',
            'content': getBachelorScholarshipPrivilegesInternal(context),
            // 'subTitle': "",
            'imagePath': Constants.privileges,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsDegreeImportantGuidelines, title: localization.important_guidelines_for_high_school_students,))),
          },
          {
            // 'title': localization.bachelors_degree_applying_procedures,
            'title': " التزامات الطالب للمنحة - درجة البكالوريوس ",
            'content': getBachelorStudentObligationsInternal(context),
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsDegreeApplyingProcedure, title: localization.bachelor_degree_applying_procedures,))),
          },
          {
            // 'title': localization.bachelors_degree_applying_procedures,
            'title': " إجراءات التقديم للمنحة - درجة البكالوريوس ",
            'content': getBachelorApplyingProcedureInternal(context),
            'subTitle': "",
            "imagePath": Constants.applyingProcedure,
          },


    ];
     case 'SCOPGRDINT':
        return [
          {
            // 'title': localization.graduate_studies_scholarship_admission_terms,
            'title': " شروط ومتطلبات التقديم للمنحة - الدراسات العليا ",
            'content': getGraduateTermsAndConditionsInternal(context),
            // 'subTitle': "",
            'imagePath': Constants.conditions,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateTermsAndConditions, title: localization.graduate_studies_scholarship_admission_terms,))),
          },
          {
            // 'title': localization.sco_accredited_universities_and_specializations_list,

            'title':  " قائمة الجامعات والتخصصات المعتمدة ",
            'content': getGraduateUniversityAndMajorsInternal(context),

            // 'subTitle': "",
            'imagePath': Constants.universityList,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateUniversityAndSpecializationList, title: localization.sco_accredited_universities_and_specializations_list,))),
          },
          {

            'title':  " قائمة الجامعات المعتمدة لدى المكتب ",
            'content': getGraduateUniversityAndSpecializationsInternal(context),

            // 'title': localization.graduate_studies_scholarship_privileges,
            // 'subTitle': "",
            'imagePath': Constants.universityList,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateDegreePrivileges, title: localization.graduate_studies_scholarship_privileges,))),
          },
          {
            'title':  " قائمة التخصّصات المعتمدة لدى المكتب ",
            'content': getGraduateApprovedSpecializationInternal(context),
            // 'title': localization.student_obligations_for_the_graduate_studies_scholarship,
            // 'subTitle': "",
            // // 'imagePath': Constants.scholarshipInUae,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateDegreeStudentObligations, title: localization.student_obligations_for_the_graduate_studies_scholarship,))),
          },

          {
            'title': ' امتيازات المنحة - الدراسات العليا ',
            'content': getGraduateScholarshipPrivilegesInternal(context),
            // 'title': localization.graduate_studies_scholarship_applying_procedures,
            // 'subTitle': "",
            'imagePath': Constants.privileges,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateDegreeApplyingProcedure, title: localization.graduate_studies_scholarship_applying_procedures,))),
          },
          {
            'title': " التزامات الطالب للمنحة - الدراسات العليا ",
            'content': getGraduateStudentObligationsInternal(context),
          },
          {
            'title': " إجراءات التقديم للمنحة - الدراسات العليا ",
            'content': getGraduateApplyingProcedureInternal(context),
            "imagePath": Constants.applyingProcedure
          }
        ];
      case 'SCOMETLOGINT':
        return [
          {
          'title': " شروط ومتطلبات القبول لمنحة الأرصاد الجوية ",
          'content': getMeteorologicalTermsAndConditionsInternal(context),
            // 'title': localization.meteorological_scholarship_admission_terms,
            // 'subTitle': "",
            'imagePath': Constants.conditions,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalTermsAndConditions, title: localization.meteorological_scholarship_admission_terms,))),
          },
          {
            'title': " قائمة الجامعات والتخصصات المعتمدة للمنح لدى المكتب ",
            'content': getMeteorologicalUniversityAndSpecializationsInternal(context),

            // 'title': localization.sco_accredited_universities_and_specializations_list,
            // 'subTitle': "",
            'imagePath': Constants.universityList,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalUniversityAndSpecializationList, title:  localization.sco_accredited_universities_and_specializations_list,))),
          },


          {
            'title': " امتيازات منحة الأرصاد الجوية ",
            'content': getMeteorologicalScholarshipPrivilegesInternal(context),

            // 'title': localization.meteorological_scholarship_privileges,
            // 'subTitle': "",
            'imagePath': Constants.privileges,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalDegreePrivileges, title: localization.meteorological_scholarship_privileges,))),
          },
          {
            'title':  " التزامات الطالب لمنحة الأرصاد الجوية ",
            'content': getMeteorologicalStudentObligationsInternal(context),
            // 'title': localization.student_obligations_for_the_meteorological_scholarship,
            // 'subTitle': "",
            // // 'imagePath': Constants.scholarshipInUae,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalDegreeStudentObligations, title: localization.student_obligations_for_the_meteorological_scholarship,))),
          },

          {
            'title':  " إجراءات التقديم لمنحة الأرصاد الجوية ",
            'content': getMeteorologicalApplyingProcedureInternal(context),
            // 'title': localization.meteorological_scholarship_applying_procedures,
            // 'subTitle': "",
            'imagePath': Constants.applyingProcedure,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalDegreeApplyingProcedure, title: localization.meteorological_scholarship_applying_procedures,))),
          },
        ];
      case null:
      return [
        {
          'title': localization.internalBachelor,
          // 'subTitle': localization.internal_scholarships_for_local_students,
          'subTitle': '',
          'imagePath': Constants.bachelorsInUae,
          'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipsInUaeView(code: 'SCOUGRDINT',title: localization.internalBachelor,))),
        },
        {
          'title': localization.internalPostgraduate,
          // 'subTitle': localization.internal_scholarships_for_postgraduate_studies,
          'subTitle': '',
          'imagePath': Constants.graduatesInUAE,
          'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipsInUaeView(code: 'SCOPGRDINT',title: localization.internalPostgraduate,))),
        },
        /// TODO: Inactive in 2025
        // {
        //   'title': localization.internalMeterological,
        //   // 'subTitle': localization.meteorological_scholarships_for_high_school_graduates,
        //   'subTitle': '',
        //   'imagePath': Constants.meteorologicalInUAE,
        //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipsInUaeView(code: 'SCOMETLOGINT',title: localization.internalMeterological,))),
        // },
      ];
      default:
        return [];
    }

  }


 bool isInternalScholarship(){
    return  (widget.code == 'SCOUGRDINT' || widget.code == 'SCOPGRDINT' || widget.code == 'SCOMETLOGINT');
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
        isInternalScholarship() ? CustomExpansionTile(
          leading: Image.asset(model.imagePath ?? Constants.fallback,height: 20,width: 20,),
          title: model.title!,
          expandedContent: model.content ?? const SizedBox(),
        ) :  CustomScoProgramTile(
          imagePath: model.imagePath,
          title: model.title!,
          subTitle: model.subTitle!,
          onTap: model.onTap!,
        ),
      );

    }
  }



  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final langProvider = context.read<LanguageChangeViewModel>();



    return Scaffold(
      // appBar: CustomSimpleAppBar(titleAsString: widget.title ?? localization.scholarshipInternal,),
      appBar: CustomSimpleAppBar(titleAsString: localization.scholarshipInternal,),
      body: Consumer<GetAllActiveScholarshipsViewModel>(
        builder: (context,provider,_){
          if(provider.apiResponse.status == Status.LOADING){
            return Utils.pageLoadingIndicator(context: context);
          }
          return Stack(
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: screenHeight,
                width: screenWidth,
              ),
              _buildUI(localization,isInternalScholarship()),
              if (
              isInternalScholarship() && (context.read<GetAllActiveScholarshipsViewModel>().apiResponse.data?.any((element) => element.configurationKey == widget.code && isScholarshipActiveInSystem(isActive: element.isActive,isSpecialCase: element.isSpecialCase) ,) ?? false)
              )Positioned(
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
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget _buildUI() {
  //  return Padding(
  //    padding:  EdgeInsets.all(kPadding),
  //    child: ListView.builder(
  //      itemCount: _scholarshipsInUaeList.length ?? 0,
  //      itemBuilder: (context, index) {
  //        final scholarshipType = _scholarshipsInUaeList[index];
  //        return Padding(
  //          padding:   EdgeInsets.only(bottom: kTileSpace),
  //          child: scholarshipType,
  //        );
  //      },
  //    ),
  //  );
  // }

  Widget _buildUI(AppLocalizations localization, bool isInternalScholarship) {


    return Directionality(
      textDirection: getTextDirection(context.read<LanguageChangeViewModel>()),
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(kPadding),
          child: isInternalScholarship
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
                  sectionTitle(title: widget.title ?? localization.scholarshipInternal),
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
