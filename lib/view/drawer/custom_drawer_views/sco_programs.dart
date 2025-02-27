import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/web_view.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../models/home/ScoProgramsTileModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_urls.dart';
import '../../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../main_view/scholarship_in_abroad/scholarship_in_abroad_view.dart';
import '../../main_view/scholarship_in_uae/scholarship_in_uae_view.dart';

class ScoPrograms extends StatefulWidget {
  const ScoPrograms({super.key});

  @override
  State<ScoPrograms> createState() => _ScoProgramsState();
}

class _ScoProgramsState extends State<ScoPrograms>
    with MediaQueryMixin<ScoPrograms> {
  late NavigationServices _navigationServices;
  final List<Widget> _scoProgramsList = [];
  final List<ScoProgramTileModel> _scoProgramsModelsList = [];

  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _scoProgramsModelsList.clear();
    _scoProgramsList.clear();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      final localization = AppLocalizations.of(context);
      _initializeScoPrograms(localization);
    });

  }


  void _initializeScoPrograms(AppLocalizations? localization) {
    final scoProgramsMapList = [
      {
        'title': localization?.scholarshipInternal,
        'subTitle': localization?.internalScholarshipDesc,
        'imagePath': "assets/sidemenu/scholarships_uae.jpg",
       "onTap": () => _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>  ScholarshipsInUaeView()))
      },
    {
    'title': localization?.scholarshipExternal,
    'subTitle': localization?.externalScholarshipDesc,
    'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
      "onTap": () => _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>  ScholarshipInAbroadView()))
      },
    ];

    // Map JSON data to models
    for (var map in scoProgramsMapList) {
      _scoProgramsModelsList.add(ScoProgramTileModel.fromJson(map));
    }

    // Create widgets based on models
    for (var model in _scoProgramsModelsList) {
      _scoProgramsList.add(
        CustomScoProgramTile(
          imagePath: model.imagePath ?? '',
          title: model.title ?? '',
          subTitle: model.subTitle ?? '',
          onTap: model.onTap ?? (){},
        ),
      );
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
        title: Text(
          AppLocalizations.of(context)!.scoPrograms,
          style: AppTextStyles.appBarTitleStyle(),
        ),
      ),
      body:  _buildUI()
    );
  }

  Widget _buildUI() {
    return Padding(
      padding:  EdgeInsets.all(kPadding),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _scoProgramsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: kTileSpace),
            child: _scoProgramsList[index],
          );
        },
      ),
    );
  }
}
