import 'package:BookClub/states/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME SCREEN"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            CurrentUser _currentUser =
                Provider.of<CurrentUser>(context, listen: false);
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }
}
