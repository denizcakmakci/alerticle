import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/init/theme/app_theme_light.dart';
import '../../core/widgets/locale_text.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.transparent;
  final LocaleText title;
  final List<Widget> widgets;
  final Widget widget;

  const BaseAppBar({Key key, @required this.title, this.widgets, this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      automaticallyImplyLeading: false,
      leading: widget,
      title: title,
      backgroundColor: backgroundColor,
      actions: widgets,
      iconTheme: IconThemeData(
          color: AppThemeLight.instance.colorSchemeLight.lightGray, size: 24),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
