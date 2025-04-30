import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/tiles/custom_expansion_tile.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/post_graduation_inside_uae/post_graduation_inside_uae.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/web_view.dart';

import '../../../models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import '../../../models/home/ScoProgramsTileModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_urls.dart';
import '../../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../../l10n/app_localizations.dart';
import '../../apply_scholarship/form_view_Utils.dart';
import 'bachelor_inside_uae/bachelor_inside_uae.dart';
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
  List<GetAllActiveScholarshipsModel?> academicCareerMenuItemList = [];

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();



    WidgetsBinding.instance.addPostFrameCallback((callback) async {
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
      case 'UGRDINT':
        return [
          {
            // 'title': localization.bachelors_degree_scholarship_admission_terms,
            'title': ' شروط ومتطلبات التقديم للمنحة - درجة البكالوريوس ',
            'subTitle': "",
            'content': getBachelorTermsAndConditionsInternal(context),
            // 'imagePath': null,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsTermsAndConditions,title: localization.bachelors_degree_scholarship_admission_terms,))),
          },
          {
            // 'title': localization.sco_accredited_universities_and_specializations_list,
            'title' : " قائمة الجامعات والتخصصات المعتمدة ",
            'subTitle': "",
            'content': getBachelorUniversityAndMajorsInternal(context),

            // 'imagePath': Constants.scholarshipInUae,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsUniversityAndSpecializationList, title: localization.sco_accredited_universities_and_specializations_list,))),
          },
          {
            // 'title': localization.bachelors_degree_scholarship_privileges,
            'title' : ' قائمة الجامعات المعتمدة لدى المكتب ',
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
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
            // 'imagePath': Constants.scholarshipInUae,
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
          },


    ];
     case 'PGRDINT':
        return [
          {
            // 'title': localization.graduate_studies_scholarship_admission_terms,
            'title': " شروط ومتطلبات التقديم للمنحة - الدراسات العليا ",
            'content': getGraduateTermsAndConditionsInternal(context),
            // 'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateTermsAndConditions, title: localization.graduate_studies_scholarship_admission_terms,))),
          },
          {
            // 'title': localization.sco_accredited_universities_and_specializations_list,

            'title':  " قائمة الجامعات والتخصصات المعتمدة ",
            'content': getGraduateUniversityAndMajorsInternal(context),

            // 'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateUniversityAndSpecializationList, title: localization.sco_accredited_universities_and_specializations_list,))),
          },
          {

            'title':  " قائمة الجامعات المعتمدة لدى المكتب ",
            'content': getGraduateUniversityAndSpecializationsInternal(context),

            // 'title': localization.graduate_studies_scholarship_privileges,
            // 'subTitle': "",
            // // 'imagePath': Constants.scholarshipInUae,
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
            // // 'imagePath': Constants.scholarshipInUae,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateDegreeApplyingProcedure, title: localization.graduate_studies_scholarship_applying_procedures,))),
          },
          {
            'title': " التزامات الطالب للمنحة - الدراسات العليا ",
            'content': getGraduateStudentObligationsInternal(context),
          },
          {
            'title': " إجراءات التقديم للمنحة - الدراسات العليا ",
            'content': getGraduateApplyingProcedureInternal(context),
          }







        ];
      case 'METLOGINT':
        return [
          {
          'title': " شروط ومتطلبات القبول لمنحة الأرصاد الجوية ",
          'content': getMeteorologicalTermsAndConditionsInternal(context),
            // 'title': localization.meteorological_scholarship_admission_terms,
            // 'subTitle': "",
            // // 'imagePath': Constants.scholarshipInUae,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalTermsAndConditions, title: localization.meteorological_scholarship_admission_terms,))),
          },
          {
            'title': " قائمة الجامعات والتخصصات المعتمدة للمنح لدى المكتب ",
            'content': getMeteorologicalUniversityAndSpecializationsInternal(context),

            // 'title': localization.sco_accredited_universities_and_specializations_list,
            // 'subTitle': "",
            // // 'imagePath': Constants.scholarshipInUae,
            // 'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalUniversityAndSpecializationList, title:  localization.sco_accredited_universities_and_specializations_list,))),
          },


          {
            'title': " امتيازات منحة الأرصاد الجوية ",
            'content': getMeteorologicalScholarshipPrivilegesInternal(context),

            // 'title': localization.meteorological_scholarship_privileges,
            // 'subTitle': "",
            // // 'imagePath': Constants.scholarshipInUae,
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
            // // 'imagePath': Constants.scholarshipInUae,
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
          'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipsInUaeView(code: 'UGRDINT',title: localization.internalBachelor,))),
        },
        {
          'title': localization.internalPostgraduate,
          // 'subTitle': localization.internal_scholarships_for_postgraduate_studies,
          'subTitle': '',
          'imagePath': Constants.graduatesInUAE,
          'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipsInUaeView(code: 'PGRDINT',title: localization.internalPostgraduate,))),
        },
        {
          'title': localization.internalMeterological,
          // 'subTitle': localization.meteorological_scholarships_for_high_school_graduates,
          'subTitle': '',
          'imagePath': Constants.meteorologicalInUAE,
          'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipsInUaeView(code: 'METLOGINT',title: localization.internalMeterological,))),
        },
      ];
      default:
        return [];
    }

  }


  void _initializeScoPrograms() {
    final scoProgramsMapList = createScholarshipList(context);

    // Map JSON data to models
    for (var map in scoProgramsMapList) {
      _scoProgramsModelsList.add(ScoProgramTileModel.fromJson(map));
    }

    // Create widgets based on models
    for (var model in _scoProgramsModelsList) {


      final isInternalScholarship = widget.code == 'UGRDINT' || widget.code == 'PGRDINT' || widget.code == 'METLOGINT';


      _scholarshipsInUaeList.add(
        isInternalScholarship ? CustomExpansionTile(
          title: model.title!,
          expandedContent: model.content ?? const SizedBox(),
          trailing: const Icon(Icons.keyboard_arrow_down,color: Colors.white,),
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
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      // appBar: CustomSimpleAppBar(titleAsString: widget.title ?? localization.scholarshipInternal,),
      appBar: CustomSimpleAppBar(titleAsString: localization.scholarshipInternal,),
      body: _buildUI(localization),
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

  Widget _buildUI(AppLocalizations localization) {
    final isInternalScholarship = widget.code == 'UGRDINT' || widget.code == 'PGRDINT' || widget.code == 'METLOGINT';

    return Directionality(
      textDirection: getTextDirection(context.read<LanguageChangeViewModel>()),
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(kPadding),
          child: isInternalScholarship
              ? Material(
            color: Colors.white,
            shadowColor: Colors.grey.shade400,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kCardRadius),side:  const BorderSide(color: AppColors.lightGrey)),
            child: Padding(
              padding: EdgeInsets.all(kCardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  sectionTitle(title: widget.title ?? localization.scholarshipInternal),
                  const SizedBox(height: 8),
                  ..._scholarshipsInUaeList.map((scholarshipType) => Padding(
                    padding:  EdgeInsets.only(bottom: kTileSpace),
                    child: scholarshipType,
                  )),
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
