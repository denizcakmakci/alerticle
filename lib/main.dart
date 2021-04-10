import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tasarim_proje/core/device/constants.dart';
import 'package:tasarim_proje/core/init/cache/locale_manager.dart';
import 'package:tasarim_proje/core/init/lang/language_manager.dart';
import 'package:tasarim_proje/core/init/navigation/navigation_route.dart';
import 'package:tasarim_proje/core/init/navigation/navigation_service.dart';
import 'package:tasarim_proje/core/init/theme/app_theme_light.dart';
import 'package:tasarim_proje/view/onboard/onboard_view.dart';
//import 'package:tasarim_proje/view/splash_screen/splash_view.dart';
//import 'package:tasarim_proje/view/test/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  LocaleManager.prefrencesInit();

  runApp(EasyLocalization(
    supportedLocales: LanguageManager.instance.supportedLocales,
    path: AppConstant.LANG_PATH,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppThemeLight.instance.theme,
      home: OnBoardView(),
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
