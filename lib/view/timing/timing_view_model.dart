import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tasarim_proje/core/base/base_view_model.dart';
part 'timing_view_model.g.dart';

class TimingViewModel = TimingViewModelBase with _$TimingViewModel;

abstract class TimingViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  TextEditingController textFieldController = TextEditingController();

  static String sun = "Sun";
  static String mon = "Mon";
  static String tue = "Tue";
  static String wed = "Wed";

  @observable
  Map<String, bool> days = {
    sun: false,
    mon: false,
    tue: false,
    wed: false,
  };

  @observable
  DateTime dateTime;

  DateTime getDateTime() {
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day, now.hour, 0);
  }

  @override
  void init() {}
}
