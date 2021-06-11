import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../view/bottom_nav_bar.dart';
import '../../../view/screens/detail/detail_view.dart';
import '../../../view/screens/myList/mylist_view.dart';
import '../../../view/screens/onboard/onboard_view.dart';
import '../../../view/screens/profile/profile_view.dart';
import '../../../view/screens/splash_screen/splash_view.dart';
import '../../../view/screens/timing/timing_view.dart';
import '../../../view/widgets/no_internet.dart';
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
      case NavigationConstants.DETAIL:
        return normalNavigate(DetailView());

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
