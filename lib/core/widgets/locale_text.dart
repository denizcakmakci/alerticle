import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tasarim_proje/core/init/extensions/extensions.dart';

class LocaleText extends StatelessWidget {
  final String value;
  final TextStyle style;
  final TextAlign textAlign;

  const LocaleText({Key key, @required this.value, this.style, this.textAlign})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      value.locale,
      textAlign: textAlign,
      style: style,
    );
  }
}
