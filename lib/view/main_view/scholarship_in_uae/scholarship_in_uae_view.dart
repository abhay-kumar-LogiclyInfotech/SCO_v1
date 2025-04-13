import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/web_view.dart';

import '../../../models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import '../../../models/home/ScoProgramsTileModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_urls.dart';
import '../../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../../l10n/app_localizations.dart';


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



  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(titleAsString: widget.title ?? localization.scholarshipInternal,),
      body: _buildUI(),
    );
  }


  final List<Widget> _scholarshipsInUaeList = [];
  final List<ScoProgramTileModel> _scoProgramsModelsList = [];



  List<Map<String, dynamic>> createScholarshipList(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    switch(widget.code){
      case 'UGRDINT':
        return [
          {
            'title': localization.bachelors_degree_scholarship_admission_terms,
            'subTitle': "",
            // 'imagePath': null,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsTermsAndConditions,title: localization.bachelors_degree_scholarship_admission_terms,))),
          },
          {
            'title': localization.sco_accredited_universities_and_specializations_list,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsUniversityAndSpecializationList, title: localization.sco_accredited_universities_and_specializations_list,))),
          },
          {
            'title': localization.bachelors_degree_scholarship_privileges,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsDegreePrivileges,title: localization.bachelors_degree_scholarship_privileges,))),
          },
          {
            'title': localization.student_obligations_for_the_bachelors_degree_scholarship,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsDegreeStudentObligations, title: localization.student_obligations_for_the_bachelors_degree_scholarship,))),
          },
          {
            'title': localization.important_guidelines_for_high_school_students,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsDegreeImportantGuidelines, title: localization.important_guidelines_for_high_school_students,))),
          },
          {
            'title': localization.bachelors_degree_applying_procedures,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsDegreeApplyingProcedure, title: localization.bachelor_degree_applying_procedures,))),
          },
        ];

     case 'PGRDINT':
        return [
          {
            'title': localization.graduate_studies_scholarship_admission_terms,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateTermsAndConditions, title: localization.graduate_studies_scholarship_admission_terms,))),
          },
          {
            'title': localization.sco_accredited_universities_and_specializations_list,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateUniversityAndSpecializationList, title: localization.sco_accredited_universities_and_specializations_list,))),
          },
          {
            'title': localization.graduate_studies_scholarship_privileges,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateDegreePrivileges, title: localization.graduate_studies_scholarship_privileges,))),
          },
          {
            'title': localization.student_obligations_for_the_graduate_studies_scholarship,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateDegreeStudentObligations, title: localization.student_obligations_for_the_graduate_studies_scholarship,))),
          },

          {
            'title': localization.graduate_studies_scholarship_applying_procedures,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateDegreeApplyingProcedure, title: localization.graduate_studies_scholarship_applying_procedures,))),
          },
        ];
      case 'METLOGINT':
        return [
          {
            'title': localization.meteorological_scholarship_admission_terms,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalTermsAndConditions, title: localization.meteorological_scholarship_admission_terms,))),
          },
          {
            'title': localization.sco_accredited_universities_and_specializations_list,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalUniversityAndSpecializationList, title:  localization.sco_accredited_universities_and_specializations_list,))),
          },
          {
            'title': localization.meteorological_scholarship_privileges,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalDegreePrivileges, title: localization.meteorological_scholarship_privileges,))),
          },
          {
            'title': localization.student_obligations_for_the_meteorological_scholarship,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalDegreeStudentObligations, title: localization.student_obligations_for_the_meteorological_scholarship,))),
          },

          {
            'title': localization.meteorological_scholarship_applying_procedures,
            'subTitle': "",
            // 'imagePath': Constants.scholarshipInUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalDegreeApplyingProcedure, title: localization.meteorological_scholarship_applying_procedures,))),
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
      _scholarshipsInUaeList.add(
        CustomScoProgramTile(
          imagePath: model.imagePath,
          title: model.title!,
          subTitle: model.subTitle!,
          onTap: model.onTap!,
        ),
      );
    }
  }


  Widget _buildUI() {
   return Padding(
     padding:  EdgeInsets.all(kPadding),
     child: ListView.builder(
       itemCount: _scholarshipsInUaeList.length ?? 0,
       itemBuilder: (context, index) {
         final scholarshipType = _scholarshipsInUaeList[index];
         return Padding(
           padding:   EdgeInsets.only(bottom: kTileSpace),
           child: scholarshipType,
         );
       },
     ),
   );
  }
}
