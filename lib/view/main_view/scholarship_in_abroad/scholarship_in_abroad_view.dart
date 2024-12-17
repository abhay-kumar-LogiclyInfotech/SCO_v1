// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:provider/provider.dart';
// import 'package:sco_v1/resources/app_text_styles.dart';
// import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
// import 'package:sco_v1/utils/utils.dart';
// import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
//
// import '../../../models/home/ScoProgramsTileModel.dart';
// import '../../../resources/app_colors.dart';
// import '../../../resources/components/tiles/custom_sco_program_tile.dart';
// import '../../../viewModel/services/navigation_services.dart';
//
// class ScholarshipInAboardView extends StatefulWidget {
//   const ScholarshipInAboardView({super.key});
//
//   @override
//   State<ScholarshipInAboardView> createState() => _ScholarshipInAboardViewState();
// }
//
// class _ScholarshipInAboardViewState extends State<ScholarshipInAboardView>
//     with MediaQueryMixin<ScholarshipInAboardView> {
//   late NavigationServices _navigationServices;
//
//   @override
//   void initState() {
//     final GetIt getIt = GetIt.instance;
//     _navigationServices = getIt.get<NavigationServices>();
//     _initializeScoPrograms();
//     super.initState();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bgColor,
//       appBar: CustomSimpleAppBar(titleAsString: "Scholarships in Abroad",),
//       body: _buildUI(),
//     );
//   }
//
//
//   final List<Widget> _scholarshipsInUaeList = [];
//   final List<ScoProgramTileModel> _scoProgramsModelsList = [];
//   void _initializeScoPrograms() {
//     final scoProgramsMapList = [
//       {
//         'title': "Bachelor's Degree Scholarship",
//         'subTitle': "This is Subtitle 1",
//         'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
//         "onTap": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const ScholarshipInAboardView()),
//         ),
//       },
//       {
//         'title': "Graduate Studies Scholarship",
//         'subTitle': "This is Subtitle 2",
//         'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
//         "onTap": ()=>{}
//       },
//       {
//         'title': "Distinguished Doctors Scholarship",
//         'subTitle': "This is Subtitle 3",
//         'imagePath': "assets/sidemenu/distinguished_doctors.jpg",
//         "onTap": ()=>{}
//       },
//     ];
//
//     // Map JSON data to models
//     for (var map in scoProgramsMapList) {
//       _scoProgramsModelsList.add(ScoProgramTileModel.fromJson(map));
//     }
//
//     // Create widgets based on models
//     for (var model in _scoProgramsModelsList) {
//       _scholarshipsInUaeList.add(
//         CustomScoProgramTile(
//           imagePath: model.imagePath!,
//           title: model.title!,
//           subTitle: model.subTitle!,
//           onTap: model.onTap!,
//         ),
//       );
//     }
//   }
//
//
//   Widget _buildUI() {
//     final provider = Provider.of<LanguageChangeViewModel>(context);
//
//     return Padding(
//       padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
//       child: ListView.builder(
//         itemCount: _scholarshipsInUaeList.length,
//         itemBuilder: (context, index) {
//           final scholarshipType = _scholarshipsInUaeList[index];
//           return Padding(
//             padding:  EdgeInsets.only(bottom: kPadding),
//             child: scholarshipType,
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_urls.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/web_view.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../data/response/status.dart';
import '../../../models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import '../../../models/home/ScoProgramsTileModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../../viewModel/apply_scholarship/getAllActiveScholarshipsViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ScholarshipInAbroadView extends StatefulWidget {
  String? code;

   ScholarshipInAbroadView({super.key,this.code});

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
      appBar: CustomSimpleAppBar(titleAsString: localization.scholarshipExternal,),
      body: _buildUI(),
    );
  }

  final List<Widget> _scholarshipsInUaeList = [];
  final List<ScoProgramTileModel> _scoProgramsModelsList = [];



  List<Map<String, dynamic>> createScholarshipList(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    switch(widget.code){
      case 'UGRDEXT':
        return [
          {
            'title': localization.bachelor_degree_scholarship_terms_and_conditions,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeTermsAndConditions, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.sco_accredited_universities_and_specializations_list,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeScoAccredited, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.bachelor_degree_scholarship_privileges,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeDegreePrivileges, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.student_obligations_for_bachelor_degree_scholarship,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeDegreeStudentObligations, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.important_guidelines_for_high_school_students,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeDegreeImportantGuidelines, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.bachelor_degree_applying_procedures,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeDegreeApplyingProcedure, scholarshipType: widget.code ?? ''))),
          },
        ];
      case 'PGRDEXT':
        return [
          {
            'title': localization.graduate_outside_uae_terms_and_conditions,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeTermsAndConditions, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.sco_accredited_universities_and_specializations_list,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeUniversityAndSpecializationList, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.graduate_outside_uae_scholarship_privileges,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeDegreePrivileges, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.student_obligations_for_graduate_outside_uae_scholarship,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeDegreeStudentObligations, scholarshipType: widget.code ?? ''))),
          },

          {
            'title': localization.graduate_outside_uae_scholarship_applying_procedures,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeDegreeApplyingProcedure, scholarshipType: widget.code ?? ''))),
          },
        ];
      case 'DDSEXT':
        return [
          {
            'title': localization.distinguished_doctors_scholarship_terms_and_conditions,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedTermsAndConditions, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.distinguished_doctors_scholarship_privileges,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreePrivileges, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.student_obligations_for_distinguished_doctors_scholarship,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreeStudentObligations, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.distinguished_doctors_scholarship_applying_procedures,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreeApplyingProcedure, scholarshipType: widget.code ?? ''))),
          },

          {
            'title': localization.medical_licensing_exams,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreeMedicalLicensingExam, scholarshipType: widget.code ?? ''))),
          },
        ];
      case null:
        return [
          {
            'title': localization.externalBachelor,
            'subTitle': localization.scholarship_for_outstanding_students,
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipInAbroadView(code: 'UGRDEXT',))),
          },
          {
            'title': localization.externalPostgraduate,
            'subTitle': localization.scholarship_for_postgraduate_studies,
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipInAbroadView(code: 'PGRDEXT',))),
          },
          {
            'title': localization.externalDoctors,
            'subTitle': localization.scholarship_for_outstanding_medical_students,
            'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipInAbroadView(code: 'DDSEXT',))),
          },
        ];
      default:
        return [];
    }

  }

  void _initializeScoPrograms() {
    final localization = AppLocalizations.of(context)!;
    final scoProgramsMapList = createScholarshipList(context);

    // Map JSON data to models
    for (var map in scoProgramsMapList) {
      _scoProgramsModelsList.add(ScoProgramTileModel.fromJson(map));
    }

    // Create widgets based on models
    for (var model in _scoProgramsModelsList) {
      _scholarshipsInUaeList.add(
        CustomScoProgramTile(
          imagePath: model.imagePath!,
          title: model.title!,
          subTitle: model.subTitle!,
          onTap: model.onTap!,
        ),
      );
    }
  }


  Widget _buildUI() {
    final provider = Provider.of<LanguageChangeViewModel>(context);


    return   Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
      child: ListView.builder(
        itemCount: _scholarshipsInUaeList.length ?? 0,
        itemBuilder: (context, index) {
          final scholarshipType = _scholarshipsInUaeList[index];
          return Padding(
            padding:  const EdgeInsets.only(bottom: 10),
            child: scholarshipType,
          );
        },
      ),
    );


  }
  
}
