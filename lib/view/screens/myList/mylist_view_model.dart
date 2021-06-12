import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:validators/validators.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/services/firestore/database_service.dart';
import '../../widgets/list_fire_data.dart';

part 'mylist_view_model.g.dart';

class MyListViewModel = _MyListViewModelBase with _$MyListViewModel;

abstract class _MyListViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  String typeValue;
  double pi = 3.1415926535897932;
  final formKey = GlobalKey<FormState>();
  Response info;
  TextEditingController urlController = TextEditingController();
  DatabaseService statusService = DatabaseService();

  //Floatingactionbutton showing
  bool isShow = false;

  getClipboard() async {
    ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && isURL(data.text)) {
      return urlController.text = data.text;
    } else {
      return urlController.clear();
    }
  }

  getTitle() async {
    info = await http.get(Uri.parse(
        'https://us-central1-flutterproject-347f0.cloudfunctions.net/getMeta?url=${urlController.text}'));
    return info;
  }

  Future<void> addFire() async {
    await getTitle();
    statusService
        .addLink(
          typeValue == null ? "Listen" : typeValue,
          jsonDecode(info.body)['title'],
          urlController.text,
          jsonDecode(info.body)['description'],
        )
        .then((value) => Navigator.pop(context));
    typeValue = null;
    urlController.clear();
  }

  @observable
  String filter = 'all';

  @action
  void changeFilterIndex(String value) {
    filter = value;
  }

  choiceFilter() {
    if (filter == 'all') {
      return ListData(
          page: 'list',
          function: statusService.getLinkWithQuery('deleted', false));
    } else if (filter == 'listen') {
      return ListData(
        page: 'list',
        function: statusService.getLinkWithMultiQuery(
            'deleted', false, 'type', 'Listen'),
      );
    } else if (filter == 'read') {
      return ListData(
        page: 'list',
        function: statusService.getLinkWithMultiQuery(
            'deleted', false, 'type', 'Read'),
      );
    } else if (filter == 'watch') {
      return ListData(
        page: 'list',
        function: statusService.getLinkWithMultiQuery(
            'deleted', false, 'type', 'Watch'),
      );
    }
  }

  @override
  void init() {}
}
