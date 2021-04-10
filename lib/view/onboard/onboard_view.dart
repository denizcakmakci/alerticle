import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:mobx/mobx.dart';
import 'package:tasarim_proje/core/base/base_view.dart';
import 'package:tasarim_proje/core/init/lang/locale_keys.g.dart';
import 'package:tasarim_proje/core/widgets/locale_text.dart';
import 'package:tasarim_proje/view/onboard/onboard_model.dart';
import 'package:tasarim_proje/view/onboard/onboard_view_model.dart';
import 'package:tasarim_proje/core/init/extensions/context_extension.dart';
import 'package:tasarim_proje/view/widgets/on_board_circle.dart';

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
        body: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Expanded(flex: 5, child: buildPageView(viewModel)),
            Expanded(
                flex: 1,
                child: Container(
                    padding: context.paddingMedium,
                    alignment: Alignment.topLeft,
                    child: buildListViewCircles(viewModel))),
            bottomButtons(context, viewModel)
          ],
        ),
      ),
    );
  }

  Widget bottomButtons(BuildContext context, OnBoardViewModel viewModel) {
    return Observer(builder: (_) {
      return Expanded(
          child: viewModel.isLastPage == 3
              ? buildGoogleSign(viewModel, context)
              : Container(
                  padding: context.paddingMedium,
                  alignment: Alignment.topRight,
                  child: buildTextButtonSkip(context, viewModel)));
    });
  }

// comment
  PageView buildPageView(OnBoardViewModel viewModel) {
    return PageView.builder(
        controller: _pageController,
        itemCount: viewModel.onBoardItems.length,
        onPageChanged: (value) {
          viewModel.changeCurrentIndex(value);
          viewModel.changePage();
        },
        itemBuilder: (context, index) =>
            buildColumnBody(context, viewModel.onBoardItems[index]));
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

  TextButton buildTextButtonSkip(
      BuildContext context, OnBoardViewModel viewModel) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(context.colors.onSecondary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))),
      ),
      child: Container(
          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: buildLocaleSkipText(context)),
      onPressed: () {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        viewModel.completeToOnBoard();
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

  InkWell buildGoogleSign(OnBoardViewModel viewModel, BuildContext context) {
    return InkWell(
      child: Container(
        width: 330,
        height: 54,
        decoration: BoxDecoration(
            color: context.colors.secondary,
            borderRadius: BorderRadius.circular(25.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 35,
              width: 35,
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage('assets/google.svg'),
              //         fit: BoxFit.cover)),
            ),
            LocaleText(
                value: LocaleKeys.onBoard_googleDesc,
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: context.colors.primary, fontSize: 20)),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  SvgPicture buildSvgPicture(String path) => SvgPicture.asset(path);
}
