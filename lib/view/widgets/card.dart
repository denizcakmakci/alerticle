import 'package:flutter/material.dart';
import 'package:tasarim_proje/core/init/theme/app_theme_light.dart';
//import 'package:tasarim_proje/core/init/theme/app_theme_light.dart';

class BaseCard extends StatelessWidget {
  final Icon icon;
  final Widget title;
  final Widget subtitle;
  //final Color color;

  const BaseCard({Key key, this.icon, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 25),
      color: AppThemeLight.instance.colorSchemeLight.defaultCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: icon,
        ),
        title: title,
        subtitle: subtitle,
        //isThreeLine: true,
        //onTap: ,
      ),
    );
  }
}
