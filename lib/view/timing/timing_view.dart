import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasarim_proje/core/base/base_view.dart';
import 'package:tasarim_proje/core/init/lang/locale_keys.g.dart';
import 'package:tasarim_proje/core/widgets/locale_text.dart';
import 'package:tasarim_proje/view/timing/alert_add_view.dart';
import 'package:tasarim_proje/view/timing/timing_view_model.dart';
import 'package:tasarim_proje/view/widgets/base_app_bar.dart';

class TimingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<TimingViewModel>(
      viewModel: TimingViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, TimingViewModel viewModel) =>
          Scaffold(
              appBar: BaseAppBar(
                title: LocaleText(
                  value: LocaleKeys.timing_appBarTitle,
                  style: TextStyle(fontSize: 28),
                ),
                widgets: [
                  IconButton(
                      icon: Icon(FontAwesomeIcons.plus),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => AlarmAdd(),
                            fullscreenDialog: true,
                          ),
                        );
                      })
                ],
              ),
              body: Container()),
    );
  }
}
