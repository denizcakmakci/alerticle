import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:tasarim_proje/core/device/constants.dart';
import '../../../core/base/base_view.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/widgets/locale_text.dart';
import '../../functions/func.dart';
import 'detail_view_model.dart';
import '../../../core/init/extensions/context_extension.dart';
import '../../widgets/base_app_bar.dart';
import '../../widgets/buttton.dart';
import '../../../core/init/extensions/extensions.dart';

class DetailView extends StatelessWidget with IconColor {
  @override
  Widget build(BuildContext context) {
    return BaseView<DetailViewModel>(
        viewModel: DetailViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, DetailViewModel viewModel) =>
            WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                appBar: BaseAppBar(
                  widget: IconButton(
                    icon: Icon(FontAwesomeIcons.arrowLeft),
                    onPressed: () {
                      viewModel.navigation
                          .navigateToPageClear(path: NavigationConstants.HOME);
                    },
                    splashColor: Colors.transparent,
                  ),
                  title: LocaleKeys.detail_title,
                ),
                body: Observer(builder: (_) {
                  return buildBody(viewModel, context);
                }),
              ),
            ));
  }

  Column buildBody(DetailViewModel viewModel, BuildContext context) {
    return Column(
      children: [
        Center(
          child: viewModel.detail != null
              ? Lottie.asset(
                  viewModel.lottieByType[viewModel.type['type']],
                  width: 250,
                  height: 250,
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Lottie.asset(
                    'assets/lottie/sad.json',
                    width: 200,
                    height: 200,
                  ),
                ),
        ),
        SizedBox(
          height: context.height * 0.05,
        ),
        AnimatedOpacity(
          opacity: viewModel.visible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Visibility(
              visible: viewModel.visible,
              child: Observer(builder: (_) {
                return buildDesc(viewModel, context);
              })),
        ),
      ],
    );
  }

  Widget buildDesc(DetailViewModel viewModel, BuildContext context) {
    return viewModel.detail != null
        ? Column(
            children: [
              buildTitle(viewModel, context),
              SizedBox(
                height: context.mediumValue,
              ),
              buildSubtitle(viewModel),
              SizedBox(
                height: context.mediumValue,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: buildButtons(viewModel, context),
              )
            ],
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
            child: LocaleText(
              value: LocaleKeys.detail_notfound,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: context.colors.primary,
                  fontSize: 20,
                  fontFamily: 'Nunito'),
            ),
          );
  }

  Container buildSubtitle(DetailViewModel viewModel) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 30),
        child: Text(
          viewModel.detail[2] == null
              ? LocaleKeys.detail_empty.locale
              : viewModel.detail[2],
          style: TextStyle(
            color: Color(0xff9F9F9F),
            fontSize: 20,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ));
  }

  Container buildTitle(DetailViewModel viewModel, BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viewModel.detail[0] == null
                  ? LocaleKeys.detail_empty.locale
                  : viewModel.detail[0],
              style: TextStyle(
                  color: context.colors.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.w900),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              viewModel.detail[1] == null
                  ? LocaleKeys.detail_empty.locale
                  : viewModel.detail[1],
              style: TextStyle(
                  color: context.colors.primary,
                  fontSize: 16,
                  fontStyle: FontStyle.italic),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ));
  }

  Row buildButtons(DetailViewModel viewModel, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          text: LocaleKeys.detail_buttons_refresh,
          ontap: () async {
            viewModel.changeVisible();
            viewModel.detail.clear();
            await viewModel.getRandomLink(viewModel.type['type']);
            viewModel.changeVisible();
          },
        ),
        SizedBox(
          width: context.highValue,
        ),
        AppButton(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          text: LocaleKeys.detail_buttons_open,
          ontap: () {
            viewModel.openURL(viewModel.detail[1]);
            viewModel.model.softDeleteLink(viewModel.detail[3], true);
          },
        )
      ],
    );
  }
}
