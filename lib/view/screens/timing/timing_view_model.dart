import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/services/firestore/database_service.dart';
import '../../../core/init/extensions/extensions.dart';

part 'timing_view_model.g.dart';

class TimingViewModel = TimingViewModelBase with _$TimingViewModel;

abstract class TimingViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  DatabaseService statusService = DatabaseService();

  getdays(doc, index) {
    var list = [];
    List.from(doc[index]['days']).forEach((element) {
      list.add("timing.days.$element".locale);
    });
    return list.join(", ");
  }

//alarm cards color get database
  getcolor(doc, index) {
    var sayi1 = int.parse(doc[index]['color'][0]);
    var sayi2 = int.parse(doc[index]['color'][1]);
    Color color1 = Color(sayi1);
    Color color2 = Color(sayi2);
    List<Color> colorList = [];
    colorList.add(color1);
    colorList.add(color2);
    return colorList;
  }

  getIcon(doc, index) {
    switch (doc[index]['type']) {
      case 'Listen':
        return 'assets/icons/headphones.png';
      case 'Read':
        return 'assets/icons/books.png';
      case 'Watch':
        return 'assets/icons/television.png';
        break;
    }
  }

  @override
  void init() {}
}
