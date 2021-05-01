import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import '../../core/services/firestore/status_service.dart';
import 'package:tasarim_proje/core/init/extensions/context_extension.dart';

import '../../core/base/base_view_model.dart';

part 'mylist_view_model.g.dart';

class MyListViewModel = _MyListViewModelBase with _$MyListViewModel;

abstract class _MyListViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  String value;
  TextEditingController statusController = TextEditingController();
  StatusService statusService = StatusService();
  TextEditingController urlController = TextEditingController();

  bool checkTextEmpty() {
    return statusController.text.isNotEmpty && urlController.text.isNotEmpty
        ? true
        : false;
  }

  void addFire() {
    statusService.addStatus(value == null ? "Listen" : value,
        statusController.text, urlController.text);
    value = null;
    Navigator.pop(context);
    urlController.clear();
    statusController.clear();
  }

  Icon iconSelect(String docs) {
    if (docs == "Listen") {
      return Icon(
        FontAwesomeIcons.headphones,
        color: context.colors.primaryVariant,
      );
    } else if (docs == "Read") {
      return Icon(
        FontAwesomeIcons.book,
        color: context.colors.primaryVariant,
      );
    } else {
      return Icon(
        FontAwesomeIcons.tv,
        color: context.colors.primaryVariant,
      );
    }
  }

  @override
  void init() {}
}
