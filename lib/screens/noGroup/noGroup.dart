import 'package:BookClub/screens/createGroup/createGroup.dart';
import 'package:BookClub/screens/joinGroup/joinGroup.dart';
import 'package:flutter/material.dart';

class OurNoGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _goToJoin(BuildContext context) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OurJoinGroup(),
        ),
      );
    }

    void _goToCreate(BuildContext context) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OurCreateGroup(),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Spacer(),
          Padding(
            padding: EdgeInsets.all(80.0),
            child: Image.asset("assets/logo.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55.0),
            child: Text(
              "Welcome to the Book Club",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.0, color: Colors.grey[600]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
              "Since you are not in a book club, you can select to either " +
                  "join a club or create a club.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25.0, color: Colors.grey),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Create Group"),
                  onPressed: () => _goToCreate(context),
                  color: Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
                RaisedButton(
                  child: Text(
                    "Join Group",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => _goToJoin(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
