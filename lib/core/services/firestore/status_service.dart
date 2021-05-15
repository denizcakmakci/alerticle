import 'package:cloud_firestore/cloud_firestore.dart';
import '../../device/constants.dart';
import '../../init/cache/locale_manager.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN);

  Future<void> addStatus(
      String type, String title, String url, bool isDeleted) async {
    var ref = _firestore.collection("Users").doc(user);

    ref.update({
      'list': FieldValue.arrayUnion([
        {'type': type, 'title': title, 'url': url, "isDeleted": isDeleted}
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

  Future<void> deleteData(var docId) {
    var ref = _firestore.collection("Users").doc(user).update({
      "list.$docId.isDeleted": true,
    }).then((value) {
      print("delete");
    });
    return ref;
  }

  Future<void> removeStatus(var docId) {
    var ref = _firestore.collection("Users").doc(user).update({
      "list": FieldValue.arrayRemove([docId])
    }).then((value) {
      print("delete");
    }).catchError((error) {
      print(error);
    });
    return ref;
  }
}
