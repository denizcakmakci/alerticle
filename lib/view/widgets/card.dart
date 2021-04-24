import 'package:flutter/material.dart';
//import 'package:tasarim_proje/core/init/theme/app_theme_light.dart';
import 'package:tasarim_proje/core/widgets/locale_text.dart';

class BaseCard extends StatelessWidget {
  final Icon icon;
  final LocaleText title;
  final LocaleText subtitle;

  const BaseCard({Key key, this.icon, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: icon,
        title: title,
        subtitle: subtitle,
      ),
    );
  }
}
