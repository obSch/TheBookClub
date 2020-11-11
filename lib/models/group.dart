import 'package:cloud_firestore/cloud_firestore.dart';

class OurGroup {
  String id;
  String groupName;
  String groupLeader;
  List<String> groupMemebers;
  Timestamp groupCreated;

  OurGroup({
    this.id,
    this.groupName,
    this.groupLeader,
    this.groupMemebers,
    this.groupCreated,
  });
}
