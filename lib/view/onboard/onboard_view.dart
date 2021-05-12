import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasarim_proje/view/constants/image_path_svg.dart';

import '../../core/base/base_view.dart';
import '../../core/init/extensions/context_extension.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/services/google_signin.dart';
import '../../core/widgets/locale_text.dart';
import '../widgets/on_board_circle.dart';
import 'onboard_model.dart';
import 'onboard_view_model.dart';

class OnBoardView extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return BaseView<OnBoardViewModel>(
      viewModel: OnBoardViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, OnBoardViewModel viewModel) =>
          Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Expanded(flex: 5, child: buildPageView(viewModel)),
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: context.paddingMediumHorizontal,
                      alignment: Alignment.topLeft,
                      child: buildListViewCircles(viewModel))),
              Expanded(flex: 1, child: bottomButtons(context, viewModel))
            ],
          ),
        ),
      ),
    );
  }

  PageView buildPageView(OnBoardViewModel viewModel) {
    return PageView.builder(
        controller: _pageController,
        itemCount: viewModel.onBoardItems.length,
        onPageChanged: (value) {
          viewModel.changeCurrentIndex(value);
        },
        itemBuilder: (context, index) =>
            buildColumnBody(context, viewModel.onBoardItems[index]));
  }

  Column buildColumnBody(BuildContext context, OnBoardModel model) {
    return Column(
      children: [
        buildColumnInfo(context, model),
        Expanded(
            child: Container(
                margin: EdgeInsets.all(30),
                child: buildSvgPicture(model.image))),
      ],
    );
  }

  Column buildColumnInfo(BuildContext context, OnBoardModel model) {
    return Column(
      children: [
        buildLocaleTextTitle(model, context),
        SizedBox(
          height: 35,
        ),
        Padding(
            padding: context.paddingMediumHorizontal,
            child: buildLocaleTextDescription(model, context))
      ],
    );
  }

  LocaleText buildLocaleTextTitle(OnBoardModel model, BuildContext context) {
    return LocaleText(
      value: model.title,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.secondary,
          ),
    );
  }

  LocaleText buildLocaleTextDescription(
      OnBoardModel model, BuildContext context) {
    return LocaleText(
      value: model.description,
      textAlign: TextAlign.left,
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(color: context.colors.primary),
    );
  }

  ListView buildListViewCircles(OnBoardViewModel viewModel) {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Observer(builder: (_) {
          return OnBoardCircle(
            isSelected: viewModel.currentIndex == index,
          );
        });
      },
    );
  }

  Widget bottomButtons(BuildContext context, OnBoardViewModel viewModel) {
    return Observer(builder: (_) {
      return viewModel.currentIndex == viewModel.onBoardItems.length - 1
          ? Container(
              alignment: Alignment.center,
              padding: context.paddingMediumHorizontal,
              child: buildGoogleSign(viewModel, context))
          : Container(
              padding: context.paddingMedium, //bozulma
              alignment: Alignment.bottomRight,
              child: buildButtonSkip(context, viewModel));
    });
  }

  // Widget buildTextButtonSkip(
  //     BuildContext context, OnBoardViewModel viewModel) {
  //   return TextButton(
  //     style: ButtonStyle(
  //       backgroundColor:
  //           MaterialStateProperty.all<Color>(context.colors.onSecondary),
  //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))),
  //     ),
  //     child: Container(
  //         margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
  //         child: buildLocaleSkipText(context)),
  //     onPressed: () {
  //       _pageController.nextPage(
  //         duration: Duration(milliseconds: 500),
  //         curve: Curves.ease,
  //       );
  //     },
  //   );
  // }

  Widget buildButtonSkip(BuildContext context, OnBoardViewModel viewModel) {
    return InkWell(
      child: Container(
        width: 75,
        decoration: BoxDecoration(
            color: context.colors.onSecondary,
            borderRadius: BorderRadius.circular(25)),
        child: Center(child: buildLocaleSkipText(context)),
      ),
      onTap: () {
        _pageController.nextPage(
          duration: context.lowDuration,
          curve: Curves.ease,
        );
      },
    );
  }

  LocaleText buildLocaleSkipText(BuildContext context) {
    return LocaleText(
        value: LocaleKeys.onBoard_Skip,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: context.colors.secondary, fontSize: 20));
  }

  InkWell buildGoogleSign(OnBoardViewModel viewModel, BuildContext context) {
    return InkWell(
      child: Container(
        height: 50,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: context.colors.secondary,
            borderRadius: BorderRadius.circular(25.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 35,
                height: 35,
                child: SvgPicture.asset(SVGImagePaths.instance.googleSVG)),
            SizedBox(width: 20),
            LocaleText(
                value: LocaleKeys.onBoard_googleDesc,
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: context.colors.primary, fontSize: 20)),
          ],
        ),
      ),
      onTap: () async {
        var data = await GoogleSignHelper.instance.signIn();
        if (data != null) {
          var userData = await GoogleSignHelper.instance.signInWithGoogle();
          print(userData);
          viewModel.navigateToListPage();
          viewModel.completeToOnBoard();
        }
      },
    );
  }

  // InkWell buildGoogleSign(OnBoardViewModel viewModel, BuildContext context) {
  //   return InkWell(
  //     child: Stack(
  //       children: [
  //         Container(
  //             height: 50,
  //             decoration: BoxDecoration(
  //                 color: context.colors.secondary,
  //                 borderRadius: BorderRadius.circular(25.0))),
  //         Positioned(
  //           left: 60,
  //           top: 6,
  //           child: Container(
  //               width: 35,
  //               height: 35,
  //               child: SvgPicture.asset('assets/svg/google.svg')),
  //         ),
  //         Positioned(
  //           top: 13,
  //           right: 70,
  //           child: LocaleText(
  //               value: LocaleKeys.onBoard_googleDesc,
  //               textAlign: TextAlign.right,
  //               style: Theme.of(context)
  //                   .textTheme
  //                   .bodyText1
  //                   .copyWith(color: Color(0xffbababa), fontSize: 20)),
  //         ),
  //       ],
  //     ),
  //     onTap: () async {
  //       var data = await GoogleSignHelper.instance.signIn();
  //       if (data != null) {
  //         var userData = await GoogleSignHelper.instance.signInWithGoogle();
  //         print(userData);
  //         viewModel.navigateToListPage();
  //       }
  //     },
  //   );
  // }

  SvgPicture buildSvgPicture(String path) => SvgPicture.asset(path);
}
