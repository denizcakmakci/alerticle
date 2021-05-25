import 'dart:ui';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasarim_proje/view/constants/image_path_svg.dart';
import 'package:validators/validators.dart';

import '../../core/base/base_view.dart';
import '../../core/init/extensions/context_extension.dart';
import '../../core/init/extensions/extensions.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/widgets/locale_text.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/buttton.dart';
import 'mylist_view_model.dart';

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
                  IconButton(
                      icon: Icon(FontAwesomeIcons.filter),
                      onPressed: () {
                        viewModel.statusService
                            .getLink('type', 'Listen', alertAdd(context))
                            .then((value) => print(value[0]));
                      }),
                  IconButton(
                      icon: Icon(FontAwesomeIcons.plus),
                      onPressed: () {
                        _buildModalBottomSheet(context, viewModel);
                      })
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.topRight,
                          child: filter(context, viewModel))),
                  Observer(builder: (_) {
                    return Expanded(flex: 9, child: viewModel.choiceFilter());
                  }),
                ],
              )),
    );
  }

  //-----Filter-----

  InkWell filter(BuildContext context, MyListViewModel viewModel) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        width: 80,
        decoration: BoxDecoration(
          color: context.colors.primary,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Observer(builder: (_) {
              return Text(
                viewModel.filterText(),
                style: TextStyle(fontSize: 18),
              );
            }),
            SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(
                FontAwesomeIcons.sortDown,
                color: context.colors.primaryVariant,
                size: 16,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        alertFilter(context, viewModel);
      },
    );
  }

  Future alertFilter(BuildContext context, MyListViewModel viewModel) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(20),
            children: [
              SimpleDialogOption(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(FontAwesomeIcons.headphones),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      LocaleKeys.timing_type_listen.locale,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          color: context.colors.primary, fontSize: 20),
                    )
                  ],
                ),
                onPressed: () {
                  viewModel.changeFilterIndex(0);
                  print(viewModel.filter);
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(FontAwesomeIcons.headphones),
                    SizedBox(
                      width: 30,
                    ),
                    Text(LocaleKeys.timing_type_listen.locale,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            color: context.colors.primary, fontSize: 20))
                  ],
                ),
                onPressed: () {
                  viewModel.changeFilterIndex(1);
                  print(viewModel.filter);
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(FontAwesomeIcons.book),
                    SizedBox(
                      width: 30,
                    ),
                    Text(LocaleKeys.timing_type_listen.locale,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            color: context.colors.primary, fontSize: 20))
                  ],
                ),
                onPressed: () {
                  viewModel.changeFilterIndex(2);
                  print(viewModel.filter);
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(FontAwesomeIcons.tv),
                    SizedBox(
                      width: 30,
                    ),
                    Text(LocaleKeys.timing_type_listen.locale,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            color: context.colors.primary, fontSize: 20))
                  ],
                ),
                onPressed: () {
                  viewModel.changeFilterIndex(3);
                  print(viewModel.filter);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  //--------------BOTTOMSHEET-----------------------

  //saving form after validation and check text empty control
  void saveTexts(MyListViewModel viewModel, BuildContext context) {
    final isValid = viewModel.formKey.currentState.validate();
    if (isValid) {
      return viewModel.checkTextEmpty()
          ? viewModel.addFire()
          : alertAdd(context);
    }
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
                        child: textFieldTitle(viewModel, context))),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(40, 5, 40, 0),
                        child: textFieldFormUrl(viewModel, context))),
                AppButton(
                    width: 80,
                    height: 50,
                    padding: context.paddingMedium,
                    text: LocaleKeys.myList_bottomsheet_button,
                    ontap: () {
                      saveTexts(viewModel, context);
                    })
              ],
            ),
          );
        });
  }

  alertAdd(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(LocaleKeys.myList_alertAdd_title.locale),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(LocaleKeys.myList_alertAdd_Ok.locale),
              )
            ],
          );
        });
  }

  Form textFieldFormUrl(MyListViewModel viewModel, BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: TextFormField(
        autocorrect: true,
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
            errorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedErrorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          if (!isURL(value)) {
            return LocaleKeys.myList_bottomsheet_error.locale;
          } else {
            return null;
          }
        },
      ),
    );
  }

  TextField textFieldTitle(MyListViewModel viewModel, BuildContext context) {
    return TextField(
      autocorrect: true,
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
        "Listen",
        "Read",
        "Watch",
      ],
      radioButtonValue: (value) {
        viewModel.value = value;
      },
      selectedColor: context.colors.onSecondary,
      defaultSelected: "Listen",
    );
  }
}
