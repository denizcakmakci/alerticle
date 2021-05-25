import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../device/constants.dart';
import '../../init/cache/locale_manager.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> addUsers(String token) async {
    var ref = _firestore.collection("users").doc(user);

    ref.set({
      'tokens': FieldValue.arrayUnion([token])
    }, SetOptions(merge: true));
  }

  Future<void> addLink(String type, String title, String url) async {
    var links = _firestore.collection("links");

    return links
        .add({
          'type': type,
          'title': title,
          'url': url,
          "deleted": false,
          'user_id': user,
          'time': FieldValue.serverTimestamp()
        })
        .then((value) => print('Link added!'))
        .catchError((err) => print(err));
  }

  Future<void> addAlarm(
      String hour, String label, List days, String type) async {
    var alarms = _firestore.collection("alarms");

    return alarms
        .add({
          'hour': hour,
          'label': label,
          'days': days,
          "type": type,
          'user_id': user,
          'active': true
        })
        .then((value) => print('Alarm added!'))
        .catchError((err) => print(err));
  }

  Future<List> getLink(String field, value, alert) async {
    var random = Random();
    var list = [];
    var listInfo = [];

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection("links")
          .where('user_id', isEqualTo: user)
          .where('deleted', isEqualTo: false)
          .where(field, isEqualTo: value)
          .get();

      querySnapshot.docs.forEach((doc) {
        list.add(doc);
      });

      var rnd = random.nextInt(list.length);
      listInfo.add(list[rnd]['title']);
      listInfo.add(list[rnd]['url']);

      return listInfo;
    } catch (e) {
      print(e);
      return alert;
    }
  }

  Stream<QuerySnapshot> getLinkWithQuery(String field, value) {
    var ref = _firestore
        .collection("links")
        .where('user_id', isEqualTo: user)
        .where(field, isEqualTo: value)
        .snapshots();
    return ref;
  }

  Stream<QuerySnapshot> getLinkWithMultiQuery(
      String field, value, String field2, value2) {
    var ref = _firestore
        .collection("links")
        .where('user_id', isEqualTo: user)
        .where(field, isEqualTo: value)
        .where(field2, isEqualTo: value2)
        .snapshots();
    return ref;
  }

  Stream<QuerySnapshot> getAlarmWithQuery() {
    var ref = _firestore
        .collection("alarms")
        .where('user_id', isEqualTo: user)
        .snapshots();
    return ref;
  }

  Future<dynamic> getLinkById(String docId) async {
    DocumentSnapshot doc =
        await _firestore.collection("links").doc(docId).get();
    if (doc.exists) {
      return doc.data();
    } else {
      return null;
    }
  }

  Future<void> softDeleteLink(String docId, bool value) {
    return _firestore
        .collection("links")
        .doc(docId)
        .update({'deleted': value, 'time': FieldValue.serverTimestamp()})
        .then((value) => print("Link soft deleted."))
        .catchError((err) => print(err));
  }

  Future<void> deleteLink(String docId) {
    return _firestore
        .collection("links")
        .doc(docId)
        .delete()
        .then((value) => print("Link deleted."))
        .catchError((err) => print(err));
  }

  Future<void> alarmActiveChange(String docId, bool active) {
    return _firestore
        .collection("alarms")
        .doc(docId)
        .update({'active': active})
        .then((value) => print("Alarm is $active"))
        .catchError((err) => print(err));
  }

  Future<void> deleteAlarm(String docId) {
    return _firestore
        .collection("alarms")
        .doc(docId)
        .delete()
        .then((value) => print("Alarm deleted."))
        .catchError((err) => print(err));
  }
}
