import 'package:flutter/material.dart';

import '../../device/constants.dart';
import 'app_theme.dart';
import 'light/light_theme_interface.dart';

class AppThemeLight extends AppTheme with ILightTheme {
  static AppThemeLight _instance;
  static AppThemeLight get instance {
    return _instance ??= AppThemeLight._init();
  }

  AppThemeLight._init();

  @override
  ThemeData get theme => ThemeData(
        fontFamily: AppConstant.FONT_FAMILY,
        colorScheme: _appColorScheme,
        textTheme: textTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dialogTheme: DialogTheme(
            backgroundColor: _appColorScheme.surface,
            contentTextStyle:
                TextStyle(color: _appColorScheme.primary, fontSize: 16),
            titleTextStyle:
                TextStyle(color: _appColorScheme.primary, fontSize: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        inputDecorationTheme: InputDecorationTheme(
            focusColor: Colors.black12,
            labelStyle: TextStyle(),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            filled: true,
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(width: 0.3)),
            // border: OutlineInputBorder(borderSide: BorderSide(width: 0.3)),
            focusedBorder: OutlineInputBorder()),
        iconTheme: IconThemeData(
          color: colorSchemeLight.lightGray,
          size: 24,
        ),
        scaffoldBackgroundColor: _appColorScheme.background,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.transparent,
        ),
        buttonTheme: ThemeData.light().buttonTheme.copyWith(
              colorScheme: ColorScheme.light(
                onError: Color(0xffFF2D55),
              ),
            ),
      );

  TextTheme textTheme() {
    return ThemeData.light().textTheme.copyWith(
          headline1: textThemeLight.headline1,
          bodyText1: textThemeLight.text1,
        );
  }

  ColorScheme get _appColorScheme {
    return ColorScheme(
        primary: colorSchemeLight.lightGray,
        primaryVariant: Colors.black,
        secondary: colorSchemeLight.white,
        secondaryVariant: colorSchemeLight.black,
        surface: colorSchemeLight.bottomSheetBg,
        background: colorSchemeLight.bg,
        error: colorSchemeLight.red,
        onPrimary: colorSchemeLight.defaultCard,
        onSecondary: colorSchemeLight.green,
        onSurface: Colors.white30,
        onBackground: Colors.black12,
        onError: Color(0xFFF9B916),
        brightness: Brightness.light);
  }
}
