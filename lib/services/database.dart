import 'package:BookClub/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// create user in database
  Future<String> createUser(OurUser ourUser) async {
    String retVal = "error";

    try {
      await _firestore.collection("users").doc(ourUser.uid).set({
        'fullName': ourUser.fullName,
        'email': ourUser.emailAddress,
        'accountCreated': Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

// get user information from database
  Future<OurUser> getUserInfo(String uid) async {
    OurUser user = OurUser();

    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      user.uid = uid;
      user.fullName = _docSnapshot.get("fullName");
      user.emailAddress = _docSnapshot.get("email");
      user.accountCreated = _docSnapshot.get("accountCreated");
      user.groupId = _docSnapshot.get("groupId");
    } catch (e) {
      print(e);
    }
    return user;
  }

  // create group in database
  Future<String> createGroup(String groupName, String userId) async {
    String retVal = "error";
    List<String> members = List();

    try {
      members.add(userId);
      DocumentReference _docRef = await _firestore.collection("groups").add({
        "name": groupName,
        "leader": userId,
        "members": members,
        "groupCreated": Timestamp.now(),
      });

      await _firestore
          .collection("users")
          .doc(userId)
          .update({"groupId": _docRef.id});

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

// join group
  Future<String> joinGroup(String groupId, String userId) async {
    String retVal = "error";
    List<String> members = List();

    try {
      members.add(userId);
      await _firestore.collection("groups").doc(groupId).update({
        "members": FieldValue.arrayUnion(members),
      });
      await _firestore
          .collection("users")
          .doc(userId)
          .update({"groupId": groupId});
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
