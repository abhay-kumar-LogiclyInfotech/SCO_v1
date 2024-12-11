import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';
import 'package:sco_v1/viewModel/services/auth_services.dart';

import '../../data/response/status.dart';
import '../../viewModel/notifications_view_models/get_notifications_count_viewModel.dart';
import '../../viewModel/services/navigation_services.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';
import 'custom_main_view_app_bar.dart';

class CustomSimpleAppBar extends StatefulWidget implements PreferredSizeWidget  {
   Widget? title;
  String? titleAsString;
  bool? inNotifications;
   CustomSimpleAppBar({super.key,  this.title,this.titleAsString,this.inNotifications = false});

  @override
  State<CustomSimpleAppBar> createState() => _CustomSimpleAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomSimpleAppBarState extends State<CustomSimpleAppBar> {


   bool isLoggedIn = false;

  late NavigationServices _navigationServices;
  late AuthService _authService;


  @override
  void initState() {

    final GetIt getIt  = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();


    WidgetsBinding.instance.addPostFrameCallback((callback)async{

        isLoggedIn = await _authService.isLoggedIn();
        setState(() {
        });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageChangeViewModel>(context);
    return Directionality(
      textDirection: getTextDirection(provider),
      child: AppBar(

        elevation: 0.2,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title:
      widget.titleAsString != null ?  Text(widget.titleAsString ?? '',
            style: AppTextStyles.appBarTitleStyle())

         : widget.title,

        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.scoButtonColor,
          ),
          onPressed: () {
           Navigator.of(context).pop();
          },
        ),
        actions: isLoggedIn ? [
         if(!(widget.inNotifications ?? true))Consumer<GetNotificationsCountViewModel>(
            builder: (context,provider,_){
              switch(provider.apiResponse.status){
                /// here totalNotifications is global variable which we have declared somewhere else.
                case Status.LOADING:
                  return ringBell(totalNotifications,_navigationServices);
                case Status.ERROR:
                  return ringBell(totalNotifications,_navigationServices);
                case Status.COMPLETED:
                  return ringBell(provider.apiResponse.data.toString(),_navigationServices);
                case Status.NONE:
                  return ringBell(totalNotifications,_navigationServices);
                case null:
                  return ringBell(totalNotifications,_navigationServices);
              }
            },
          ),const SizedBox(width: 25)] : [],

        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
