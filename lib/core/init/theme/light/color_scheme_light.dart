import 'package:flutter/cupertino.dart';

class ColorSchemeLight {
  static ColorSchemeLight _instace;
  static ColorSchemeLight get instance {
    if (_instace == null) _instace = ColorSchemeLight._init();
    return _instace;
  }

  ColorSchemeLight._init();

  final Color white = Color(0xffffffff);
  final Color lightGray = Color(0xffc4c4c4);
  final Color darkGray = Color(0xffbababa);
  final Color green = Color(0xff2ecc71);
  final Color black = Color(0xff020306);
  final Color red = Color(0xffe84545);
  final Color bg = Color(0xff141e30);
  final Color bottomSheetBg = Color(0xff242e40);
  final Color defaultCard = Color(0xff5ba19b);

  final Color netflixColor = Color(0xffE50914);
  final Color spotifyColor = Color(0xff1DB954);
}
