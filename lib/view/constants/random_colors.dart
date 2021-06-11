import 'dart:math';

import 'package:flutter/material.dart';

class GradientColors {
  final List<dynamic> colors;
  GradientColors(this.colors);

  static List<String> sky = ['0xFF6448FE', '0xFF5FC6FF'];
  static List<String> sunset = ['0xFFFE6197', '0xFFFFB463'];
  static List<String> sea = ['0xFF61A3FE', '0xFF63FFD5'];
  static List<String> mango = ['0xFFFFA738', '0xFFFFE130'];
  static List<String> fire = ['0xFFFF5DCD', '0xFFFF8484'];
  static List<String> orange = ['0xFFfc4a1a', '0xFFf7b733'];
  static List<String> pink = ['0xFFCF8BF3', '0xFFFDB99B'];
  static List<String> cherry = ['0xFFEB3349', '0xFFF45C43'];
  static List<String> seaBlue = ['0xFF2b5876', '0xFF4e4376'];
  static List<String> bang = ['0xFF007991', '0xFF78ffd6'];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
    GradientColors(GradientColors.orange),
    GradientColors(GradientColors.pink),
    GradientColors(GradientColors.cherry),
    GradientColors(GradientColors.seaBlue),
    GradientColors(GradientColors.bang),
  ];
  int randomindex = Random().nextInt(gradientTemplate.length);
}

class RandomColors {
  static List<Color> randomTemplate = [
    Color(0xFF6448FE),
    Color(0xFF5FC6FF),
    Color(0xFFFFA738),
    Color(0xFF63FFD5),
    Color(0xFFFE6197),
  ];
  int randomindex = Random().nextInt(randomTemplate.length);
}
