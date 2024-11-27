import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
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

class ScholarshipsInUaeView extends StatefulWidget {
  const ScholarshipsInUaeView({super.key});

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
      // /// pinging the api for get page content by url testing
      // final provider = Provider.of<GetPageContentByUrlViewModel>(context, listen: false);
      // await provider.getPageContentByUrl();
      // fetching all active scholarships:
      final provider = Provider.of<GetAllActiveScholarshipsViewModel>(context, listen: false);
      await provider.getAllActiveScholarships(context: context, langProvider: Provider.of<LanguageChangeViewModel>(context, listen: false));


      /// INTERNAL SCHOLARSHIPS MENU ITEMS LIST
      academicCareerMenuItemList = provider.apiResponse.data?.where((element) => element.scholarshipType.toString() == 'INT' && element.isActive == true).toList() ?? [];
      _initializeScoPrograms();

      setState(() {

      });
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(titleAsString: "Scholarships in UAE",),
      body: _buildUI(),
    );
  }


  final List<Widget> _scholarshipsInUaeList = [];
  final List<ScoProgramTileModel> _scoProgramsModelsList = [];
  void _initializeScoPrograms() {
    final scoProgramsMapList = [
      {
        'title': "Bachelors Degree Scholarship",
        'subTitle': "This is Subtitle 1",
        'imagePath': "assets/sidemenu/scholarships_uae.jpg",
        "onTap": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const WebView(url: "url",scholarshipType: 'INT',),),
        ),
      },
      {
        'title': "Graduate Studies Scholarship",
        'subTitle': "This is Subtitle 2",
        'imagePath': "assets/sidemenu/scholarships_uae.jpg",
        "onTap": ()=>{}
      },
      {
        'title': "Meteorological Scholarship",
        'subTitle': "This is Subtitle 3",
        'imagePath': "assets/sidemenu/scholarships_uae.jpg",
        "onTap": ()=>{}
      },
    ];

    // Map JSON data to models
    for (var map in scoProgramsMapList) {
      _scoProgramsModelsList.add(ScoProgramTileModel.fromJson(map));
    }

    // // Create widgets based on models
    // for (var model in _scoProgramsModelsList) {
    //   _scholarshipsInUaeList.add(
    //     CustomScoProgramTile(
    //       imagePath: model.imagePath!,
    //       title: model.title!,
    //       subTitle: model.subTitle!,
    //       onTap: model.onTap!,
    //     ),
    //   );
    // }
   final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);

    String  getPageUrl(type)
    {
      switch(type){
        case 'SCOUGRDINT':
          return "${AppUrls.commonBaseUrl}ar/web/sco/scholarship-whithin-the-uae/bachelor-s-degree-scholarship";
        case 'SCOPGRDINT':
          return "${AppUrls.commonBaseUrl}ar/web/sco/scholarship-within-uae/graduate-studies-scholarship";
        case 'SCOMETLOGINT':
          return "${AppUrls.commonBaseUrl}ar/web/sco/scholarship-whithin-the-uae/meteorological-scholarship";
        default:
          return "";

      }
    }
    for (var model in academicCareerMenuItemList!) {
      _scholarshipsInUaeList.add(
        CustomScoProgramTile(
          imagePath: "assets/sidemenu/scholarships_uae.jpg",
          title: getTextDirection(langProvider) == TextDirection.ltr ? model?.configurationNameEng : model?.configurationName ?? '',
          subTitle:"",
          onTap: (){
            _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> WebView(url: getPageUrl(model?.configurationKey ?? ''),scholarshipType: 'INT',)));
          },
        ),
      );
    }
  }


  Widget _buildUI() {
    final provider = Provider.of<LanguageChangeViewModel>(context);


   return Consumer<GetAllActiveScholarshipsViewModel>(

     builder: (context,provider,_){

       return provider.apiResponse.status == Status.LOADING
           ? Utils.pageLoadingIndicator(context: context)
       : Padding(
         padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
         child: ListView.builder(
           itemCount: _scholarshipsInUaeList.length ?? 0,
           itemBuilder: (context, index) {
             final scholarshipType = _scholarshipsInUaeList[index];
             return Padding(
               padding:  EdgeInsets.only(bottom: kPadding),
               child: scholarshipType,
             );
           },
         ),
       );
     },

   );


  }
}
