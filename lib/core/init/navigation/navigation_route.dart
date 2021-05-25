import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasarim_proje/view/widgets/no_internet.dart';

import '../../../view/bottom_nav_bar.dart';
import '../../../view/myList/mylist_view.dart';
import '../../../view/onboard/onboard_view.dart';
import '../../../view/profile/profile_view.dart';
import '../../../view/splash_screen/splash_view.dart';
import '../../../view/timing/timing_view.dart';
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
      case NavigationConstants.ONBOARD:
        return normalNavigate(OnBoardView());
      case NavigationConstants.SPLASH:
        return normalNavigate(SplashView());
      case NavigationConstants.HOME:
        return normalNavigate(BottomBar());
      case NavigationConstants.MYLIST:
        return normalNavigate(MyListView());
      case NavigationConstants.TIMING:
        return normalNavigate(TimingView());
      case NavigationConstants.PROFILE:
        return normalNavigate(ProfileView());
      case NavigationConstants.NOINTERNET:
        return normalNavigate(NoInternet());

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
