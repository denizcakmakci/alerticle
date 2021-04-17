import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/init/extensions/context_extension.dart';
import '../core/init/lang/locale_keys.g.dart';
import '../core/widgets/locale_text.dart';
import 'myList/mylist_view.dart';
import 'profile/profile_view.dart';
import 'test/test.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            MyListView(),
            Test(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        backgroundColor: Colors.transparent,
        curve: Curves.easeIn,
        showElevation: true,
        itemCornerRadius: 24,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: buildLocaleTextMyList(context),
              icon: Icon(
                Icons.list,
                size: 30,
              ),
              activeColor: context.colors.primary,
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              title: buildLocaleTextTiming(context),
              icon: Icon(Icons.alarm),
              activeColor: context.colors.primary,
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              title: buildLocaleTextProfile(context),
              icon: Icon(
                FontAwesomeIcons.userAlt,
                size: 20,
              ),
              activeColor: context.colors.primary,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget buildLocaleTextMyList(BuildContext context) {
    return LocaleText(
      value: LocaleKeys.bottomNavBar_mylist,
    );
  }

  Widget buildLocaleTextTiming(BuildContext context) {
    return LocaleText(
      value: LocaleKeys.bottomNavBar_timing,
    );
  }

  Widget buildLocaleTextProfile(BuildContext context) {
    return LocaleText(
      value: LocaleKeys.bottomNavBar_profile,
    );
  }
}
