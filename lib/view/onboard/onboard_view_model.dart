import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tasarim_proje/core/base/base_view_model.dart';
import 'package:tasarim_proje/core/device/constants.dart';
import 'package:tasarim_proje/core/init/lang/locale_keys.g.dart';
import 'package:tasarim_proje/view/constants/image_path_svg.dart';
import 'package:tasarim_proje/view/onboard/onboard_model.dart';

part 'onboard_view_model.g.dart';

class OnBoardViewModel = _OnBoardViewModelBase with _$OnBoardViewModel;

abstract class _OnBoardViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  List<OnBoardModel> onBoardItems = [];

  @observable
  int currentIndex = 0;

  @observable
  int isLastPage = 0;

  @action
  void changeCurrentIndex(int value) {
    currentIndex = value;
  }

  @action
  void changePage() {
    isLastPage++;
  }

  @override
  void init() {
    onBoardItems.add(OnBoardModel(LocaleKeys.onBoard_page1_title,
        LocaleKeys.onBoard_page1_desc, SVGImagePaths.instance.designSVG));
    onBoardItems.add(OnBoardModel(LocaleKeys.onBoard_page1_title,
        LocaleKeys.onBoard_page2_desc, SVGImagePaths.instance.calendarSVG));
    onBoardItems.add(OnBoardModel(LocaleKeys.onBoard_page3_title,
        LocaleKeys.onBoard_page3_desc, SVGImagePaths.instance.notificationSVG));
    onBoardItems.add(OnBoardModel(LocaleKeys.onBoard_page4_title,
        LocaleKeys.onBoard_page4_desc, SVGImagePaths.instance.videoSVG));
  }

  Future<void> completeToOnBoard() async {
    changePage();
    await localeManager.setBoolValue(PreferencesKeys.IS_FIRST_APP, true);
    //await navigation.navigateToPageClear(path: NavigationConstants.TEST);
  }
}
