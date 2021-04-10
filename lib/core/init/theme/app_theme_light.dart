import 'package:flutter/material.dart';
import 'package:tasarim_proje/core/device/constants.dart';
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
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
            brightness: Brightness.light,
            color: Colors.transparent,
            titleTextStyle: textThemeLight.headline1,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.transparent, size: 24)),
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
        scaffoldBackgroundColor: _appColorScheme.background,
        floatingActionButtonTheme:
            ThemeData.light().floatingActionButtonTheme.copyWith(),
        buttonTheme: ThemeData.light().buttonTheme.copyWith(
              colorScheme: ColorScheme.light(
                onError: Color(0xffFF2D55),
              ),
            ),
      );

  TextTheme textTheme() {
    return ThemeData.light().textTheme.copyWith(
        headline1: textThemeLight.headline1, bodyText1: textThemeLight.text1);
  }

  ColorScheme get _appColorScheme {
    return ColorScheme(
        primary: colorSchemeLight.lightGray,
        primaryVariant: Colors.black,
        secondary: colorSchemeLight.white,
        secondaryVariant: colorSchemeLight.black,
        surface: Colors.blue,
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
