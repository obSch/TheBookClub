import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String uid;
  String emailAddress;
  String fullName;
  Timestamp accountCreated;
  String groupId;

  OurUser({
    this.uid,
    this.emailAddress,
    this.fullName,
    this.accountCreated,
    this.groupId,
  });
}
