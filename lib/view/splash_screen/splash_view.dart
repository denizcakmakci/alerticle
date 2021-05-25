import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/image_path_svg.dart';

import '../../core/base/base_view.dart';
import 'splash_view_model.dart';
import '../../core/init/extensions/context_extension.dart';

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
        backgroundColor: context.colors.onPrimary,
        body: Container(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            SVGImagePaths.instance.flutterSVG,
          ),
        ),
      ),
    );
  }
}
