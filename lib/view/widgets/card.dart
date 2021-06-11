import 'package:flutter/material.dart';

import '../../core/init/extensions/context_extension.dart';
import '../functions/func.dart';

class BaseCard extends StatelessWidget with IconColor {
  final String title;
  final String subtitle;
  final Function function;
  final String doc;

  const BaseCard({Key key, this.title, this.subtitle, this.function, this.doc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: generateIconAndColor(subtitle, 1, doc),
        child: ListTile(
          leading: generateIconAndColor(subtitle, 0, doc),
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline1.copyWith(
                fontWeight: FontWeight.w900,
                color: context.colors.primaryVariant,
                fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .headline1
                .copyWith(color: context.colors.primaryVariant, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onTap: function,
    );
  }
}
