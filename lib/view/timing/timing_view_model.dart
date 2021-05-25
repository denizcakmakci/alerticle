import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../core/base/base_view_model.dart';
import '../../core/services/firestore/status_service.dart';
part 'timing_view_model.g.dart';

class TimingViewModel = TimingViewModelBase with _$TimingViewModel;

abstract class TimingViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  StatusService statusService = StatusService();

  @observable
  bool switchChange = true;

  @action
  void changeSwitchIndex() {
    switchChange = !switchChange;
  }

  @override
  void init() {}
}
