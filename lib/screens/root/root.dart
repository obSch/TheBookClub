import 'package:BookClub/screens/home/home.dart';
import 'package:BookClub/screens/login/login.dart';
import 'package:BookClub/screens/noGroup/noGroup.dart';
import 'package:BookClub/screens/splash/splashScreen.dart';
import 'package:BookClub/states/currentGroup.dart';
import 'package:BookClub/states/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  notLoggedIn,
  unknown,
  notInGroup,
  inGroup,
}

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.unknown;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    /**
   * Get app state
   * Check the current User
   * Set AuthStatus
   */
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();

    if (_returnString == "success") {
      if (_currentUser.getCurrentUser.groupId != null) {
        setState(
          () {
            _authStatus = AuthStatus.inGroup;
          },
        );
      } else {
        setState(
          () {
            _authStatus = AuthStatus.notInGroup;
          },
        );
      }
    } else {
      setState(
        () {
          _authStatus = AuthStatus.notLoggedIn;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.unknown:
        retVal = OurSplashScreen();
        break;
      case AuthStatus.notLoggedIn:
        retVal = OurLogin();
        break;
      case AuthStatus.notInGroup:
        retVal = OurNoGroup();
        break;
      case AuthStatus.inGroup:
        retVal = ChangeNotifierProvider(
          create: (context) => CurrentGroup(),
          child: HomeScreen(),
        );
        break;
      default:
    }

    return retVal;
  }
}
