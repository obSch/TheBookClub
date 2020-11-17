import 'package:BookClub/models/book.dart';
import 'package:BookClub/models/group.dart';
import 'package:BookClub/services/database.dart';
import 'package:flutter/material.dart';

class CurrentGroup extends ChangeNotifier {
  OurGroup _currentGroup = OurGroup();
  OurBook _currentBook = OurBook();

  OurBook get getCurrentBook => _currentBook;
  OurGroup get getCurrentGroup => _currentGroup;

  void updateStateFromDatabase(String groupId) async {
    try {
      /**
       * Get group info from database
       * Get book info from database */
      _currentGroup = await OurDatabase().getGroupInfo(groupId);
      _currentBook = await OurDatabase()
          .getCurrentBookInfo(groupId, getCurrentGroup.currentBookId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
