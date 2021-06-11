import 'package:flutter/material.dart';
import '../../core/widgets/locale_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final EdgeInsets padding;
  final Function ontap;

  const AppButton({Key key, this.text, this.padding, this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [Color(0xff11998e), Color(0xFF38ef7d)]),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: padding,
      child: TextButton(
        onPressed: ontap,
        child: LocaleText(
          value: text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
