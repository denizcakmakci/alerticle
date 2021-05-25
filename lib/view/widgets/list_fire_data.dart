import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasarim_proje/core/widgets/locale_text.dart';
import 'package:tasarim_proje/view/constants/image_path_svg.dart';

import '../../core/init/lang/locale_keys.g.dart';
import '../../core/services/firestore/status_service.dart';
import '../myList/mylist_view_model.dart';
import 'card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/init/extensions/context_extension.dart';
import '../../core/init/extensions/extensions.dart';

StatusService statusService = StatusService();
MyListViewModel model = MyListViewModel();

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

openURL(String url) async {
  if (await canLaunch(url)) {
    print('opened link');
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

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
            return new Center(child: new CircularProgressIndicator());
          default:
            List<DocumentSnapshot> doc = snapshot.data.docs;
            return snapshot.hasData != null && doc.isNotEmpty
                ? ListView(
                    key: GlobalKey(),
                    children: doc.map((DocumentSnapshot doc) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 25),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
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
                                if (direction == DismissDirection.endToStart) {
                                  return await alertDelete(context, doc);
                                } else {
                                  return await alertBackList(context, doc);
                                }
                              },
                              child: buildbaseCard(doc, context)),
                        ),
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      );
                    }).toList())
                : Center(child: emptyList(context, page));
        }
      },
    );
  }

  BaseCard buildbaseCard(doc, BuildContext context) {
    return BaseCard(
        icon: iconSelect(doc['type'], context),
        title: new Text(
          doc['title'] ?? 'null',
          style: Theme.of(context).textTheme.headline1.copyWith(
              fontWeight: FontWeight.w900,
              color: context.colors.primaryVariant,
              fontSize: 16),
        ),
        subtitle: new Text(
          doc['url'] ?? 'null',
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: context.colors.primaryVariant, fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
        function: () {
          if (page == 'list') {
            alertOpenLink(context, doc);
          }
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
          title: Text(LocaleKeys.card_alertbacklist_title.locale),
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
                openURL(doc['url']);
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
  Widget emptyList(BuildContext context, String page) {
    if (page == 'list') {
      return Column(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(0, 50, 0, 40),
              child: Image.asset('assets/png/listEmpty.png')),
          LocaleText(
            value: LocaleKeys.myList_emptyList_title,
            style: TextStyle(color: context.colors.primary, fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          LocaleText(
              value: LocaleKeys.myList_emptyList_subtitle,
              style: TextStyle(color: context.colors.primary, fontSize: 20))
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Image.asset(
            'assets/png/notFound.png',
            height: 250,
            width: 250,
          ),
          LocaleText(
              value: LocaleKeys.myList_emptyList_subtitle,
              style: TextStyle(color: context.colors.primary, fontSize: 20))
        ],
      );
    }
  }
}
