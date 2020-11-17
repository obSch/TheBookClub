import 'package:BookClub/models/book.dart';
import 'package:BookClub/models/group.dart';
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

  // get group info
  Future<OurGroup> getGroupInfo(String groupId) async {
    OurGroup group = OurGroup();

    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("groups").doc(groupId).get();
      group.id = groupId;
      group.groupName = _docSnapshot.get("name");
      group.groupLeader = _docSnapshot.get("leader");
      group.groupMembers = List<String>.from(_docSnapshot.get("members"));
      group.groupCreated = _docSnapshot.get("groupCreated");
      group.currentBookId = _docSnapshot.get("currentBookId");
      group.currentBookDue = _docSnapshot.get("currentBookDue");
    } catch (e) {
      print(e);
    }
    return group;
  }

  // get book info
  Future<OurBook> getCurrentBookInfo(String groupId, String bookId) async {
    OurBook book = OurBook();

    try {
      DocumentSnapshot _docSnapshot = await _firestore
          .collection("groups")
          .doc(groupId)
          .collection("books")
          .doc(bookId)
          .get();
      book.bookId = bookId;
      book.bookName = _docSnapshot.get("name");
      book.bookLength = _docSnapshot.get("length");
      book.dateCompleted = _docSnapshot.get("dateCompleted");
    } catch (e) {
      print(e);
    }
    return book;
  }
}
