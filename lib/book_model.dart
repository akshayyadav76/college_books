import 'package:flutter/foundation.dart';

class BookModel{

final String bookCodeNameId;
final String bookName;
final String url;
final String bookCover;
final String bookPath;
final int semester;


BookModel({

 @required this.bookCodeNameId,
 @required this.bookName,
 @required this.bookCover,
 @required this.url,
 @required this.semester,
           this.bookPath,
           
           });

List<BookModel> mca=[

  BookModel(
  bookName: "Data Structure",
  bookCodeNameId: "DS01",
  semester: 01,
  bookCover: "assets/mca/download.jpg",
  url: "http://download1586.mediafire.com/5bp009xy2kcg/sb2v1cy7lye4q0e/smple1.pdf"),

  BookModel(
  bookName: "Operating System",
  bookCodeNameId: "OP01",
  semester: 01,
  bookCover: "assets/mca/download_2.jpg",
  url: "http://download1586.mediafire.com/5bp009xy2kcg/sb2v1cy7lye4q0e/smple1.pdf"),

];


}


