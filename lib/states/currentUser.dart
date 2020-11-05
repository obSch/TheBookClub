import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUser extends ChangeNotifier {
  String _uid;
  String _email;

  String get getUid => _uid;

  String get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser(String email, String password) async {
    String retVal = "error";

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      retVal = "success";
    } catch (e) {
      retVal = e.message;
    }

    return retVal;
  }

  Future<String> loginWithEmail(String email, String password) async {
    String retVal = "error";

    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _uid = _userCredential.user.uid;
      _email = _userCredential.user.email;
      retVal = "success";
    } catch (e) {
      retVal = e.message;
    }

    return retVal;
  }

  Future<String> loginWithGoogle() async {
    String retVal = "error";

    try {
      UserCredential _userCredential = await _auth.signInWithGoogle();
      if (_userCredential != null) {
        _uid = _userCredential.user.uid;
        _email = _userCredential.user.email;
        retVal = "success";
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
