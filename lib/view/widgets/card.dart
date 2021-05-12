import 'package:flutter/material.dart';

import '../../core/init/theme/app_theme_light.dart';

class BaseCard extends StatelessWidget {
  final Icon icon;
  final Widget title;
  final Widget subtitle;
  //final Color color;

  const BaseCard({Key key, this.icon, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppThemeLight.instance.colorSchemeLight.defaultCard,
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
