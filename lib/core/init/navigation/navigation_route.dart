import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasarim_proje/core/device/constants.dart';
import 'package:tasarim_proje/view/onboard/onboard_view.dart';
import 'package:tasarim_proje/view/splash_screen/splash_view.dart';
import 'package:tasarim_proje/view/test/test.dart';

class NavigationRoute {
  static NavigationRoute _instace;
  static NavigationRoute get instance {
    if (_instace == null) _instace = NavigationRoute._init();
    return _instace;
  }

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.TEST:
        return normalNavigate(Test());
      case NavigationConstants.ONBOARD:
        return normalNavigate(OnBoardView());
      case NavigationConstants.SPLASH:
        return normalNavigate(SplashView());

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Text("This page not found."),
              ),
            );
          },
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
