import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/services/firestore/database_service.dart';
import 'package:url_launcher/url_launcher.dart';
part 'detail_view_model.g.dart';

class DetailViewModel = _DetailViewModelBase with _$DetailViewModel;

abstract class _DetailViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  var type;
  DatabaseService model = DatabaseService();

  Map<String, String> lottieByType = {
    'Listen': 'assets/lottie/listen.json',
    'Read': 'assets/lottie/read.json',
    'Watch': 'assets/lottie/watch.json'
  };

  openURL(String url) async {
    if (await canLaunch(url)) {
      print('opened link');
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @observable
  bool visible = false;

  @action
  void changeVisible() {
    visible = !visible;
  }

  @observable
  ObservableList detail = ObservableList();

  @action
  getRandomLink(String value) async {
    var newValue = await model.getLink('type', value);

    if (newValue.isEmpty) {
      detail = null;
      return null;
    } else {
      detail.add(newValue[0]); //title
      detail.add(newValue[1]); //url
      detail.add(newValue[2]); //desc
      detail.add(newValue[3]); //id
      return detail;
    }
  }

  @override
  void init() {
    type = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    Future.delayed(Duration(seconds: 2), () async {
      await getRandomLink(type['type']);
      changeVisible();
    });
  }
}
