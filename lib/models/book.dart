import 'package:cloud_firestore/cloud_firestore.dart';

class OurBook {
  String bookId;
  String bookName;
  int bookLength;
  Timestamp dateCompleted;

  OurBook({
    this.bookId,
    this.bookName,
    this.bookLength,
    this.dateCompleted,
  });
}
