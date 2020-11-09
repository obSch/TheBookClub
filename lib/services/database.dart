import 'package:BookClub/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<OurUser> getUserInfo(String uid) async {
    OurUser user = OurUser();

    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      user.uid = uid;
      user.fullName = _docSnapshot.get("fullName");
      user.emailAddress = _docSnapshot.get("email");
      user.accountCreated = _docSnapshot.get("accountCreated");
    } catch (e) {
      print(e);
    }
    return user;
  }
}
