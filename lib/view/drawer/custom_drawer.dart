import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import '../../resources/app_colors.dart';
import '../../viewModel/services/navigation_services.dart';

class CustomDrawer extends StatefulWidget {
  final String? userName;
  final String? userEmail;
  final String? userProfileImageLink;

  const CustomDrawer({
    super.key,
    this.userName,
    this.userEmail,
    this.userProfileImageLink,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late NavigationServices _navigationServices;
  @override
  void initState() {
    super.initState();
    final GetIt _getIt = GetIt.instance;

    _navigationServices = _getIt.get<NavigationServices>();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      backgroundColor: AppColors.scoButtonColor,
      // shadowColor: const Color(0xffffffff),
      elevation: 1,
      width: MediaQuery.sizeOf(context).width * 0.75,

      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context)
                      .width, // height: MediaQuery.sizeOf(context).height / 5.8,
                  // decoration: const BoxDecoration(
                  //     color: Color(0xff4F545A),
                  //     borderRadius: BorderRadius.only(
                  //         bottomLeft: Radius.circular(0),
                  //         bottomRight: Radius.circular(0),)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            // "images/images_user_sidebar/Ellipse 28.png",
                            widget.userProfileImageLink ??
                                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                            fit: BoxFit.cover,
                            height: MediaQuery.sizeOf(context).width / 7,
                            width: MediaQuery.sizeOf(context).width / 7,
                            errorBuilder: (context, object, _) {
                              return SvgPicture.asset(
                                "images/images_user_sidebar/profile.svg",
                                fit: BoxFit.cover,
                                height: MediaQuery.sizeOf(context).width / 7,
                                width: MediaQuery.sizeOf(context).width / 7,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 28,
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).width * 0.12,
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.userName ?? "User Name",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                  child: SelectableText(
                                    widget.userEmail ?? "User Email",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.65)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        // minTileHeight: MediaQuery.of(context).size.width * 0.12,
                        title: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        leading: SvgPicture.asset("assets/name.svg"),
                        dense: true,
                        horizontalTitleGap: 5,
                        onTap: () {
                          _navigationServices.goBack();
                        },
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.25))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        // minTileHeight: MediaQuery.of(context).size.width * 0.12,
                        title: const Text(
                          "Home",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        leading: SvgPicture.asset("assets/name.svg"),
                        dense: true,
                        horizontalTitleGap: 5,
                        onTap: () {
                          _navigationServices.goBack();
                        },
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.25))),
                      ),
                    ),


                    // Will be used in Phase 2
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ExpansionTile(
                        dense: true,
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.25))),
                        collapsedShape: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.25))),
                        tilePadding: EdgeInsets.zero,
                        leading: SvgPicture.asset("assets/name.svg"),
                        title: const Text(
                          "About Us",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _navigationServices.goBack();
                              _navigationServices
                                  .pushNamed('/createTicketView');
                            },
                            child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.all(8),
                                // width: MediaQuery.sizeOf(context).width * 0.3,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                    ),
                                    SvgPicture.asset(
                                        "images/images_sponser_sidebar/deposit_dropdown.svg"),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Create Ticket",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              _navigationServices.goBack();
                              _navigationServices.pushNamed('/myTicketView');
                            },
                            child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.all(8),
                                // width: MediaQuery.sizeOf(context).width * 0.3,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                    ),
                                    SvgPicture.asset(
                                        "images/images_sponser_sidebar/deposit_dropdown.svg"),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "My Tickets",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        // minTileHeight: MediaQuery.of(context).size.width * 0.12,
                        title: const Text(
                          "SCO Programs",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        leading: SvgPicture.asset("assets/name.svg"),
                        dense: true,
                        horizontalTitleGap: 5,
                        onTap: () {
                          _navigationServices.goBack();
                        },
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.25))),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        // minTileHeight: MediaQuery.of(context).size.width * 0.12,
                        title: const Text(
                          "News",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        leading: SvgPicture.asset("assets/name.svg"),
                        dense: true,
                        horizontalTitleGap: 5,
                        onTap: () {
                          _navigationServices.goBack();
                        },
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.25))),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        // minTileHeight: MediaQuery.of(context).size.width * 0.12,
                        title: const Text(
                          "Contact",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        leading: SvgPicture.asset("assets/name.svg"),
                        dense: true,
                        horizontalTitleGap: 5,
                        onTap: () {
                          _navigationServices.goBack();
                        },
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.25))),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
