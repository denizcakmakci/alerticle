import 'package:flutter/material.dart';

import 'package:tasarim_proje/core/init/extensions/context_extension.dart';

class OnBoardCircle extends StatelessWidget {
  final bool isSelected;

  const OnBoardCircle({Key key, @required this.isSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: CircleAvatar(
        backgroundColor: isSelected
            ? context.colors.onSecondary.withOpacity(isSelected ? 1 : 0.2)
            : context.colors.primary.withOpacity(isSelected ? 1 : 0.2),
        radius: isSelected ? context.width * 0.015 : context.width * 0.01,
      ),
    );
  }
}
