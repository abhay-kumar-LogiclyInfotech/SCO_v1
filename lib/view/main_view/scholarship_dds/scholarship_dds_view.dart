
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
import 'doctor_of_medicine_outside_uae/doctor_of_medicine_outside_uae.dart';


class ScholarshipDdsView extends StatefulWidget {
  String? code;
  final String? title;

  ScholarshipDdsView({super.key,this.code,this.title});

  @override
  State<ScholarshipDdsView> createState() => _ScholarshipDdsViewState();
}

class _ScholarshipDdsViewState extends State<ScholarshipDdsView>
    with MediaQueryMixin<ScholarshipDdsView> {
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
      case 'SCODDSEXT':
        return [
          {
            'title': " نبذة عن برنامج دكتور فى الطب ",
            'content': getDoctorAboutTheProgramExternal(context),
            // 'imagePath': Constants.faq,

          },
          {
            'title': " شروط ومتطلبات القبول فى البعثة ",
            'content': getDoctorTermsAndConditionsExternal(context),
            'imagePath': Constants.conditions,

          },
          {
            'title': " معايير القبول في الجامعات العالمية ",
            'content': getDoctorAdmissionCriteriaExternal(context),
            'imagePath': Constants.applyingProcedure,
          },
          {
            'title': " الجامعات المعتمدة ",
            'content': getDoctorAccreditedUniversitiesExternal(context),
            'imagePath': Constants.universityList,

          },
          // {
          //   'title': localization.distinguished_doctors_scholarship_terms_and_conditions,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedTermsAndConditions, title: localization.distinguished_doctors_scholarship_terms_and_conditions,))),
          // },
          // {
          //   'title': localization.distinguished_doctors_scholarship_privileges,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreePrivileges,title: localization.distinguished_doctors_scholarship_privileges,))),
          // },
          // {
          //   'title': localization.student_obligations_for_distinguished_doctors_scholarship,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreeStudentObligations, title: localization.student_obligations_for_distinguished_doctors_scholarship,))),
          // },
          // {
          //   'title': localization.distinguished_doctors_scholarship_applying_procedures,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreeApplyingProcedure, title: localization.distinguished_doctors_scholarship_applying_procedures,))),
          // },
          //
          // {
          //   'title': localization.medical_licensing_exams,
          //   'subTitle': "",
          //   //'imagePath': Constants.scholarshipInAbroad,
          //   'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(WebView(url: AppUrls.distinguishedDegreeMedicalLicensingExam, title: localization.medical_licensing_exams,))),
          // },
        ];
      case null:
        return [
          {
            'title': localization.externalDoctorsOutsideUae,
            // 'subTitle': localization.scholarship_for_outstanding_medical_students,
            'subTitle': '',
            'imagePath': Constants.distinguishedDoctorsOutsideUae,
            'onTap': () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(ScholarshipDdsView(code: 'SCODDSEXT',title: localization.externalDoctorsOutsideUae,))),
          },
        ];
      default:
        return [];
    }
  }


  bool isDdsScholarship(){
    return   (widget.code == 'SCODDSEXT');
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
        isDdsScholarship() ? CustomExpansionTile(
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
        appBar: CustomSimpleAppBar(titleAsString:  localization.externalDoctors,),
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
                  if (isDdsScholarship() && (context.read<GetAllActiveScholarshipsViewModel>().apiResponse.data?.any((element) => element.configurationKey == widget.code && isScholarshipActiveInSystem(isActive: element.isActive,isSpecialCase: element.isSpecialCase) ,) ?? false))Positioned(
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
          child: isDdsScholarship()
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
