import 'package:flutter/material.dart';

import '../../view/screens/detail/detail_view.dart';
import '../init/cache/locale_manager.dart';
import '../init/navigation/navigation_service.dart';

abstract class BaseViewModel {
  BuildContext context;

  LocaleManager localeManager = LocaleManager.instance;
  NavigationService navigation = NavigationService.instance;

  void setContext(BuildContext context);

  goDetailPagewithType(String type) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailView(),
            settings: RouteSettings(
              arguments: {'type': type},
            )));
  }

  void init();
}
