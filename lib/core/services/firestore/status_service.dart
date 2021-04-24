import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasarim_proje/core/services/firestore/status.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addStatus(String type, String title, String url) async {
    var ref = _firestore.collection("Status");

    var documentRef = await ref.add({'type': type, 'title': title, 'url': url});

    return Status(id: documentRef.id, type: type, title: title, url: url);
  }

  //status göstermek için
  Stream<QuerySnapshot> getStatus() {
    var ref = _firestore.collection("Status").snapshots();

    return ref;
  }

  //status silmek için
  Future<void> removeStatus(String docId) {
    var ref = _firestore.collection("Status").doc(docId).delete();
    return ref;
  }
}
