import 'package:flutter/material.dart';
import 'package:tasarim_proje/core/init/lang/locale_keys.g.dart';
import 'package:tasarim_proje/core/widgets/locale_text.dart';
import 'package:tasarim_proje/view/splash_screen/splash_view_model.dart';
import 'package:tasarim_proje/view/widgets/buttton.dart';
import 'package:tasarim_proje/core/init/extensions/extensions.dart';
import 'package:tasarim_proje/core/init/extensions/context_extension.dart';

SplashViewModel model = SplashViewModel();

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 150),
              child: Image(image: AssetImage('assets/png/noConnection.png')),
            ),
            Text(
              'Ooops!',
              style: TextStyle(color: context.colors.primary, fontSize: 30),
            ),
            SizedBox(
              height: 30,
            ),
            LocaleText(
              value: LocaleKeys.noInternet_subtitle1,
              style: TextStyle(color: context.colors.primary, fontSize: 20),
            ),
            LocaleText(
                value: LocaleKeys.noInternet_subtitle2,
                style: TextStyle(color: context.colors.primary, fontSize: 20)),
            SizedBox(
              height: 50,
            ),
            AppButton(
              width: 150,
              height: 50,
              text: LocaleKeys.noInternet_button_title.locale,
              ontap: () {
                model.checkInternet();
              },
            )
          ],
        ),
      ),
    );
  }
}
