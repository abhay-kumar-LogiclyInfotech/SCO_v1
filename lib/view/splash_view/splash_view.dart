import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/viewModel/splash_viewModels/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    context.read<SplashViewModel>().checkUserAuthentication(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/splash_bg.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: SvgPicture.asset(
                "assets/sco_logo.svg",
                fit: BoxFit.fill,
                height: 55,
                width: 110,
              ),
            ),
          ),
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SpinKitSpinningLines(
                    color: AppColors.scoThemeColor,
                    size: 50.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
