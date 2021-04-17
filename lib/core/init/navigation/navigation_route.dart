import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../view/bottom_navigation.dart';
import '../../../view/myList/mylist_view.dart';
import '../../../view/onboard/onboard_view.dart';
import '../../../view/profile/profile_view.dart';
import '../../../view/splash_screen/splash_view.dart';
import '../../../view/test/test.dart';
import '../../device/constants.dart';

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
      case NavigationConstants.PROFILE:
        return normalNavigate(ProfileView());
      case NavigationConstants.MYLIST:
        return normalNavigate(MyListView());
      case NavigationConstants.HOME:
        return normalNavigate(BottomNavigation());

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
