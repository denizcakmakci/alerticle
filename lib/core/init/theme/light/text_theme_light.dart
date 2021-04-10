import 'package:flutter/material.dart';

class TextThemeLight {
  static TextThemeLight _instace;
  static TextThemeLight get instance {
    if (_instace == null) _instace = TextThemeLight._init();
    return _instace;
  }

  TextThemeLight._init();

  final TextStyle headline1 = TextStyle(
    fontSize: 24,
    //fontWeight: FontWeight.w400,
  );
  final TextStyle overline =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5);
  final TextStyle text1 = TextStyle(fontSize: 18);
  final TextStyle text2 = TextStyle(fontSize: 16);
}
