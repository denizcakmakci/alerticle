import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasarim_proje/core/init/lang/locale_keys.g.dart';
import 'package:tasarim_proje/core/widgets/locale_text.dart';
import 'package:tasarim_proje/view/widgets/alarm_add_choice.dart';
import 'package:tasarim_proje/view/widgets/base_app_bar.dart';
import 'package:tasarim_proje/core/init/extensions/context_extension.dart';
import 'package:tasarim_proje/core/init/extensions/extensions.dart';

class AlarmAdd extends StatefulWidget {
  @override
  _AlarmAddState createState() => _AlarmAddState();
}

class _AlarmAddState extends State<AlarmAdd> {
  DateTime _dateTime;

  DateTime getDateTime() {
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day, now.hour, 0);
  }

  @override
  void initState() {
    super.initState();
    _dateTime = getDateTime();
  }

  static String sun = "Sun";
  static String mon = "Mon";
  static String tue = "Tue";
  static String wed = "Wed";

  Map<String, bool> days = {
    sun: false,
    mon: false,
    tue: false,
    wed: false,
  };

  var certainDays = [];
  getItems() {
    days.forEach((key, value) {
      if (value == true) {
        certainDays.add(key);
      }
    });
    print(certainDays);
    certainDays.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          widget: IconButton(
            icon: Icon(FontAwesomeIcons.times),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: LocaleText(
            value: LocaleKeys.timing_alarmadd_title,
            style: TextStyle(fontSize: 20),
          ),
          widgets: [
            IconButton(
              icon: Icon(FontAwesomeIcons.check),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_dateTime.toString()),
                  ),
                );
              },
            ),
          ],
        ),
        body: addAlarmBody(context));
  }

  SingleChildScrollView addAlarmBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          buildTimePicker(),
          SizedBox(
            height: 130,
          ),
          AlarmChoice(
              text: LocaleKeys.timing_alarmadd_label,
              ontap: () => alertLabel(context)),
          AlarmChoice(
            text: LocaleKeys.timing_alarmadd_repeat,
            ontap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        content: Column(
                          children: [
                            checkbox('ad', sun, days[sun], setState),
                            checkbox('ad', mon, days[mon], setState),
                            checkbox('ad', tue, days[tue], setState),
                            checkbox('ad', wed, days[wed], setState),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                getItems();
                                days.updateAll((key, value) => false);
                              },
                              child: Text('vkfmv')),
                        ],
                      );
                    });
                  });
            },
          ),
          AlarmChoice(
            text: LocaleKeys.timing_alarmadd_type,
          )
        ],
      ),
    );
  }

  Widget checkbox(name, String title, bool boolValue, setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Checkbox(
            value: boolValue,
            onChanged: (value) => setState(() => days[title] = value),
          ),
        ),
        Text(name),
      ],
    );
  }

  Future<void> alertLabel(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.timing_alarmadd_label.locale),
          content: TextField(
            autocorrect: true,
            controller: _textFieldController,
            cursorHeight: 20,
            style: TextStyle(color: context.colors.primary),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _textFieldController.clear();
                Navigator.of(context).pop();
              },
              child: Text(
                LocaleKeys.timing_alarmadd_Cancel.locale,
                style: TextStyle(color: context.colors.error),
              ),
            ),
            TextButton(
              onPressed: () {
                print(_textFieldController.text);
                Navigator.of(context).pop();
              },
              child: Text(LocaleKeys.timing_alarmadd_Okey.locale),
            ),
          ],
        );
      },
    );
  }

  Widget buildTimePicker() {
    return Container(
      height: 200,
      child: CupertinoTheme(
        data: CupertinoThemeData(
            brightness: Brightness.dark,
            textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(fontSize: 24))),
        child: CupertinoDatePicker(
          backgroundColor: Colors.transparent,
          initialDateTime: _dateTime,
          mode: CupertinoDatePickerMode.time,
          minuteInterval: 5,
          use24hFormat: true,
          onDateTimeChanged: (dateTime) {
            setState(() {
              _dateTime = dateTime;
            });
          },
        ),
      ),
    );
  }
}
