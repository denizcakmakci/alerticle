import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import '../widgets/card.dart';
import '../widgets/buttton.dart';

import '../../core/base/base_view.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/widgets/locale_text.dart';
import '../widgets/base_app_bar.dart';
import 'mylist_view_model.dart';
import '../../core/init/extensions/context_extension.dart';
import '../../core/init/extensions/extensions.dart';

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
        body: listData(context, viewModel),
      ),
    );
  }

  StreamBuilder listData(BuildContext context, MyListViewModel viewModel) {
    return StreamBuilder<DocumentSnapshot>(
        stream: viewModel.statusService.getStatus(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var document = snapshot.data.data();
            var doc = document['list'];
            return ListView.builder(
              itemCount: doc != null ? doc.length : 0,
              itemBuilder: (_, int index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 25),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Dismissible(
                      key: ValueKey(index),
                      background: slideBackground(context),
                      direction: DismissDirection.endToStart,
                      dismissThresholds: const {
                        DismissDirection.endToStart: 0.2,
                        DismissDirection.startToEnd: 0.2,
                      },
                      confirmDismiss: (direction) async {
                        return await alertDelete(
                            context, viewModel, doc, index);
                      },
                      child: buildbaseCard(viewModel, doc, index, context),
                    ),
                  ),
                );
              },
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<bool> alertDelete(
      BuildContext context, MyListViewModel viewModel, doc, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.myList_alertDelete_title.locale),
          content: Text(LocaleKeys.myList_alertDelete_subtitle.locale),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(LocaleKeys.myList_alertDelete_Cancel.locale)),
            TextButton(
              onPressed: () {
                viewModel.statusService.removeStatus(doc[index]);
                Navigator.of(context).pop();
              },
              child: Text(
                LocaleKeys.myList_alertDelete_delete.locale,
                style: TextStyle(color: context.colors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  BaseCard buildbaseCard(
      MyListViewModel viewModel, doc, int index, BuildContext context) {
    return BaseCard(
      icon: viewModel.iconSelect(doc[index]['type']),
      title: new Text(
        doc[index]['title'] ?? 'null',
        style: Theme.of(context).textTheme.headline1.copyWith(
            fontWeight: FontWeight.w900,
            color: context.colors.primaryVariant,
            fontSize: 16),
      ),
      subtitle: new Text(
        doc[index]['url'] ?? 'null',
        style: Theme.of(context)
            .textTheme
            .headline1
            .copyWith(color: context.colors.primaryVariant, fontSize: 14),
      ),
    );
  }

  Widget slideBackground(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      color: context.colors.error,
      child: Padding(
        padding: EdgeInsets.only(right: 25),
        child: Icon(FontAwesomeIcons.trashAlt),
      ),
    );
  }

  //--------------BOTTOMSHEET-----------------------

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
                        child: textFieldUrl(viewModel, context))),
                AppButton(
                    width: 80,
                    height: 50,
                    padding: context.paddingMedium,
                    text: LocaleKeys.myList_bottomsheet_button,
                    ontap: () {
                      viewModel.checkTextEmpty()
                          ? viewModel.addFire()
                          : alertAdd(context);
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
