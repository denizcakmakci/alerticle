import 'package:flutter/material.dart';
import 'package:tasarim_proje/core/base/base_view.dart';
import 'package:tasarim_proje/view/splash_screen/splash_view_model.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      viewModel: SplashViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, SplashViewModel value) => Scaffold(
        backgroundColor: Colors.blue,
      ),
    );
  }
}
