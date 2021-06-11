import 'package:flutter/cupertino.dart';

class NavigationService {
  static NavigationService _instace;
  static NavigationService get instance {
    if (_instace == null) _instace = NavigationService._init();
    return _instace;
  }

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final removeAllOldRoutes = (Route<dynamic> route) => false;

  Future<void> navigateToPage({String path, String data}) async {
    await navigatorKey.currentState.pushNamed(path, arguments: data);
  }

  Future<void> navigateToPageClear({String path, Object data}) async {
    await navigatorKey.currentState
        .pushNamedAndRemoveUntil(path, removeAllOldRoutes, arguments: data);
  }
}
