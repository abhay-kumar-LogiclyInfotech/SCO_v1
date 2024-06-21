
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view/splash_view/splash_view.dart';
import '../../view/authentication/login_view.dart';

class NavigationServices {
//Creating the global key for navigation State:
  late GlobalKey<NavigatorState> _navigationStateKey;

  NavigationServices() {
    _navigationStateKey = GlobalKey<NavigatorState>();
  }

  GlobalKey<NavigatorState> get navigationStateKey => _navigationStateKey;

  //Creating Routes for the application:
  final Map<String, Widget Function(BuildContext context)> _routes = {
    "/splashView" : (context)=> const SplashView(),
    "/loginView" : (context)=> const LoginView(),
  };

  //Creating getter to the routes of the application:

  Map<String, Widget Function(BuildContext context)> get routes => _routes;

  void push(MaterialPageRoute route) {
    _navigationStateKey.currentState!.push(route);
  }

  void pushNamed(String route) {
    _navigationStateKey.currentState!.pushNamed(route);
  }

  void pushReplacementNamed(String route) {
    _navigationStateKey.currentState!.pushReplacementNamed(route);
  }

  void goBack() {
    _navigationStateKey.currentState!.pop();
  }
}
