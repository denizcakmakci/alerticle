import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tasarim_proje/core/base/base_view_model.dart';
part 'timing_view_model.g.dart';

class TimingViewModel = TimingViewModelBase with _$TimingViewModel;

abstract class TimingViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init() {}
}
