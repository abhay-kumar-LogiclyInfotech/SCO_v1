import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sco_v1/view/account_view.dart';
import 'package:sco_v1/view/home_view.dart';
import 'package:sco_v1/view/information_view.dart';
import 'package:sco_v1/view/message_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool home = true;
  bool information = false;
  bool message = false;
  bool account = false;

  List<dynamic> screens = [
    const HomeView(),
    const InformationView(),
    const MessageView(),
    const AccountView()
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
      bottomNavigationBar: Material(
        color: Colors.white,
        elevation: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        home = false;
                        information = false;
                        message = false;
                        account = true;
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.sizeOf(context).width * .25,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 30,
                              child: SvgPicture.asset(
                                message
                                    ? "assets/account.svg"
                                    : "assets/account.svg",
                              )),
                          Text(
                            "Account",
                            style: TextStyle(
                                color: account
                                    ? Colors.black
                                    : const Color(0xfff9AA6B2),
                                fontSize: 12,
                                fontWeight:
                                    account ? FontWeight.w900 : FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        home = false;
                        information = false;
                        message = true;
                        account = false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * .25,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 30,
                              child: SvgPicture.asset(
                                message
                                    ? "assets/message.svg"
                                    : "assets/message.svg",
                              )),
                          Text(
                            "Message",
                            style: TextStyle(
                                color: message
                                    ? Colors.black
                                    : const Color(0xfff9AA6B2),
                                fontSize: 12,
                                fontWeight:
                                    message ? FontWeight.w900 : FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        home = false;
                        information = true;
                        message = false;
                        account = false;
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.sizeOf(context).width * .25,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 30,
                              child: SvgPicture.asset(
                                message
                                    ? "assets/information.svg"
                                    : "assets/information.svg",
                              )),
                          Text(
                            "Information",
                            style: TextStyle(
                                color: information
                                    ? Colors.black
                                    : const Color(0xfff9AA6B2),
                                fontSize: 12,
                                fontWeight: information
                                    ? FontWeight.w900
                                    : FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        home = true;
                        information = false;
                        message = false;
                        account = false;
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.sizeOf(context).width * .25,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 30,
                              child: SvgPicture.asset(
                                home
                                    ? "assets/home_selected.svg"
                                    : "assets/home_selected.svg",
                              )),
                          Text(
                            "Home",
                            style: TextStyle(
                                color: home
                                    ? Colors.black
                                    : const Color(0xfff9AA6B2),
                                fontSize: 12,
                                fontWeight:
                                    home ? FontWeight.w900 : FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUI() {
    if (account) {
      return screens[3];
    }
    if (message) {
      return screens[2];
    }
    if (information) {
      return screens[1];
    }

    return screens[0];
  }
}
