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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class BachelorsInUaeView extends StatefulWidget {
  const BachelorsInUaeView({super.key});

  @override
  State<BachelorsInUaeView> createState() => _BachelorsInUaeViewState();
}

class _BachelorsInUaeViewState extends State<BachelorsInUaeView>
    with MediaQueryMixin<BachelorsInUaeView> {
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
  void _initializeScoPrograms() {
    final localization = AppLocalizations.of(context)!;
    final scoProgramsMapList = [
      {
        'title': localization.internalBachelor,
        'subTitle': "This is Subtitle 1",
        'imagePath': "assets/sidemenu/scholarships_uae.jpg",
        "onTap": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute( WebView(url: "url",scholarshipType: 'INT',),),
        ),
      },
      {
        'title': localization.internalPostgraduate,
        'subTitle': "This is Subtitle 2",
        'imagePath': "assets/sidemenu/scholarships_uae.jpg",
        "onTap": ()=>{}
      },
      {
        'title': localization.internalMeterological,
        'subTitle': "يوفر مكتب البعثات الدراسية من خلال برنامج المنح الدراسية بوزارة شؤون الرئاسة للطلاب المتفوقين في الثانوية العامة منحًا دراسية كاملة في مجالات الأرصاد الجوية.",
        'imagePath': "assets/sidemenu/scholarships_uae.jpg",
        "onTap": ()=>{}
      },
    ];

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
