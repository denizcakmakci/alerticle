import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  String id;
  String type;
  String title;
  String url;

  Status({this.id, this.type, this.title, this.url});

  factory Status.fromSnapshot(DocumentSnapshot snapshot) {
    return Status(
      id: snapshot.id,
      type: snapshot["type"],
      title: snapshot["title"],
      url: snapshot["url"],
    );
  }
}
