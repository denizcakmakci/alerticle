import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/base/base_view_model.dart';
import '../../core/init/extensions/extensions.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/services/firestore/status_service.dart';
import '../widgets/list_fire_data.dart';

part 'mylist_view_model.g.dart';

class MyListViewModel = _MyListViewModelBase with _$MyListViewModel;

abstract class _MyListViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  String value;
  final formKey = GlobalKey<FormState>();
  TextEditingController statusController = TextEditingController();
  StatusService statusService = StatusService();
  TextEditingController urlController = TextEditingController();

  bool checkTextEmpty() {
    return statusController.text.isNotEmpty ? true : false;
  }

  void addFire() {
    statusService.addLink(value == null ? "Listen" : value,
        statusController.text, urlController.text);
    value = null;
    Navigator.pop(context);
    urlController.clear();
    statusController.clear();
  }

  void checkUrl(Widget alert) {
    final isValid = formKey.currentState.validate();
    if (isValid) {
      return checkTextEmpty() ? addFire() : alert;
    }
  }

  @observable
  int filter = 0;

  @action
  void changeFilterIndex(int value) {
    filter = value;
  }

  choiceFilter() {
    if (filter == 0) {
      return ListData(
          page: 'list',
          function: statusService.getLinkWithQuery('deleted', false));
    } else if (filter == 1) {
      return ListData(
        page: 'list',
        function: statusService.getLinkWithMultiQuery(
            'deleted', false, 'type', 'Listen'),
      );
    } else if (filter == 2) {
      return ListData(
        page: 'list',
        function: statusService.getLinkWithMultiQuery(
            'deleted', false, 'type', 'Read'),
      );
    } else if (filter == 3) {
      return ListData(
        page: 'list',
        function: statusService.getLinkWithMultiQuery(
            'deleted', false, 'type', 'Watch'),
      );
    }
  }

  filterText() {
    if (filter == 0) {
      return LocaleKeys.timing_type_listen.locale;
    } else if (filter == 1) {
      return LocaleKeys.timing_type_listen.locale;
    } else if (filter == 2) {
      return LocaleKeys.timing_type_read.locale;
    } else if (filter == 3) {
      return LocaleKeys.timing_type_watch.locale;
    }
  }

  @override
  void init() {}
}
