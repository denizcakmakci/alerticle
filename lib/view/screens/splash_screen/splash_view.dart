import 'package:flutter/material.dart';

import '../../../core/base/base_view.dart';
import '../../../core/init/extensions/context_extension.dart';
import 'splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      viewModel: SplashViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, SplashViewModel value) => Scaffold(
        backgroundColor: context.colors.background,
        body: Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/appIcon/icon.png',
              height: 100,
              width: 100,
            )),
      ),
    );
  }
}
