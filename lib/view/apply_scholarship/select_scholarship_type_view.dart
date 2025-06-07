import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import '../../l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/custom_dropdown.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/constants.dart';
import 'package:sco_v1/view/apply_scholarship/fill_scholarship_form_view.dart';
import 'package:sco_v1/viewModel/apply_scholarship/getAllActiveScholarshipsViewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';
import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';

class SelectScholarshipTypeView extends StatefulWidget {
  const SelectScholarshipTypeView({super.key});

  @override
  State<SelectScholarshipTypeView> createState() =>
      _SelectScholarshipTypeViewState();
}

class _SelectScholarshipTypeViewState extends State<SelectScholarshipTypeView>
    with MediaQueryMixin<SelectScholarshipTypeView> {
  late NavigationServices _navigationService;
  late AlertServices _alertService;

  // Define focus nodes:
  final FocusNode _requestTypeFocusNode = FocusNode();
  final FocusNode _academicCareerFocusNode = FocusNode();

  // selected value:
  String _selectedAcademicCareer = '';

  // Academic career menuItemList
  List<GetAllActiveScholarshipsModel?>? academicCareerMenuItemList = [];


  /// Internal scholarship list
  List<GetAllActiveScholarshipsModel?>? internalScholarshipMenuItemList = [];
  /// external scholarship list
  List<GetAllActiveScholarshipsModel?>? externalScholarshipMenuItemList = [];
  /// doctor's scholarship list
  List<GetAllActiveScholarshipsModel?>? doctorScholarshipMenuItemList = [];


  // Preparing dropdown items
  List<DropdownMenuItem> populateAcademicCareer({
    required List<GetAllActiveScholarshipsModel?> menuItemsList,
    required LanguageChangeViewModel provider,
  }) {
    final textDirection = getTextDirection(provider);

    // Using a Set to keep track of already added values to avoid duplicates.
    return menuItemsList
        .where((element) => element != null) // Ensures no null values
        .map((element) {
      return DropdownMenuItem(
        value: element!.configurationKey.toString(),
        alignment: textDirection == TextDirection.ltr ? Alignment.centerLeft : Alignment.centerRight,
        child: Text(
          textDirection == TextDirection.ltr
              ? element.configurationNameEng.toString()
              : element.configurationName.toString(),
          style: const TextStyle(
            color: AppColors.scoButtonColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
          // maxLines: 1,
        ),
      );
    }).toList();
  }


  late List<Map<String, dynamic>> _scholarshipRequestTypeMutable;


  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationService = getIt.get<NavigationServices>();
    _alertService = getIt.get<AlertServices>();




    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      // fetching all active scholarships:
      final provider = Provider.of<GetAllActiveScholarshipsViewModel>(context, listen: false);
      await provider.getAllActiveScholarships(context: context, langProvider: Provider.of<LanguageChangeViewModel>(context, listen: false));


     internalScholarshipMenuItemList =  provider.apiResponse.data?.where((element) => element.scholarshipType.toString() == 'INT' && element.isActive == true).toList();
     externalScholarshipMenuItemList =  provider.apiResponse.data?.where((element) => element.scholarshipType.toString() == 'EXT' && element.acadmicCareer.toString() != 'DDS' && element.isActive == true).toList();
     doctorScholarshipMenuItemList =  provider.apiResponse.data?.where((element) => element.acadmicCareer.toString() == 'DDS' && element.isActive == true).toList();

    });

  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomSimpleAppBar(
        title: Text(localization.apply_for_scholarship,
            style: AppTextStyles.appBarTitleStyle()),
      ),
      body: _buildUI(localization),
    );
  }

  Widget _buildUI(AppLocalizations localization) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    dynamic textDirection = getTextDirection(langProvider);
    return Padding(
      padding: EdgeInsets.all(kPadding),
      child: Consumer<GetAllActiveScholarshipsViewModel>(
        builder: (context, provider, _) {
          return provider.apiResponse.status == Status.LOADING
              ? Utils.pageLoadingIndicator(context: context)
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Directionality(
                        textDirection: getTextDirection(langProvider),
                        child: SimpleCard(expandedContent:
                        Column(
                          children: provider.scholarshipRequestType.map<Widget>((element) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF1F3F5),
                                    borderRadius: BorderRadius.circular(kCardRadius),
                                  ),
                                  margin: EdgeInsets.only(bottom: provider.scholarshipRequestType.indexOf(element) < provider.scholarshipRequestType.length - 1 ? kCardPadding : 0),
                                  padding: EdgeInsets.all(kCardPadding),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        element['image'] ?? Constants.scholarshipInAbroad,
                                        height: 50,
                                        width: 50,
                                      ),
                                      kMinorSpace,
                                      Text(
                                        getTextDirection(langProvider) == TextDirection.ltr ? element['value'] : element['valueArabic'],
                                        style: AppTextStyles.titleBoldTextStyle(),
                                      ),

                                      kMinorSpace,
                                      RichText(
                                        text: TextSpan(
                                            style: AppTextStyles.subTitleTextStyle(),
                                            children: [
                                            TextSpan(
                                              text: element['seeMore']
                                                  ? element['description']
                                                  : element['description'].toString().substring(0, element['description'].toString().length > 200 ? 200 : element['description'].toString().length),
                                            ),
                                            TextSpan(
                                                style: AppTextStyles.subTitleTextStyle().copyWith(fontWeight: FontWeight.w600,color: AppColors.scoLightThemeColor),
                                                text: element['seeMore'] ? localization.seeLess : localization.seeMore,
                                                recognizer: TapGestureRecognizer()..onTap = ()=> provider.toggleSeeMore(provider.scholarshipRequestType.indexOf(element))
                                            )
                                          ]
                                        ),
                                      ),
                                      kMinorSpace,

                                      CustomDropdown(
                                        textDirection: textDirection,
                                        menuItemsList: populateAcademicCareer(menuItemsList:

                                            element['code'] == 'INT' ? internalScholarshipMenuItemList! : element['code'] == 'EXT' ? externalScholarshipMenuItemList! : doctorScholarshipMenuItemList!  , provider: Provider.of<LanguageChangeViewModel>(context)),
                                        currentFocusNode: _requestTypeFocusNode,
                                        hintText: localization.select,
                                        textColor: AppColors.scoButtonColor,
                                        outlinedBorder: true,
                                        fillColor: Colors.white,
                                        filled: true,
                                        onChanged: (value) {
                                          // Handle academic career selection
                                          setState(() {
                                            _selectedAcademicCareer = value;
                                          });
                                        },
                                      ),
                                      kSmallSpace,
                                      CustomButton(
                                          buttonName: AppLocalizations.of(context)!.apply_for_scholarship,
                                          isLoading: false,
                                          textDirection: getTextDirection(langProvider),
                                          // buttonColor: AppColors.scoButtonColor,
                                          borderRadius: BorderRadius.circular(10),
                                          onTap: () {
                                            _selectedAcademicCareer.isNotEmpty ?
                                            _navigationService.pushCupertino(CupertinoPageRoute(builder: (context) => FillScholarshipFormView(selectedScholarshipConfigurationKey: _selectedAcademicCareer, getAllActiveScholarships: provider.apiResponse.data,)))
                                                : _alertService.showErrorSnackBar("${localization.select} ${localization.academicCareer}",);
                                          }),

                                    ],
                                  ),
                                );
                              }).toList(),
                        )
                        ),
                      )

                      ,


                      // submit application section:
                      // CustomInformationContainer(
                      //     title: localization.submitApplication,
                      //     leading: SvgPicture.asset("assets/scholarships.svg"),
                      //     expandedContent: Column(
                      //       children: [
                      //         kFormHeight,
                      //
                      //         // Heading
                      //         fieldHeading(
                      //             title: localization.requestType,
                      //             important: false,
                      //             langProvider: langProvider),
                      //
                      //         // Dropdown for Request Type
                      //         CustomDropdown(
                      //           textDirection: textDirection,
                      //           menuItemsList: populateNormalDropdownWithValue(menuItemsList: Constants.scholarshipRequestType, provider: langProvider),
                      //           currentFocusNode: _requestTypeFocusNode,
                      //           hintText: localization.select,
                      //           textColor: AppColors.scoButtonColor,
                      //           outlinedBorder: true,
                      //           onChanged: (value) {
                      //             setState(() {
                      //               // Reset academicCareerMenuItemList when Request Type changes
                      //               _selectedAcademicCareer = ''; // Reset the selected academic career
                      //
                      //               // Filter the list of active scholarships based on the selected request type
                      //               academicCareerMenuItemList = provider.apiResponse.data?.where((element) => element.scholarshipType.toString() == value.toString() && element.isActive == true).toList();
                      //
                      //               // request next focus
                      //               Utils.requestFocus(
                      //                   focusNode: _academicCareerFocusNode,
                      //                   context: context);
                      //             });
                      //           },
                      //         ),
                      //
                      //         kFormHeight,
                      //
                      //         // Heading
                      //         fieldHeading(
                      //             title: localization.academicCareer,
                      //             important: false,
                      //             langProvider: langProvider),
                      //
                      //         // Dropdown for Academic Career
                      //         CustomDropdown(
                      //           filled: (academicCareerMenuItemList == null ||
                      //               academicCareerMenuItemList!.isEmpty),
                      //           textDirection: textDirection,
                      //           menuItemsList: populateAcademicCareer(
                      //               menuItemsList:
                      //                   (academicCareerMenuItemList == null ||
                      //                           academicCareerMenuItemList!
                      //                               .isEmpty)
                      //                       ? []
                      //                       : academicCareerMenuItemList!,
                      //               provider: langProvider),
                      //           currentFocusNode: _academicCareerFocusNode,
                      //           hintText: localization.select,
                      //           textColor: AppColors.scoButtonColor,
                      //           outlinedBorder: true,
                      //           value: _selectedAcademicCareer.isEmpty
                      //               ? null
                      //               : _selectedAcademicCareer,
                      //           // Set the value properly
                      //           onChanged: (value) {
                      //             // Handle academic career selection
                      //             setState(() {
                      //               _selectedAcademicCareer = value;
                      //             });
                      //           },
                      //         ),
                      //         kFormHeight,
                      //       ],
                      //     )),

                      // kSubmitButtonHeight,
                      //
                      //
                      //
                      // kSubmitButtonHeight,
                    ],
                  ),
                );
        },
      ),
    );
  }


}
