import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tasarim_proje/core/services/firestore/status_service.dart';

import '../../core/base/base_view_model.dart';
import '../../core/device/constants.dart';

part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  StatusService statusService = StatusService();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> navigateToOnboardPage() async {
    localeManager.clearAll();
    navigation.navigateToPage(path: NavigationConstants.ONBOARD);
  }

  @override
  void init() {}
}
