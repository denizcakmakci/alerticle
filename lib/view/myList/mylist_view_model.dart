import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
//import 'package:tasarim_proje/core/device/constants.dart';
//import 'package:tasarim_proje/core/init/navigation/navigation_service.dart';

import '../../core/base/base_view_model.dart';

part 'mylist_view_model.g.dart';

class MyListViewModel = _MyListViewModelBase with _$MyListViewModel;

abstract class _MyListViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (localeManager.getStringValue(PreferencesKeys.TOKEN).isNotEmpty) {
    //     NavigationService.instance.navigateToPage(path: NavigationConstants.ONBOARD);
    //   }
    // });
  }
}
