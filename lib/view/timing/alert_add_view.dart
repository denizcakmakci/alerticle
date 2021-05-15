import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tasarim_proje/core/init/extensions/context_extension.dart';
import 'package:tasarim_proje/core/init/extensions/extensions.dart';
import 'package:tasarim_proje/core/init/lang/locale_keys.g.dart';
import 'package:tasarim_proje/core/widgets/locale_text.dart';
import 'package:tasarim_proje/view/widgets/alarm_add_choice.dart';
import 'package:tasarim_proje/view/widgets/base_app_bar.dart';

class MyType {
  String type;
  int index;
  String title;
  MyType({this.type, this.index, this.title});
}

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

  static String mon = "Mon";
  static String tue = "Tue";
  static String wed = "Wed";
  static String thu = "Thu";
  static String fri = "Fri";
  static String sat = "Sat";
  static String sun = "Sun";

  Map<String, bool> days = {
    mon: false,
    tue: false,
    wed: false,
    thu: false,
    fri: false,
    sat: false,
    sun: false,
  };

  String defaultChoice = "Listen";
  int defaultIndex = 0;

  List<MyType> types = [
    MyType(
        index: 0, type: "Listen", title: LocaleKeys.timing_type_listen.locale),
    MyType(index: 1, type: "Read", title: LocaleKeys.timing_type_read.locale),
    MyType(index: 2, type: "Watch", title: LocaleKeys.timing_type_watch.locale),
  ];

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
              alertRepeat(context);
            },
          ),
          AlarmChoice(
            text: LocaleKeys.timing_alarmadd_type,
            ontap: () => alertType(context),
          )
        ],
      ),
    );
  }

  Future alertType(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title:
                  Center(child: Text(LocaleKeys.timing_alarmadd_type.locale)),
              content: Container(height: 180, child: radio(setState)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    defaultIndex = 0;
                    defaultChoice = "Listen";
                  },
                  child: Text(
                    LocaleKeys.timing_alarmadd_Cancel.locale,
                    style: TextStyle(color: context.colors.error),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    print(defaultChoice);
                  },
                  child: Text(LocaleKeys.timing_alarmadd_Okey.locale),
                ),
              ],
            );
          });
        });
  }

  Widget radio(setState) {
    return Column(
      children: types
          .map(
            (data) => Theme(
              child: RadioListTile(
                  activeColor: context.colors.onPrimary,
                  title: Text(
                    data.title,
                    style: TextStyle(color: context.colors.primary),
                  ),
                  value: data.index,
                  groupValue: defaultIndex,
                  onChanged: (value) {
                    setState(() {
                      defaultChoice = data.type;
                      defaultIndex = data.index;
                    });
                  }),
              data: ThemeData(unselectedWidgetColor: context.colors.primary),
            ),
          )
          .toList(),
    );
  }

  Future alertRepeat(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title:
                  Center(child: Text(LocaleKeys.timing_alarmadd_repeat.locale)),
              content: Container(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    checkbox(LocaleKeys.timing_repeat_Mon.locale, mon,
                        days[mon], setState),
                    checkbox(LocaleKeys.timing_repeat_Tue.locale, tue,
                        days[tue], setState),
                    checkbox(LocaleKeys.timing_repeat_Wed.locale, wed,
                        days[wed], setState),
                    checkbox(LocaleKeys.timing_repeat_Thu.locale, thu,
                        days[thu], setState),
                    checkbox(LocaleKeys.timing_repeat_Fri.locale, fri,
                        days[fri], setState),
                    checkbox(LocaleKeys.timing_repeat_Sat.locale, sat,
                        days[sat], setState),
                    checkbox(LocaleKeys.timing_repeat_Sun.locale, sun,
                        days[sun], setState),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    days.updateAll((key, value) => false);
                  },
                  child: Text(
                    LocaleKeys.timing_alarmadd_Cancel.locale,
                    style: TextStyle(color: context.colors.error),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    getItems();
                  },
                  child: Text(LocaleKeys.timing_alarmadd_Okey.locale),
                ),
              ],
            );
          });
        });
  }

  Widget checkbox(String name, String title, bool boolValue, setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Theme(
          child: Checkbox(
            activeColor: context.colors.onPrimary,
            checkColor: context.colors.surface,
            value: boolValue,
            onChanged: (value) => setState(() => days[title] = value),
          ),
          data: ThemeData(unselectedWidgetColor: context.colors.primary),
        ),
        SizedBox(
          width: 10,
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
