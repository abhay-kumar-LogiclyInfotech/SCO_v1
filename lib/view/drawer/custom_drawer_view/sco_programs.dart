import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_tile.dart';
import 'package:sco_v1/utils/utils.dart';

import '../../../resources/app_colors.dart';
import '../../../viewModel/services/navigation_services.dart';

class ScoPrograms extends StatefulWidget {
  const ScoPrograms({super.key});

  @override
  State<ScoPrograms> createState() => _ScoProgramsState();
}

class _ScoProgramsState extends State<ScoPrograms>
    with MediaQueryMixin<ScoPrograms> {
  late NavigationServices _navigationService;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationService = getIt.get<NavigationServices>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scoBgColor,
      appBar: _appBar(),
      body: _buildUI(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "SCO Programs",
        style: AppTextStyles.appBarTitleStyle(),
      ),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.scoButtonColor,
        ),
        onPressed: () {
          _navigationService.goBack();
        },
      ),
      centerTitle: true,
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomTile(
              imagePath: "assets/sidemenu/scholarships_uae.jpg",
              title: "Scholarships In UAE",
              subTitle:
                  "The office, which was established in 1999 under the direct..",
              onTap: () {},
            ),

            CustomTile(
              imagePath: "assets/sidemenu/scholarships_uae.jpg",
              title: "Scholarships In UAE",
              subTitle:
              "The office, which was established in 1999 under the direct..",
              onTap: () {},
            ),


            CustomTile(
              imagePath: "assets/sidemenu/scholarships_uae.jpg",
              title: "Scholarships In UAE",
              subTitle:
              "The office, which was established in 1999 under the direct..",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
