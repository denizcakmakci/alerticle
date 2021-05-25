import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/init/extensions/context_extension.dart';
import '../constants/linear_gradient.dart';

class BaseCardAlarm extends StatelessWidget {
  final String title;
  final String time;
  final list;
  final Widget cupSwitch;

  const BaseCardAlarm(
      {Key key, this.title, this.time, this.list, this.cupSwitch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GradientTemplate colors = GradientTemplate();
    var gradientColor =
        GradientTemplate.gradientTemplate[colors.randomindex].colors;
    return Container(
      height: 100,
      decoration:
          BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.label,
                  color: context.colors.secondary,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(title,
                    style: TextStyle(
                        color: context.colors.secondary, fontSize: 16)),
              ],
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
