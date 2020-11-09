import 'package:BookClub/models/user.dart';
import 'package:BookClub/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  OurUser _currentUser = OurUser();

  OurUser get getCurrentUser => _currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser(
      String email, String password, String fullName) async {
    String retVal = "error";
    OurUser _user = OurUser();

    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = _authResult.user.uid;
      _user.emailAddress = _authResult.user.email;
      _user.fullName = fullName;

      String _returnString = await OurDatabase().createUser(_user);

      if (_returnString == "success") {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> loginWithEmail(String email, String password) async {
    String retVal = "error";

    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _currentUser = await OurDatabase().getUserInfo(_userCredential.user.uid);
      if (_currentUser != null) {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      print(e);
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

    OurUser _user = OurUser();

    try {
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;

      final AuthCredential _authCredential = GoogleAuthProvider.credential(
        accessToken: _googleAuth.accessToken,
        idToken: _googleAuth.idToken,
      );

      UserCredential _userCredential =
          await _auth.signInWithCredential(_authCredential);

      if (_userCredential.additionalUserInfo.isNewUser) {
        _user.uid = _userCredential.user.uid;
        _user.emailAddress = _userCredential.user.email;
        _user.fullName = _userCredential.user.displayName;
        OurDatabase().createUser(_user);
      }

      _currentUser = await OurDatabase().getUserInfo(_userCredential.user.uid);
      if (_currentUser != null) {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
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
      _currentUser.uid = _firebaseUser.uid;
      _currentUser.emailAddress = _firebaseUser.email;
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> onSignOut() async {
    String retVal = "error";

    try {
      await _auth.signOut();
      _currentUser = OurUser();
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
