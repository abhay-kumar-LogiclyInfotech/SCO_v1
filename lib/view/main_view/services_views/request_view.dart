import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/Custom_Material_Button.dart';
import 'package:sco_v1/resources/components/custom_text_field.dart';
import 'package:sco_v1/view/main_view/services_views/create_request_view.dart';
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
import '../../../../l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';

class RequestView extends StatefulWidget {
  const RequestView({super.key});

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;

  Future _initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// fetch my application with approved
      await Provider.of<GetAllRequestsViewModel>(context, listen: false).getAllRequests();
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
      appBar: CustomSimpleAppBar(titleAsString: localization.request),
      body: Utils.modelProgressHud(
          processing: _isProcessing,
          child: Utils.pageRefreshIndicator(child: _buildUi(), onRefresh: _initializeData)),
    );
  }

  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    final localization = AppLocalizations.of(context)!;

    return Padding(
      padding:  EdgeInsets.all(kPadding),
      child: Column(
        children: [
          /// Header to show create request button
          _createRequestButton(langProvider: langProvider,localization: localization),
          kFormHeight,

          Consumer<GetAllRequestsViewModel>(builder: (context, provider, _) {
            switch (provider.apiResponse.status) {
              case Status.LOADING:
                return Utils.pageLoadingIndicator(context: context);
              case Status.ERROR:
                return showVoid;
              case Status.COMPLETED:
                return Directionality(
                  textDirection: getTextDirection(langProvider),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Request status card
                        _requestsSection(provider: provider, langProvider: langProvider,localization: localization),
                      ],
                    ),
                  ),
                );

              case Status.NONE:
                return showVoid;
              case null:
                return showVoid;
            }
          }),
        ],
      ),
    );
  }

  /// *----- header section ------*
  Widget _createRequestButton({required LanguageChangeViewModel langProvider,required AppLocalizations localization}) {
    return CustomInformationContainer(
      title: localization.createRequest,
      expandedContentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset("assets/services/request_list.svg"),
      showExpandedContent: false,
      expandedContent: const SizedBox.shrink(),
      trailing: CustomMaterialButton(
        onPressed: () {
          _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> CreateRequestView()));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCardRadius)),
        visualDensity: VisualDensity.compact,
        child:  Row(
          children: [
           const  Icon(
              Icons.add_circle_outline,
              size: 15,
            ),
            Text(
              " ${localization.createRequestUpperCase}",
              style: const TextStyle(
                  color: AppColors.scoButtonColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
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
  Widget _requestsSection(
      {required GetAllRequestsViewModel provider,
      required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
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
                 reverse: true,
                 physics: const NeverScrollableScrollPhysics(),
                 itemCount: provider.apiResponse.data?.data?.listOfRequest?.where((element) {
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
                   final filteredList = provider.apiResponse.data?.data?.listOfRequest
                       ?.where((element) {
                     // Convert the object to a JSON map
                     final jsonMap = element.toJson();

                     // Check if any value in the map contains the search query
                     return jsonMap.values.any((value) {
                       // Ensure the value is a string before matching
                       return value != null && value.toString().toLowerCase().contains(_searchController.text.toLowerCase());
                     });
                   })
                       .toList();

                   final element = filteredList?[index];
                   return _requestCard(langProvider: langProvider, element: element,localization: localization);
                 },
               ),

             /// If there's no search query, display all items
             if (_searchController.text.isEmpty)
               ListView.builder(
                 shrinkWrap: true,
                 reverse: true,
                 physics: const NeverScrollableScrollPhysics(),
                 itemCount: provider.apiResponse.data?.data?.listOfRequest?.length ?? 0,
                 itemBuilder: (context, index) {
                   final element = provider.apiResponse.data?.data?.listOfRequest?[index];
                   return _requestCard(langProvider: langProvider, element: element,localization: localization);
                 },
               ),
           ],
         )
        ,
      ],
    );
  }


  Widget _requestCard({required langProvider,required element,required AppLocalizations localization})
  {
    return Padding(
      padding: EdgeInsets.only(bottom: kCardSpace),
      child: SimpleCard(
        onTap: (){
          _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> RequestDetailsView(request: element)));
        },
          expandedContent: Column(mainAxisSize: MainAxisSize.max, children: [
            CustomInformationContainerField(
                title: localization.sr,
                description: element.serviceRequestId.toString()),
            CustomInformationContainerField(
                title: localization.requestId,
                description: element.ssrRsReqSeqHeader.toString()),
            CustomInformationContainerField(
                title: localization.category,
                description: getFullNameFromLov(
                    langProvider: langProvider,
                    lovCode: "SERVICE_CATEGORY",
                    code: element.requestCategory.toString())),
            CustomInformationContainerField(
                title: localization.requestType,
                description: getFullNameFromLov(
                    langProvider: langProvider,
                    lovCode:
                    'SERVICE_TYPE#${element.requestCategory.toString()}',
                    code: element.requestType.toString())),
            CustomInformationContainerField(
                title: localization.requestSubType,
                description: getFullNameFromLov(
                    langProvider: langProvider,
                    lovCode:
                    'SERVICE_SUBTYPE#${element.requestType.toString()}',
                    code: element.requestSubType.toString())),
            CustomInformationContainerField(
                title: localization.requestDate,
                description: element.requestDate ?? ''),
            CustomInformationContainerField(
                title: localization.status,
                descriptionAsWidget: Row(
                  children: [
                    SvgPicture.asset("assets/services/status.svg"),
                    const SizedBox.square(dimension: 3),
                    Text(
                      getFullNameFromLov(
                          langProvider: langProvider,
                          code: element.status.toString(),
                          lovCode: 'SERVICE_STATUS'),
                      style: AppTextStyles.normalTextStyle().copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.scoButtonColor),
                    )
                  ],
                ),
                isLastItem: true),
          ])),
    );


  }}
