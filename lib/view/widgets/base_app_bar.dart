import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/init/extensions/context_extension.dart';
import '../../core/init/theme/app_theme_light.dart';
import '../../core/widgets/locale_text.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.black26;
  final String title;
  final List<Widget> widgets;
  final Widget widget;

  const BaseAppBar({Key key, this.title, this.widgets, this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black26),
      //automaticallyImplyLeading: false,
      titleSpacing: 30,
      leading: widget,
      title: LocaleText(
        value: title,
        style: TextStyle(fontSize: 24, color: context.colors.primary),
      ),
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
