import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

import '../core/init/extensions/context_extension.dart';
import '../core/init/extensions/extensions.dart';
import '../core/init/lang/locale_keys.g.dart';
import 'myList/mylist_view.dart';
import 'profile/profile_view.dart';
import 'timing/timing_view.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
          barBackgroundColor: context.colors.background,
          circleColor: context.colors.onPrimary,
          inactiveIconColor: context.colors.onPrimary,
          textColor: context.colors.primary,
          tabs: [
            TabData(
              iconData: Icons.list,
              title: LocaleKeys.bottomNavBar_mylist.locale,
            ),
            TabData(
              iconData: Icons.alarm,
              title: LocaleKeys.bottomNavBar_timing.locale,
            ),
            TabData(
              iconData: Icons.person,
              title: LocaleKeys.bottomNavBar_profile.locale,
            )
          ],
          initialSelection: 0,
          key: bottomNavigationKey,
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          }),
    );
  }
}

_getPage(int page) {
  switch (page) {
    case 0:
      return MyListView();
    case 1:
      return TimingView();
    default:
      return ProfileView();
  }
}
