import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:tasarim_proje/view/widgets/buttton.dart';

import '../../core/base/base_view.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/widgets/locale_text.dart';
import '../widgets/base_app_bar.dart';
import 'mylist_view_model.dart';
import 'package:tasarim_proje/core/init/extensions/context_extension.dart';
import 'package:tasarim_proje/core/init/extensions/extensions.dart';

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MyListViewModel>(
      viewModel: MyListViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, MyListViewModel viewModel) =>
          Scaffold(
        appBar: BaseAppBar(
          title: LocaleText(
            value: LocaleKeys.myList_appBarTitle,
            style: TextStyle(fontSize: 28),
          ),
          widgets: [
            IconButton(icon: Icon(FontAwesomeIcons.filter), onPressed: () {}),
            IconButton(
                icon: Icon(FontAwesomeIcons.plus),
                onPressed: () {
                  _buildModalBottomSheet(context, viewModel);
                })
          ],
        ),
      ),
    );
  }

  void _buildModalBottomSheet(BuildContext context, MyListViewModel viewModel) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 400,
            padding: EdgeInsets.fromLTRB(0, 30, 0, 50),
            decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0))),
            child: Column(
              children: [
                Expanded(
                  child: customRadioButton(context, viewModel),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(40, 40, 40, 5),
                      child: textFieldTitle(viewModel, context)),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(40, 5, 40, 0),
                      child: textFieldUrl(viewModel, context)),
                ),
                AppButton(
                    width: 80,
                    height: 50,
                    padding: context.paddingMedium,
                    text: LocaleKeys.myList_bottomsheet_button,
                    ontap: () {
                      viewModel.addFire();
                    }),
              ],
            ),
          );
        });
  }

  TextField textFieldUrl(MyListViewModel viewModel, BuildContext context) {
    return TextField(
      cursorRadius: Radius.circular(30),
      showCursor: true,
      cursorColor: context.colors.surface,
      cursorHeight: 20,
      controller: viewModel.urlController,
      decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
          hintText: LocaleKeys.myList_bottomsheet_url.locale,
          alignLabelWithHint: true,
          filled: true,
          fillColor: context.colors.primary,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    );
  }

  TextField textFieldTitle(MyListViewModel viewModel, BuildContext context) {
    return TextField(
      cursorRadius: Radius.circular(30),
      showCursor: true,
      cursorColor: context.colors.surface,
      cursorHeight: 20,
      controller: viewModel.statusController,
      decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
          hintText: LocaleKeys.myList_bottomsheet_title.locale,
          alignLabelWithHint: true,
          filled: true,
          fillColor: context.colors.primary,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    );
  }

  CustomRadioButton customRadioButton(
      BuildContext context, MyListViewModel viewModel) {
    return CustomRadioButton(
      buttonTextStyle: ButtonTextStyle(
          selectedColor: Colors.white,
          unSelectedColor: context.colors.primary,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
      unSelectedBorderColor: Colors.transparent,
      selectedBorderColor: Colors.transparent,
      elevation: 0,
      enableShape: true,
      enableButtonWrap: true,
      width: 110,
      height: 45,
      spacing: 10,
      autoWidth: false,
      unSelectedColor: context.colors.onSecondary.withOpacity(0.6),
      buttonLables: [
        LocaleKeys.myList_bottomsheet_listen.locale,
        LocaleKeys.myList_bottomsheet_read.locale,
        LocaleKeys.myList_bottomsheet_watch.locale,
      ],
      buttonValues: [
        LocaleKeys.myList_bottomsheet_listen.locale,
        LocaleKeys.myList_bottomsheet_read.locale,
        LocaleKeys.myList_bottomsheet_watch.locale,
      ],
      radioButtonValue: (value) {
        print(value);
        viewModel.value = value;
      },
      selectedColor: context.colors.onSecondary,
    );
  }
}
