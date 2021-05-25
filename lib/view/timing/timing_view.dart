import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/base/base_view.dart';
import '../../core/init/extensions/context_extension.dart';
import '../../core/init/extensions/extensions.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/widgets/locale_text.dart';
import '../widgets/alarm_card.dart';
import '../widgets/base_app_bar.dart';
import 'alert_add_view.dart';
import 'timing_view_model.dart';

class TimingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<TimingViewModel>(
      viewModel: TimingViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, TimingViewModel viewModel) =>
          Scaffold(
              appBar: BaseAppBar(
                title: LocaleText(
                  value: LocaleKeys.timing_appBarTitle,
                  style: TextStyle(fontSize: 28),
                ),
                widgets: [
                  IconButton(
                      icon: Icon(FontAwesomeIcons.plus),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => AlarmAdd(),
                            fullscreenDialog: true,
                          ),
                        );
                      })
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: listAlarm(viewModel),
              )),
    );
  }
}

getdays(doc) {
  var list = [];
  List.from(doc['days']).forEach((element) {
    list.add("timing.days.$element".locale);
  });
  return list.join(", ");
}

StreamBuilder listAlarm(TimingViewModel viewModel) {
  return StreamBuilder<QuerySnapshot>(
    stream: viewModel.statusService.getAlarmWithQuery(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) return new Text('${snapshot.error}');
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return new Center(child: new CircularProgressIndicator());
        default:
          List<DocumentSnapshot> doc = snapshot.data.docs;
          return snapshot.hasData != null
              ? ListView(
                  key: GlobalKey(),
                  children: doc.map((DocumentSnapshot doc) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(20, 5, 20, 25),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Dismissible(
                          key: GlobalKey(),
                          background: slideBackground(context),
                          direction: DismissDirection.endToStart,
                          dismissThresholds: const {
                            DismissDirection.endToStart: 0.2,
                            DismissDirection.startToEnd: 0.2,
                          },
                          confirmDismiss: (direction) async {
                            return await alertDelete(doc, context, viewModel);
                          },
                          child: BaseCardAlarm(
                              title: doc['label'],
                              time: doc['hour'],
                              list: getdays(doc),
                              cupSwitch: CupertinoSwitch(
                                  value: doc['active'] == false ? false : true,
                                  onChanged: (bool value) {
                                    viewModel.statusService
                                        .alarmActiveChange(doc.id, value);
                                  })),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    );
                  }).toList())
              : Text('Nope');
      }
    },
  );
}

Future<bool> alertDelete(
  doc,
  BuildContext context,
  TimingViewModel viewModel,
) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(LocaleKeys.card_alertDelete_title.locale),
        content: Text(LocaleKeys.card_alertDelete_subtitle.locale),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LocaleKeys.card_alertDelete_cancel.locale)),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              viewModel.statusService.deleteAlarm(doc.id);
            },
            child: Text(
              LocaleKeys.card_alertDelete_delete.locale,
              style: TextStyle(color: context.colors.error),
            ),
          ),
        ],
      );
    },
  );
}

Widget slideBackground(BuildContext context) {
  return Container(
    alignment: AlignmentDirectional.centerEnd,
    color: context.colors.error,
    child: Padding(
      padding: EdgeInsets.only(right: 25),
      child: Icon(FontAwesomeIcons.trashAlt),
    ),
  );
}
