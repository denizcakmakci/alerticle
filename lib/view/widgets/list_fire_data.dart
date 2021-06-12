import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/detail/detail_view_model.dart';

import '../../core/init/extensions/context_extension.dart';
import '../../core/init/extensions/extensions.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/services/firestore/database_service.dart';
import '../../core/widgets/locale_text.dart';
import 'card.dart';

DatabaseService statusService = DatabaseService();
DetailViewModel model = DetailViewModel();

// Function adjusting the Dismissible direction for different pages
direction(String page) {
  if (page == 'list') {
    return DismissDirection.endToStart;
  } else {
    return DismissDirection.horizontal;
  }
}

class ListData extends StatelessWidget {
  final String page;
  final Stream function;

  const ListData({
    Key key,
    @required this.page,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: function,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Align(
                alignment: Alignment.center,
                child: new CircularProgressIndicator());
          default:
            List<DocumentSnapshot> doc = snapshot.data.docs;
            return snapshot.hasData != null && doc.isNotEmpty
                ? Expanded(
                    flex: page == 'list' ? 9 : 5,
                    child: ListView(
                        key: GlobalKey(),
                        children: doc.map((DocumentSnapshot doc) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(15, 0, 15, 25),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Dismissible(
                                  key: GlobalKey(),
                                  background: slideLeftBackground(context),
                                  secondaryBackground:
                                      slideRightBackground(context),
                                  direction: direction(page),
                                  dismissThresholds: const {
                                    DismissDirection.endToStart: 0.2,
                                    DismissDirection.startToEnd: 0.2,
                                  },
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      return await alertDelete(context, doc);
                                    } else {
                                      return await alertBackList(context, doc);
                                    }
                                  },
                                  child: buildbaseCard(doc, context)),
                            ),
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          );
                        }).toList()),
                  )
                : Expanded(
                    flex: page == 'list' ? 9 : 4,
                    child: emptyList(context, page));
        }
      },
    );
  }

  BaseCard buildbaseCard(doc, BuildContext context) {
    return BaseCard(
        doc: doc['type'],
        title: doc['title'] ?? 'null',
        subtitle: doc['url'] ?? 'null',
        function: () {
          alertOpenLink(context, doc);
        });
  }

  Future<bool> alertDelete(BuildContext context, doc) {
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
                statusService.deleteLink(doc.id);
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

  Future<bool> alertBackList(BuildContext context, doc) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text(LocaleKeys.card_alertbacklist_title.locale),
          content: Text(LocaleKeys.card_alertbacklist_subtitle.locale),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(LocaleKeys.card_alertbacklist_cancel.locale)),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                statusService.softDeleteLink(doc.id, false);
              },
              child: Text(
                LocaleKeys.card_alertbacklist_yes.locale,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> alertOpenLink(BuildContext context, doc) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.card_alertOpenLink_title.locale),
          content: Text(LocaleKeys.card_alertOpenLink_subtitle.locale),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(LocaleKeys.card_alertOpenLink_cancel.locale)),
            TextButton(
              onPressed: () {
                model.openURL(doc['url']);
                Navigator.of(context).pop();
                statusService.softDeleteLink(doc.id, true);
              },
              child: Text(
                LocaleKeys.card_alertOpenLink_open.locale,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget slideRightBackground(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      color: context.colors.error,
      child: Padding(
        padding: EdgeInsets.only(right: 25),
        child: Icon(FontAwesomeIcons.trashAlt),
      ),
    );
  }

  Widget slideLeftBackground(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      color: context.colors.onSecondary,
      child: Padding(
        padding: EdgeInsets.only(left: 25),
        child: Icon(FontAwesomeIcons.history),
      ),
    );
  }

  //----Empty list widget----
  Column emptyList(BuildContext context, String page) {
    if (page == 'list') {
      return Column(
        children: [
          Image.asset(
            'assets/png/listEmpty.png',
            width: context.height * 0.4,
          ),
          LocaleText(
            value: LocaleKeys.myList_emptyList_title,
            style: TextStyle(
                color: context.colors.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito'),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: LocaleText(
                value: LocaleKeys.myList_emptyList_subtitle,
                style: TextStyle(
                    color: context.colors.primary,
                    fontSize: 20,
                    fontFamily: 'Nunito')),
          )
        ],
      );
    } else {
      return Column(
        children: [
          Image.asset(
            'assets/png/notFound.png',
            height: context.height * 0.2,
            width: context.height * 0.2,
          ),
          LocaleText(
            value: LocaleKeys.profile_empty_title,
            style: TextStyle(
                color: context.colors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito'),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: LocaleText(
                value: LocaleKeys.profile_empty_subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: context.colors.primary,
                    fontSize: 16,
                    fontFamily: 'Nunito')),
          )
        ],
      );
    }
  }
}
