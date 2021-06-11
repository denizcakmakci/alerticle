import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/init/extensions/context_extension.dart';

class BaseCardAlarm extends StatelessWidget {
  final String title;
  final String time;
  final list;
  final Widget cupSwitch;
  final List<Color> color;
  final String icon;

  const BaseCardAlarm(
      {Key key,
      this.title,
      this.time,
      this.list,
      this.cupSwitch,
      @required this.color,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(gradient: LinearGradient(colors: color)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  icon,
                  width: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(title,
                    style: TextStyle(
                        color: context.colors.secondary, fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: TextStyle(
                      color: context.colors.secondary,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                cupSwitch
              ],
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  list,
                  style: TextStyle(color: context.colors.secondary),
                ))
          ],
        ),
      ),
    );
  }
}
