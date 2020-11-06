import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    try {
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;

      final AuthCredential _authCredential = GoogleAuthProvider.credential(
          accessToken: _googleAuth.accessToken, idToken: _googleAuth.idToken);

      UserCredential _userCredential =
          await _auth.signInWithCredential(_authCredential);

      _uid = _userCredential.user.uid;
      _email = _userCredential.user.email;
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      // ignore: await_only_futures
      User _firebaseUser = await _auth.currentUser;
      _uid = _firebaseUser.uid;
      _email = _firebaseUser.email;
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> onSignOut() async {
    String retVal = "error";

    try {
      // ignore: await_only_futures
      await _auth.signOut();
      _uid = null;
      _email = null;
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
