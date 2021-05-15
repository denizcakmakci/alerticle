import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tasarim_proje/core/init/lang/locale_keys.g.dart';
import 'package:tasarim_proje/core/services/firestore/status_service.dart';
import 'package:tasarim_proje/view/widgets/card.dart';

import '../../core/init/extensions/context_extension.dart';
import '../../core/init/extensions/extensions.dart';

StatusService statusService = StatusService();

Icon iconSelect(String docs, BuildContext context) {
  if (docs == "Listen") {
    return Icon(
      FontAwesomeIcons.headphones,
      color: context.colors.primaryVariant,
    );
  } else if (docs == "Read") {
    return Icon(
      FontAwesomeIcons.book,
      color: context.colors.primaryVariant,
    );
  } else {
    return Icon(
      FontAwesomeIcons.tv,
      color: context.colors.primaryVariant,
    );
  }
}

class ListData extends StatelessWidget {
  final status;
  final field;
  const ListData({
    Key key,
    this.status,
    this.field,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: statusService.getStatus(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var document = snapshot.data.data();
            var doc = document['list'];
            return ListView.builder(
              itemCount: doc != null ? doc.length : 0,
              itemBuilder: (_, int index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 25),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Dismissible(
                      key: ValueKey(index),
                      background: slideBackground(context),
                      direction: DismissDirection.endToStart,
                      dismissThresholds: const {
                        DismissDirection.endToStart: 0.2,
                        DismissDirection.startToEnd: 0.2,
                      },
                      confirmDismiss: (direction) async {
                        return await alertDelete(context, doc, index);
                      },
                      child: buildbaseCard(doc, index, context, status, field),
                    ),
                  ),
                );
              },
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

Future<bool> alertDelete(BuildContext context, doc, int index) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(LocaleKeys.myList_alertDelete_title.locale),
        content: Text(LocaleKeys.myList_alertDelete_subtitle.locale),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LocaleKeys.myList_alertDelete_Cancel.locale)),
          TextButton(
            onPressed: () {
              statusService.deleteData(doc[index]);
              Navigator.of(context).pop();
            },
            child: Text(
              LocaleKeys.myList_alertDelete_delete.locale,
              style: TextStyle(color: context.colors.error),
            ),
          ),
        ],
      );
    },
  );
}

BaseCard buildbaseCard(doc, int index, BuildContext context, status, field) {
  return doc[index][field] == status
      ? BaseCard(
          icon: iconSelect(doc[index]['type'], context),
          title: new Text(
            doc[index]['title'] ?? 'null',
            style: Theme.of(context).textTheme.headline1.copyWith(
                fontWeight: FontWeight.w900,
                color: context.colors.primaryVariant,
                fontSize: 16),
          ),
          subtitle: new Text(
            doc[index]['url'] ?? 'null',
            style: Theme.of(context)
                .textTheme
                .headline1
                .copyWith(color: context.colors.primaryVariant, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        )
      : null;
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
