import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/bachelors_in_uae.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/web_view.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../data/response/status.dart';
import '../../../models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import '../../../models/home/ScoProgramsTileModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_urls.dart';
import '../../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../../viewModel/apply_scholarship/getAllActiveScholarshipsViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ScholarshipsInUaeView extends StatefulWidget {
  String? code;
   ScholarshipsInUaeView({super.key,this.code});

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
      appBar: CustomSimpleAppBar(titleAsString: localization.scholarshipInternal,),
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
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsTermsAndConditions, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.sco_accredited_universities_and_specializations_list,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsUniversityAndSpecializationList, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.bachelors_degree_scholarship_privileges,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsDegreePrivileges, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.student_obligations_for_the_bachelors_degree_scholarship,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsDegreeStudentObligations, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.important_guidelines_for_high_school_students,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsDegreeImportantGuidelines, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.bachelors_degree_applying_procedures,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorsDegreeApplyingProcedure, scholarshipType: widget.code ?? ''))),
          },
        ];

     case 'PGRDINT':
        return [
          {
            'title': localization.graduate_studies_scholarship_admission_terms,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateTermsAndConditions, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.sco_accredited_universities_and_specializations_list,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateUniversityAndSpecializationList, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.graduate_studies_scholarship_privileges,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateDegreePrivileges, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.student_obligations_for_the_graduate_studies_scholarship,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateDegreeStudentObligations, scholarshipType: widget.code ?? ''))),
          },

          {
            'title': localization.graduate_studies_scholarship_applying_procedures,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateDegreeApplyingProcedure, scholarshipType: widget.code ?? ''))),
          },
        ];
      case 'METLOGINT':
        return [
          {
            'title': localization.meteorological_scholarship_admission_terms,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalTermsAndConditions, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.sco_accredited_universities_and_specializations_list,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalUniversityAndSpecializationList, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.meteorological_scholarship_privileges,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalDegreePrivileges, scholarshipType: widget.code ?? ''))),
          },
          {
            'title': localization.student_obligations_for_the_meteorological_scholarship,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalDegreeStudentObligations, scholarshipType: widget.code ?? ''))),
          },

          {
            'title': localization.meteorological_scholarship_applying_procedures,
            'subTitle': "",
            'imagePath': "assets/sidemenu/scholarships_uae.jpg",
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.meteorologicalDegreeApplyingProcedure, scholarshipType: widget.code ?? ''))),
          },
        ];
      case null:
      return [
        {
          'title': localization.internalBachelor,
          'subTitle': localization.internal_scholarships_for_local_students,
          'imagePath': "assets/sidemenu/scholarships_uae.jpg",
          'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipsInUaeView(code: 'UGRDINT',))),
        },
        {
          'title': localization.internalPostgraduate,
          'subTitle': localization.internal_scholarships_for_postgraduate_studies,
          'imagePath': "assets/sidemenu/scholarships_uae.jpg",
          'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipsInUaeView(code: 'PGRDINT',))),
        },
        {
          'title': localization.internalMeterological,
          'subTitle': localization.meteorological_scholarships_for_high_school_graduates,
          'imagePath': "assets/sidemenu/scholarships_uae.jpg",
          'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipsInUaeView(code: 'METLOGINT',))),
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
          imagePath: model.imagePath!,
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
