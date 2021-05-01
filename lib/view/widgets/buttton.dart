import 'package:flutter/material.dart';

import '../../core/init/extensions/context_extension.dart';
import '../../core/init/theme/app_theme_light.dart';
import '../../core/widgets/locale_text.dart';

class AppButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final EdgeInsets padding;
  final Function ontap;

  const AppButton(
      {Key key, this.width, this.height, this.text, this.padding, this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Stack(alignment: Alignment.center, children: [
          Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color: AppThemeLight.instance.colorSchemeLight.lightGray,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: AppThemeLight.instance.colorSchemeLight.green,
                  blurRadius: 5,
                  offset: Offset(5, 5),
                ),
              ],
            ),
          ),
          LocaleText(
            value: text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: context.colors.primaryVariant,
                ),
          ),
        ]),
        onTap: ontap);
  }
}
