import 'package:flutter/rendering.dart';

class AppConstant {
  static const SUPPORTED_LOCALE = [
    AppConstant.EN_LOCALE,
    AppConstant.TR_LOCALE,
  ];
  static const TR_LOCALE = Locale("tr", "TR");
  static const EN_LOCALE = Locale("en", "US");
  static const LANG_PATH = "assets/language";
  static const FONT_FAMILY = 'NUNITO';
}

enum PreferencesKeys { IS_FIRST_APP, TOKEN } // shared_preferences

class NavigationConstants {
  static const String HOME = "/bottom_navigation";
  static const String ONBOARD = "/onboard";
  static const String SPLASH = "/splash_screen";
  static const String PROFILE = "/profile";
  static const String MYLIST = "/myList";
  static const String TIMING = "/timing";
  static const String NOINTERNET = "/no_internet";
}
