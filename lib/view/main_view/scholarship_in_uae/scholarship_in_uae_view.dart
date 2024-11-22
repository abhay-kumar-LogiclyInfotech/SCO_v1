import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../models/home/ScoProgramsTileModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../../viewModel/services/navigation_services.dart';

class ScholarshipsInUaeView extends StatefulWidget {
  const ScholarshipsInUaeView({super.key});

  @override
  State<ScholarshipsInUaeView> createState() => _ScholarshipsInUaeViewState();
}

class _ScholarshipsInUaeViewState extends State<ScholarshipsInUaeView>
    with MediaQueryMixin<ScholarshipsInUaeView> {
  late NavigationServices _navigationServices;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _initializeScoPrograms();
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
        "onTap": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const ScholarshipsInUaeView()),
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

    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
      child: ListView.builder(
        itemCount: _scholarshipsInUaeList.length,
        itemBuilder: (context, index) {
          final scholarshipType = _scholarshipsInUaeList[index];
          return Padding(
            padding:  EdgeInsets.only(bottom: kPadding),
            child: scholarshipType,
          );
        },
      ),
    );
  }
}
