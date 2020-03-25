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

static List<List<BookModel>> mca=[
[
       BookModel(
         bookCodeNameId:"C01" ,
          bookName:  "Progaramming & Problem Solving In C",
          bookCover: "assets/mca/Sem1/C01",
          semester: 01,
          url:  "http://download1586.mediafire.com/5bp009xy2kcg/sb2v1cy7lye4q0e/smple1.pdf" ,
       ),
        BookModel(
         bookCodeNameId:"CO&AL01" ,
          bookName:  "Computer Organisation & Assembly Language Programming",
          bookCover: "assets/mca/Sem1/CO&AL01",
          semester: 01,
          url:  "http://download1586.mediafire.com/5bp009xy2kcg/sb2v1cy7lye4q0e/smple1.pdf" ,
       ),
        BookModel(
         bookCodeNameId:"CS01" ,
          bookName:  "Communication Skills",
          bookCover: "assets/mca/Sem1/CS01",
          semester: 01,
          url:  "http://download1586.mediafire.com/5bp009xy2kcg/sb2v1cy7lye4q0e/smple1.pdf" ,
       ),
        BookModel(
         bookCodeNameId:"IT01" ,
          bookName:  "Information Technology",
          bookCover: "assets/mca/Sem1/IT01",
          semester: 01,
          url:  "http://download1586.mediafire.com/5bp009xy2kcg/sb2v1cy7lye4q0e/smple1.pdf" ,
       ),
        BookModel(
         bookCodeNameId:"MF01" ,
          bookName:  "Mathematical Foundation Of Computer Science",
          bookCover: "assets/mca/Sem1/MF01",
          semester: 01,
          url:  "http://download1586.mediafire.com/5bp009xy2kcg/sb2v1cy7lye4q0e/smple1.pdf" ,
       ),
     ],
[
   BookModel(
         bookCodeNameId:"AMC02" ,
          bookName:  "Accounting & Management Control",
          bookCover: "assets/mca/Sem1/AMC02",
          semester: 02,
          url:  "http://download1586.mediafire.com/5bp009xy2kcg/sb2v1cy7lye4q0e/smple1.pdf" ,
       ),
       BookModel(
         bookCodeNameId:"CON02" ,
          bookName:  "Computer Oriented Numberical & Statistical Methods",
          bookCover: "assets/mca/Sem1/CON02",
          semester: 02,
          url:  "http://download1586.mediafire.com/5bp009xy2kcg/sb2v1cy7lye4q0e/smple1.pdf" ,
       ),
       BookModel(
         bookCodeNameId:"DM02" ,
          bookName:  "Database Management System",
          bookCover: "assets/mca/Sem1/DM02",
          semester: 02,
          url:  "http://download1586.mediafire.com/5bp009xy2kcg/sb2v1cy7lye4q0e/smple1.pdf" ,
       ),
       BookModel(
         bookCodeNameId:"DS02" ,
          bookName:  "Data Structure",
          bookCover: "assets/mca/Sem1/DS02",
          semester: 02,
          url:  "http://download1586.mediafire.com/5bp009xy2kcg/sb2v1cy7lye4q0e/smple1.pdf" ,
       ),
       BookModel(
         bookCodeNameId:"OS02" ,
          bookName:  "Operating System",
          bookCover: "assets/mca/Sem1/OS02",
          semester: 02,
          url:  "http://download1586.mediafire.com/5bp009xy2kcg/sb2v1cy7lye4q0e/smple1.pdf" ,
       ),
] 

];


}


