import 'dart:ui';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/base/base_view.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../widgets/base_app_bar.dart';
import '../../widgets/buttton.dart';
import 'package:validators/validators.dart';
import '../../../core/init/extensions/context_extension.dart';
import '../../../core/init/extensions/extensions.dart';
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
          title: LocaleKeys.myList_appBarTitle,
          widgets: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                  icon: Icon(FontAwesomeIcons.plus),
                  onPressed: () {
                    viewModel.getClipboard();
                    _buildModalBottomSheet(context, viewModel);
                  }),
            )
          ],
        ),
        body: buildBody(context, viewModel),
        floatingActionButton: selectRandomLink(context, viewModel),
      ),
    );
  }

  Column buildBody(BuildContext context, MyListViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
          child: filter(context, viewModel),
        ),
        Observer(builder: (_) {
          return viewModel.choiceFilter();
        }),
      ],
    );
  }

  Widget selectRandomLink(BuildContext context, MyListViewModel viewModel) {
    return SpeedDialMenuButton(
      isShowSpeedDial: viewModel.isShow,
      updateSpeedDialStatus: (isShow) {
        //return any open or close change within the widget
        viewModel.isShow = isShow;
      },
      isMainFABMini: false,
      mainMenuFloatingActionButton: MainMenuFloatingActionButton(
          child: Image.asset(
            'assets/png/dice.png',
            width: 36,
          ),
          backgroundColor: context.colors.surface,
          shape: StadiumBorder(
              side: BorderSide(color: Color(0xff0f1829), width: 2)),
          onPressed: () {},
          closeMenuChild: Icon(Icons.close),
          closeMenuForegroundColor: Colors.red,
          closeMenuBackgroundColor: context.colors.surface),
      floatingActionButtonWidgetChildren: <FloatingActionButton>[
        FloatingActionButton(
          //mini: true,
          heroTag: 'btn1',
          child: Icon(
            FontAwesomeIcons.headphones,
            color: context.colors.primary,
            size: 28,
          ),
          onPressed: () {
            viewModel.goDetailPagewithType('Listen');
          },
          backgroundColor: context.colors.surface,
        ),
        FloatingActionButton(
          //mini: true,
          heroTag: 'btn2',
          child: Icon(FontAwesomeIcons.book, color: context.colors.primary),
          onPressed: () {
            viewModel.goDetailPagewithType('Read');
          },
          backgroundColor: context.colors.surface,
        ),
        FloatingActionButton(
          // mini: true,
          heroTag: 'btn3',
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(
              FontAwesomeIcons.tv,
              color: context.colors.primary,
            ),
          ),
          onPressed: () {
            viewModel.goDetailPagewithType('Watch');
          },
          backgroundColor: context.colors.surface,
        ),
      ],
      isSpeedDialFABsMini: false,
      paddingBtwSpeedDialButton: 30.0,
    );
  }

  //-----Filtering-----

  CustomRadioButton filter(BuildContext context, MyListViewModel viewModel) {
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
      enableButtonWrap: false,
      width: 100,
      height: 65,
      spacing: 10,
      autoWidth: false,
      unSelectedColor: context.colors.onSecondary.withOpacity(0.6),
      buttonLables: [
        LocaleKeys.myList_filter_all.locale,
        LocaleKeys.myList_filter_listen.locale,
        LocaleKeys.myList_filter_read.locale,
        LocaleKeys.myList_filter_watch.locale,
      ],
      buttonValues: [
        "all",
        "listen",
        "read",
        "watch",
      ],
      radioButtonValue: (value) {
        viewModel.changeFilterIndex(value);
      },
      selectedColor: context.colors.onSecondary,
      defaultSelected: "all",
    );
  }

  //--------------BOTTOMSHEET-----------------------

  //saving form after validation
  saveTexts(MyListViewModel viewModel, BuildContext context) {
    final isValid = viewModel.formKey.currentState.validate();
    if (isValid) {
      return viewModel.addFire();
    }
  }

  void _buildModalBottomSheet(BuildContext context, MyListViewModel viewModel) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return AnimatedPadding(
            padding: MediaQuery.of(bc).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Container(
              height: 350,
              padding: EdgeInsets.fromLTRB(0, 30, 0, 50),
              decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: customRadioButton(context, viewModel),
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(40, 15, 40, 0),
                          child: textFieldFormUrl(viewModel, context))),
                  AppButton(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      text: LocaleKeys.myList_bottomsheet_button,
                      ontap: () {
                        saveTexts(viewModel, context);
                      })
                ],
              ),
            ),
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
          List<String> protocols = const ['http', 'https', 'ftp'];
          if (!isURL(value, protocols: protocols, requireProtocol: true)) {
            return LocaleKeys.myList_bottomsheet_error.locale;
          } else {
            return null;
          }
        },
      ),
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
        viewModel.typeValue = value;
      },
      selectedColor: context.colors.onSecondary,
      defaultSelected: "Listen",
    );
  }
}
