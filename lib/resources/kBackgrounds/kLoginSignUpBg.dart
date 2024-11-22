import 'package:flutter/cupertino.dart';

import '../app_colors.dart';

class KLoginSignupBg extends StatelessWidget {
  const KLoginSignupBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(color: AppColors.darkGrey,),
      Image.asset(
        'assets/login_bg.png',
        fit: BoxFit.contain,
        // height: double.infinity,
        width: double.infinity,
      ),
    ],);
  }
}
