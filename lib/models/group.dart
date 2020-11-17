import 'package:cloud_firestore/cloud_firestore.dart';

class OurGroup {
  String id;
  String groupName;
  String groupLeader;
  List<String> groupMembers;
  Timestamp groupCreated;
  String currentBookId;
  Timestamp currentBookDue;

  OurGroup({
    this.id,
    this.groupName,
    this.groupLeader,
    this.groupMembers,
    this.groupCreated,
    this.currentBookId,
    this.currentBookDue,
  });
}
