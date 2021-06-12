import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../detail/detail_view.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/device/constants.dart';

import '../../../core/init/extensions/context_extension.dart';

part 'splash_view_model.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  //internet connection check
  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        if (localeManager.getBoolValue(PreferencesKeys.IS_FIRST_APP) == false) {
          navigation.navigateToPageClear(path: NavigationConstants.ONBOARD);
        } else {
          firebaseMessagingHandler();
        }
      }
    } on SocketException catch (_) {
      print('not connected');
      navigation.navigateToPageClear(path: NavigationConstants.NOINTERNET);
    }
  }

  navigate(RemoteMessage message) {
    Navigator.of(NavigationService.instance.navigatorKey.currentContext)
        .push(MaterialPageRoute(
            builder: (context) => DetailView(),
            settings: RouteSettings(
              arguments: {'type': message.data['type']},
            )));
  }

  //Cloud messaging configure
  Future<void> firebaseMessagingHandler() async {
    await Firebase.initializeApp();
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      navigate(initialMessage);
    } else {
      navigation.navigateToPageClear(path: NavigationConstants.HOME);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      navigate(initialMessage);
    });
  }

  @override
  Future<void> init() async {
    await Future.delayed(context.normalDuration, () async {
      checkInternet();
    });
  }
}
