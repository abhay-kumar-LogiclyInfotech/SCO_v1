
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_urls.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/tiles/custom_expansion_tile.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/web_view.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import '../../../models/home/ScoProgramsTileModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../../l10n/app_localizations.dart';
import 'bachelor_outside_uae/bachelors_outside_uae.dart';


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
      case 'UGRDEXT':
        return [
          {
            'title': localization.bachelor_degree_scholarship_terms_and_conditions,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'content' : getTermsAndConditions(context),
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeTermsAndConditions, title: localization.bachelor_degree_scholarship_terms_and_conditions,))),
          },
          {
            'title': localization.sco_accredited_universities_and_specializations_list,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeScoAccredited, title: localization.sco_accredited_universities_and_specializations_list,))),
          },
          {
            'title': localization.bachelor_degree_scholarship_privileges,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeDegreePrivileges, title: localization.bachelor_degree_scholarship_privileges,))),
          },
          {
            'title': localization.student_obligations_for_bachelor_degree_scholarship,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeDegreeStudentObligations, title: localization.student_obligations_for_bachelor_degree_scholarship,))),
          },
          {
            'title': localization.important_guidelines_for_high_school_students,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeDegreeImportantGuidelines, title: localization.important_guidelines_for_high_school_students,))),
          },
          {
            'title': localization.bachelor_degree_applying_procedures,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.bachelorOutsideUaeDegreeApplyingProcedure, title: localization.bachelor_degree_applying_procedures,))),
          },
        ];
      case 'PGRDEXT':
        return [
          {
            'title': localization.graduate_outside_uae_terms_and_conditions,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeTermsAndConditions, title: localization.graduate_outside_uae_terms_and_conditions,))),
          },
          {
            'title': localization.sco_accredited_universities_and_specializations_list,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeUniversityAndSpecializationList, title: localization.sco_accredited_universities_and_specializations_list,))),
          },
          {
            'title': localization.graduate_outside_uae_scholarship_privileges,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeDegreePrivileges, title: localization.graduate_outside_uae_scholarship_privileges,))),
          },
          {
            'title': localization.student_obligations_for_graduate_outside_uae_scholarship,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeDegreeStudentObligations, title: localization.student_obligations_for_graduate_outside_uae_scholarship,))),
          },

          {
            'title': localization.graduate_outside_uae_scholarship_applying_procedures,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.graduateOutsideUaeDegreeApplyingProcedure, title: localization.graduate_outside_uae_scholarship_applying_procedures,))),
          },
        ];
      case 'DDSEXT':
        return [
          {
            'title': localization.distinguished_doctors_scholarship_terms_and_conditions,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedTermsAndConditions, title: localization.distinguished_doctors_scholarship_terms_and_conditions,))),
          },
          {
            'title': localization.distinguished_doctors_scholarship_privileges,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreePrivileges,title: localization.distinguished_doctors_scholarship_privileges,))),
          },
          {
            'title': localization.student_obligations_for_distinguished_doctors_scholarship,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreeStudentObligations, title: localization.student_obligations_for_distinguished_doctors_scholarship,))),
          },
          {
            'title': localization.distinguished_doctors_scholarship_applying_procedures,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreeApplyingProcedure, title: localization.distinguished_doctors_scholarship_applying_procedures,))),
          },

          {
            'title': localization.medical_licensing_exams,
            'subTitle': "",
            //'imagePath': Constants.scholarshipInAbroad,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreeMedicalLicensingExam, title: localization.medical_licensing_exams,))),
          },
        ];
      case null:
        return [
          {
            'title': localization.externalBachelor,
            // 'subTitle': localization.scholarship_for_outstanding_students,
            'subTitle': '',
            'imagePath': Constants.bachelorsOutsideUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipInAbroadView(code: 'UGRDEXT',title: localization.externalBachelor,))),
          },
          {
            'title': localization.externalPostgraduate,
            // 'subTitle': localization.scholarship_for_postgraduate_studies,
            'subTitle': '',
            'imagePath': Constants.graduatesOutsideUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipInAbroadView(code: 'PGRDEXT',title: localization.externalPostgraduate,))),
          },
          {
            'title': localization.externalDoctors,
            // 'subTitle': localization.scholarship_for_outstanding_medical_students,
            'subTitle': '',
            'imagePath': Constants.distinguishedDoctorsOutsideUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipInAbroadView(code: 'DDSEXT',title: localization.externalDoctors,))),
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

      final isExternalScholarship = widget.code == 'UGRDEXT' || widget.code == 'PGRDEXT' || widget.code == 'DDSEXT';


      _scholarshipsInUaeList.add(
          isExternalScholarship ? CustomExpansionTile(
              title: model.title!,
              expandedContent: model.content ?? const SizedBox(),
              trailing: const Icon(Icons.keyboard_arrow_down,color: Colors.white,),
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

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      // appBar: CustomSimpleAppBar(titleAsString: widget.title ??  localization.scholarshipExternal,),
      appBar: CustomSimpleAppBar(titleAsString:  localization.scholarshipExternal,),
      body: _buildUI(localization),
    );
  }

  Widget _buildUI(localization) {
    final isExternalScholarship = widget.code == 'UGRDEXT' || widget.code == 'PGRDEXT' || widget.code == 'DDSEXT';

    return Directionality(
      textDirection: getTextDirection(context.read<LanguageChangeViewModel>()),
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(kPadding),
          child: isExternalScholarship
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
                  sectionTitle(title: widget.title ?? localization.scholarshipExternal),
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
