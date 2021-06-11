import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../view/constants/random_colors.dart';
import '../../device/constants.dart';
import '../../init/cache/locale_manager.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user =
      LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN); // user uid
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final name = FirebaseAuth.instance.currentUser.displayName; // user name

  Future<void> addUsers(String token) async {
    var ref = _firestore.collection("users").doc(user);

    ref.set({
      'tokens': FieldValue.arrayUnion([token]),
      'name': name
    }, SetOptions(merge: true));
  }

  Future<void> addLink(
      String type, String title, String url, String desc) async {
    var links = _firestore.collection("links");

    return links
        .add({
          'type': type,
          'title': title,
          'desc': desc,
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

    // gradient color variable for alarm cards
    GradientTemplate colors = GradientTemplate();
    var gradientColor =
        GradientTemplate.gradientTemplate[colors.randomindex].colors;

    return alarms
        .add({
          'hour': hour,
          'label': label,
          'days': days,
          "type": type,
          'user_id': user,
          'active': true,
          'time': FieldValue.serverTimestamp(),
          'color': gradientColor
        })
        .then((value) => print('Alarm added!'))
        .catchError((err) => print(err));
  }

  // Random link selection function according to the selected type
  Future<List> getLink(String field, value) async {
    var random = Random();
    var list = [];
    var listId = [];
    var listInfo = [];

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection("links")
          .where('user_id', isEqualTo: user)
          .where('deleted', isEqualTo: false)
          .where(field, isEqualTo: value)
          .get();

      querySnapshot.docs.forEach((doc) {
        listId.add(doc.id);
        list.add(doc);
      });

      var rnd = random.nextInt(list.length);
      listInfo.add(list[rnd]['title']);
      listInfo.add(list[rnd]['url']);
      listInfo.add(list[rnd]['desc']);
      listInfo.add(listId[rnd]);

      return listInfo;
    } catch (e) {
      print(e);
      return listInfo;
    }
  }

  Stream<QuerySnapshot> getLinkWithQuery(String field, value) {
    var ref = _firestore
        .collection("links")
        .where('user_id', isEqualTo: user)
        .where(field, isEqualTo: value)
        .orderBy('time', descending: true)
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
        .orderBy('time', descending: true)
        .snapshots();
    return ref;
  }

  Stream<QuerySnapshot> getAlarmWithQuery() {
    var ref = _firestore
        .collection("alarms")
        .where('user_id', isEqualTo: user)
        .orderBy('time', descending: true)
        .snapshots();
    return ref;
  }

  // The function that updates the delete field to throw the opened link to the history section(or for the opposite).
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
