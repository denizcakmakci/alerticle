import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/base/base_view_model.dart';
import '../../core/device/constants.dart';
import '../../core/init/extensions/context_extension.dart';

part 'splash_view_model.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  //internet connection check
  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        if (localeManager.getBoolValue(PreferencesKeys.IS_FIRST_APP) == false) {
          navigation.navigateToPageClear(path: NavigationConstants.ONBOARD);
        } else {
          navigation.navigateToPageClear(path: NavigationConstants.HOME);
        }
      }
    } on SocketException catch (_) {
      print('not connected');
      navigation.navigateToPageClear(path: NavigationConstants.NOINTERNET);
    }
  }

  @override
  void init() {
    Future.delayed(context.normalDuration, () async {
      checkInternet();
    });
  }
}
