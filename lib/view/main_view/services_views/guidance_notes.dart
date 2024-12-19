import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/Custom_Material_Button.dart';
import 'package:sco_v1/resources/components/custom_text_field.dart';
import 'package:sco_v1/view/main_view/services_views/create_request_view.dart';
import 'package:sco_v1/view/main_view/services_views/notes_views/specific_note_details_view.dart';
import 'package:sco_v1/view/main_view/services_views/request_details_view.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services_viewmodel/get_all_requests_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_scholarship_viewmodel.dart';

import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';
import '../../../viewModel/services_viewmodel/notes_viewModels/get_all_notes_viewModel.dart';
import 'notes_views/update_note_view.dart';

class GuidanceNotesView extends StatefulWidget {
  const GuidanceNotesView({super.key});

  @override
  State<GuidanceNotesView> createState() => _GuidanceNotesViewState();
}

class _GuidanceNotesViewState extends State<GuidanceNotesView> with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;

  Future _initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// fetch my application with approved
      await Provider.of<GetAllNotesViewModel>(context, listen: false).getAllNotes();
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// initialize navigation services
      GetIt getIt = GetIt.instance;
      _navigationServices = getIt.get<NavigationServices>();
      _permissionServices = getIt.get<PermissionServices>();
      _mediaServices = getIt.get<MediaServices>();

      await _initializeData();

    });
  }



  bool _isProcessing = false;

  void setProcessing(bool isProcessing) {
    setState(() {
      _isProcessing = isProcessing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(titleAsString: localization.guidance_notes),
      body: Utils.modelProgressHud(
          processing: _isProcessing,
          child: Utils.pageRefreshIndicator(
              child: _buildUi(localization), onRefresh: _initializeData)),
    );
  }

  Widget _buildUi(localization) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    return Consumer<GetAllNotesViewModel>(builder: (context, provider, _) {
      switch (provider.apiResponse.status) {
        case Status.LOADING:
          return Utils.pageLoadingIndicator(context: context);

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
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ((provider.apiResponse.data?.data?.adviseeNotes?.isNotEmpty ?? false)) ?
                      Column(
                        children: [
                          /// Header to show create request button
                          _guidanceNotesTitle(langProvider: langProvider,localization: localization),
                          kFormHeight,
                          /// _notesSection
                          _notesSection(provider: provider, langProvider: langProvider,localization:localization),
                        ],
                      ) : Utils.showOnNoDataAvailable(context: context,text: localization.guidance_notes_unavailable)

                  ],
                ),
              ),
            ),
          );

        case Status.NONE:
          return showVoid;
        case null:
          return showVoid;
      }
    });
  }

  /// *----- header section ------*
  Widget _guidanceNotesTitle({required LanguageChangeViewModel langProvider,required AppLocalizations localization}) {
    return CustomInformationContainer(
      title: localization.advisorsNotesList,
      expandedContentPadding: EdgeInsets.zero,
      showExpandedContent: false,
      leading: SvgPicture.asset("assets/services/request_details.svg"),
      expandedContent: const SizedBox.shrink(),
    );
  }


  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Timer? _debounce;

  bool isSearching = false;
  setIsSearching(value){
    setState(() {
      isSearching = value;
    });
  }

  ///*------ Requests Section------*
  Widget _notesSection(
      {required GetAllNotesViewModel provider,
        required LanguageChangeViewModel langProvider
  ,required AppLocalizations localization}) {
    return Column(
      children: [
        /// *----- Search bar section ------*
        CustomTextField(
          currentFocusNode: _searchFocusNode,
          controller: _searchController,
          hintText: localization.searchHere,
          filled: true,
          fillColor: Colors.white,
          border:  const OutlineInputBorder(borderSide: BorderSide(color: AppColors.lightGrey)),
          trailing: const Icon(Icons.search,size: 25,color: Colors.black,),
          onChanged: (val) {
            setState(() {});
            if (_debounce?.isActive ?? false) _debounce?.cancel();

            /// Start searching
            setIsSearching(true);

            _debounce = Timer(const Duration(milliseconds: 200), () async {
              /// Stop searching after debounce
              setIsSearching(false);
              setState(() {});
            });
          },),

        /// Searched Results will get shown here
        (isSearching) ?
         Text(localization.searching)
            :
        Column(
          children: [
            kFormHeight,

            /// If there's a search query, filter and display matching results
            if (_searchController.text.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                reverse: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.apiResponse.data?.data?.adviseeNotes?.where((element) {
                  // Convert the object to a JSON map
                  final jsonMap = element.toJson();

                  // Check if any value in the map contains the search query
                  return jsonMap.values.any((value) {
                    // Ensure the value is a string before matching
                    return value != null &&
                        value.toString().toLowerCase().contains(_searchController.text.toLowerCase());
                  });
                }).length,
                itemBuilder: (context, index) {
                  final filteredList = provider.apiResponse.data?.data?.adviseeNotes
                      ?.where((element) {
                    // Convert the object to a JSON map
                    final jsonMap = element.toJson();

                    // Check if any value in the map contains the search query
                    return jsonMap.values.any((value) {
                      // Ensure the value is a string before matching
                      return value != null &&
                          value.toString().toLowerCase().contains(_searchController.text.toLowerCase());
                    });
                  })
                      .toList();

                  final element = filteredList?[index];
                  return _noteCard(langProvider: langProvider, element: element,index: index,localization: localization);
                },
              ),

            /// If there's no search query, display all items
            if (_searchController.text.isEmpty)
              ListView.builder(
                shrinkWrap: true,
                reverse: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.apiResponse.data?.data?.adviseeNotes?.length ?? 0,
                itemBuilder: (context, index) {
                  final element = provider.apiResponse.data?.data?.adviseeNotes?[index];
                  return _noteCard(langProvider: langProvider, element: element,index: index,localization: localization);
                },
              ),
          ],
        )
        ,
      ],
    );
  }


  Widget _noteCard({required langProvider,required element,required index,required AppLocalizations localization})
  {
    return Padding(
      padding: EdgeInsets.only(bottom: kPadding),
      child: SimpleCard(
          expandedContent: Column(mainAxisSize: MainAxisSize.max, children: [
            CustomInformationContainerField(title: localization.sr, description: (index+1).toString()),
            CustomInformationContainerField(title: localization.noteId, description: element.noteId.toString()),
            CustomInformationContainerField(title: localization.subject,description: element.subject.toString()),
            CustomInformationContainerField(title: localization.createdOn, description: convertTimestampToDate(element.createdOn)),
            CustomInformationContainerField(
                title: localization.actions,
                descriptionAsWidget: Column(
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        actionButton(text: localization.view,assetAddress: "assets/services/status.svg",onTap: (){
                          _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> SpecificNoteDetailsView(noteId: element.noteId.toString())));
                        }),
                        kFormHeight,
                        actionButton(text:localization.update,assetAddress: "assets/services/update_note.svg",onTap: (){
                          _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> UpdateNoteView(noteId: element.noteId.toString())));
                        }),
                      ],
                    ),
                  ],
                ),
                isLastItem: true),
            // CustomInformationContainerField(
            //     title: "Category",
            //     description: getFullNameFromLov(
            //         langProvider: langProvider,
            //         lovCode: "SERVICE_CATEGORY",
            //         code: element.requestCategory.toString())),
            // CustomInformationContainerField(
            //     title: "Request Type",
            //     description: getFullNameFromLov(
            //         langProvider: langProvider,
            //         lovCode:
            //         'SERVICE_TYPE#${element.requestCategory.toString()}',
            //         code: element.requestType.toString())),
            // CustomInformationContainerField(
            //     title: "Request Sub Type",
            //     description: getFullNameFromLov(
            //         langProvider: langProvider,
            //         lovCode:
            //         'SERVICE_SUBTYPE#${element.requestType.toString()}',
            //         code: element.requestSubType.toString())),
            // CustomInformationContainerField(
            //     title: "Request Date",
            //     description: element.requestDate ?? ''),
            // CustomInformationContainerField(
            //     title: "Status",
            //     descriptionAsWidget: Row(
            //       children: [
            //         SvgPicture.asset("assets/services/status.svg"),
            //         const SizedBox.square(dimension: 3),
            //         Text(
            //           getFullNameFromLov(
            //               langProvider: langProvider,
            //               code: element.status.toString(),
            //               lovCode: 'SERVICE_STATUS'),
            //           style: AppTextStyles.normalTextStyle().copyWith(
            //               fontWeight: FontWeight.w600,
            //               fontSize: 14,
            //               color: AppColors.scoButtonColor),
            //         )
            //       ],
            //     ),
            //     isLastItem: true),
          ])),
    );


  }

}

Widget actionButton({required assetAddress,required text,required onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.scoButtonColor)
      ),
      child: Row(
        children: [
          SvgPicture.asset(assetAddress ?? ''),
          const SizedBox.square(dimension: 3),
          Text(
            text ?? '',
            style: AppTextStyles.normalTextStyle().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.scoButtonColor),
          )
        ],
      ),
    ),
  );
}