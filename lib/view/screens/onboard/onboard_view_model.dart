import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/device/constants.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../constants/image_path_svg.dart';
import 'onboard_model.dart';

part 'onboard_view_model.g.dart';

class OnBoardViewModel = _OnBoardViewModelBase with _$OnBoardViewModel;

abstract class _OnBoardViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  List<OnBoardModel> onBoardItems = [];

  @observable
  int currentIndex = 0;

  @action
  void changeCurrentIndex(int value) {
    currentIndex = value;
  }

  @override
  void init() {
    onBoardItems.add(OnBoardModel(LocaleKeys.onBoard_page1_title,
        LocaleKeys.onBoard_page1_desc, SVGImagePaths.instance.designSVG));
    onBoardItems.add(OnBoardModel(LocaleKeys.onBoard_page2_title,
        LocaleKeys.onBoard_page2_desc, SVGImagePaths.instance.calendarSVG));
    onBoardItems.add(OnBoardModel(LocaleKeys.onBoard_page3_title,
        LocaleKeys.onBoard_page3_desc, SVGImagePaths.instance.notificationSVG));
    onBoardItems.add(OnBoardModel(LocaleKeys.onBoard_page4_title,
        LocaleKeys.onBoard_page4_desc, SVGImagePaths.instance.videoSVG));
  }

  void navigateToListPage() {
    NavigationService.instance
        .navigateToPageClear(path: NavigationConstants.HOME);
  }

  Future<void> completeToOnBoard() async {
    await localeManager.setBoolValue(PreferencesKeys.IS_FIRST_APP, true);
  }
}
