import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasarim_proje/core/widgets/locale_text.dart';
import 'package:tasarim_proje/core/init/extensions/context_extension.dart';

class AlarmChoice extends StatelessWidget {
  final String text;
  final Function ontap;

  const AlarmChoice({Key key, this.text, this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.fromLTRB(40, 30, 40, 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LocaleText(
              value: text,
              style: TextStyle(fontSize: 20, color: context.colors.primary),
            ),
            Icon(FontAwesomeIcons.chevronRight)
          ],
        ),
      ),
      onTap: ontap,
    );
  }
}
