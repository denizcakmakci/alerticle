import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/base/base_view.dart';
//import '../../core/init/extensions/context_extension.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/widgets/locale_text.dart';
import '../widgets/base_app_bar.dart';
import 'mylist_view_model.dart';

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MyListViewModel>(
      viewModel: MyListViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, MyListViewModel value) => Scaffold(
        appBar: BaseAppBar(
          title: LocaleText(
            value: LocaleKeys.myList_appBarTitle,
            style: TextStyle(fontSize: 28),
          ),
          widgets: [
            IconButton(icon: Icon(FontAwesomeIcons.filter), onPressed: () {}),
            IconButton(icon: Icon(FontAwesomeIcons.plus), onPressed: () {})
          ],
        ),
      ),
    );
  }
}
