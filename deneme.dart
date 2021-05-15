// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:tasarim_proje/core/base/base_view.dart';
// import 'package:tasarim_proje/core/init/lang/locale_keys.g.dart';
// import 'package:tasarim_proje/core/widgets/locale_text.dart';
// import 'package:tasarim_proje/view/timing/timing_view_model.dart';
// import 'package:tasarim_proje/view/widgets/base_app_bar.dart';
// import 'package:tasarim_proje/core/init/extensions/context_extension.dart';
// import 'package:tasarim_proje/core/init/extensions/extensions.dart';
// import 'package:tasarim_proje/view/widgets/alarm_add_choice.dart';

// class AlarmAdd extends StatefulWidget {
//   @override
//   _AlarmAddState createState() => _AlarmAddState();
// }

// class _AlarmAddState extends State<AlarmAdd> {
//   @override
//   Widget build(BuildContext context) {
//     return BaseView<TimingViewModel>(
//         viewModel: TimingViewModel(),
//         onModelReady: (model) {
//           model.setContext(context);
//           model.init();
//         },
//         onPageBuilder: (BuildContext context, TimingViewModel viewModel) =>
//             Scaffold(
//                 appBar: BaseAppBar(
//                   widget: IconButton(
//                     icon: Icon(FontAwesomeIcons.times),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   title: LocaleText(
//                     value: LocaleKeys.timing_alarmadd_title,
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   widgets: [
//                     IconButton(
//                       icon: Icon(FontAwesomeIcons.check),
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(viewModel.dateTime.toString()),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//                 body: addAlarmBody(viewModel, context)));
//   }

//   SingleChildScrollView addAlarmBody(
//       TimingViewModel viewModel, BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           SizedBox(
//             height: 25,
//           ),
//           buildTimePicker(viewModel),
//           SizedBox(
//             height: 150,
//           ),
//           AlarmChoice(
//               text: LocaleKeys.timing_alarmadd_label,
//               ontap: () => alertLabel(context, viewModel)),
//           AlarmChoice(
//             text: LocaleKeys.timing_alarmadd_repeat,
//             ontap: () {},
//           ),
//           AlarmChoice(
//             text: LocaleKeys.timing_alarmadd_type,
//           )
//         ],
//       ),
//     );
//   }

//   Future<void> alertLabel(BuildContext context, TimingViewModel viewModel) {
//     return showDialog(
//       useSafeArea: true,
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(LocaleKeys.timing_alarmadd_label.locale),
//           content: TextField(
//             autocorrect: true,
//             controller: viewModel.textFieldController,
//             cursorHeight: 20,
//             style: TextStyle(color: context.colors.primary),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 viewModel.textFieldController.clear();
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 LocaleKeys.timing_alarmadd_Cancel.locale,
//                 style: TextStyle(color: context.colors.error),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 print(viewModel.textFieldController.text);
//                 Navigator.of(context).pop();
//               },
//               child: Text(LocaleKeys.timing_alarmadd_Okey.locale),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget buildTimePicker(TimingViewModel viewModel) {
//     return Observer(builder: (_) {
//       return Container(
//         height: 200,
//         child: CupertinoTheme(
//           data: CupertinoThemeData(
//               brightness: Brightness.dark,
//               textTheme: CupertinoTextThemeData(
//                   dateTimePickerTextStyle: TextStyle(fontSize: 24))),
//           child: CupertinoDatePicker(
//             backgroundColor: Colors.transparent,
//             initialDateTime: viewModel.dateTime,
//             mode: CupertinoDatePickerMode.time,
//             minuteInterval: 5,
//             use24hFormat: true,
//             onDateTimeChanged: (dateTime) =>
//                 {viewModel.dateTime = dateTime, print(viewModel.dateTime)},
//           ),
//         ),
//       );
//     });
//   }
// }
