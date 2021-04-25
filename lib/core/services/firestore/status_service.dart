import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasarim_proje/core/device/constants.dart';
import 'package:tasarim_proje/core/init/cache/locale_manager.dart';
import 'package:tasarim_proje/core/services/firestore/status.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN);

  Future<void> addStatus(String type, String title, String url) async {
    var ref = _firestore.collection("Users").doc(user);

    ref.update({
      'list': FieldValue.arrayUnion([
        {'type': type, 'title': title, 'url': url}
      ])
    });
  }

  Future<void> addEmptyDoc() async {
    var ref = _firestore.collection("Users");

    var documentRef = await ref.doc(user).set({
      'list': FieldValue.arrayUnion([]),
    });

    return documentRef;
  }

  //status göstermek için
  Stream<DocumentSnapshot> getStatus() {
    var ref = _firestore.collection("Users").doc(user).snapshots();

    return ref;
  }

  Future<dynamic> getDocByID() async {
    DocumentSnapshot doc = await _firestore.collection("Users").doc(user).get();
    if (doc.exists) {
      return doc.data()['list'];
    } else {
      return null;
    }
  }

  Future<bool> isDocExists() async {
    DocumentSnapshot doc = await _firestore.collection("Users").doc(user).get();
    if (doc.exists) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  //status silmek için
  Future<void> removeStatus(String docId) {
    var ref = _firestore.collection("Users").doc(docId).delete();
    return ref;
  }
}
