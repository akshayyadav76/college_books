import 'package:flutter/foundation.dart';

class BookModel {
  final String bookCodeNameId;
  final String bookName;
  final String bookCover;
  final String url;
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
}

class AllBooks {
  List<List<BookModel>> mca = [
    [
      BookModel(
        bookCodeNameId: "C01",
        bookName: "Progaramming & Problem Solving In C",
        bookCover: "assets/mca/Sem1/C01.jpg",
        semester: 01,
        url:
            "",
      ),
      BookModel(
        bookCodeNameId: "CO&AL01",
        bookName: "Computer Organisation & Assembly Language Programming",
        bookCover: "assets/mca/Sem1/CO&AL01.jpg",
        semester: 01,
        url:
            "",
      ),
      BookModel(
        bookCodeNameId: "CS01",
        bookName: "Communication Skills",
        bookCover: "assets/mca/Sem1/CS01.jpg",
        semester: 01,
        url:
            "",
      ),
      BookModel(
        bookCodeNameId: "IT01",
        bookName: "Information Technology",
        bookCover: "assets/mca/Sem1/IT01.jpg",
        semester: 01,
        url:
            "",
      ),
      BookModel(
        bookCodeNameId: "MF01",
        bookName: "Mathematical Foundation Of Computer Science",
        bookCover: "assets/mca/Sem1/MF01.jpg",
        semester: 01,
        url:
            "",
      ),
    ],

    [
      BookModel(
        bookCodeNameId: "AMC02",
        bookName: "Accounting & Management Control",
        bookCover: "assets/mca/Sem2/AMC02.jpg",
        semester: 02,
        url:
            "",
      ),
      BookModel(
        bookCodeNameId: "CON02",
        bookName: "Computer Oriented Numberical & Statistical Methods",
        bookCover: "assets/mca/Sem2/CON02.jpg",
        semester: 02,
        url:
            "",
      ),
      BookModel(
        bookCodeNameId: "DM02",
        bookName: "Database Management System",
        bookCover: "assets/mca/Sem2/DM02.jpg",
        semester: 02,
        url:
            "",
      ),
      BookModel(
        bookCodeNameId: "DS02",
        bookName: "Data Structure",
        bookCover: "assets/mca/Sem2/DS02.jpg",
        semester: 02,
        url:
            "",
      ),
      BookModel(
        bookCodeNameId: "OS02",
        bookName: "Operating System",
        bookCover: "assets/mca/Sem2/OS02.jpg",
        semester: 02,
        url:
            "",
      ),],

    [
      BookModel(
        bookCodeNameId: "Cpp",
        bookName: "Objdect Oriented Methodology & C++",
        bookCover: "assets/mca/Sem3/C++03.jpg",
        semester: 03,
        url:
            "",
      ),
      BookModel(
        bookCodeNameId: "CN03",
        bookName: "Computer Networks",
        bookCover: "assets/mca/Sem3/CN03.jpg",
        semester: 03,
        url:
            "",
      ),
      BookModel(
        bookCodeNameId: "COOT03",
        bookName: "Computer Oriented Optimization Techniques",
        bookCover: "assets/mca/Sem3/COOT03.jpg",
        semester: 03,
        url:
            "",
      ),
      BookModel(
        bookCodeNameId: "SEM03",
        bookName: "Software Engineering Methodologies",
        bookCover: "assets/mca/Sem3/SEM03.jpg",
        semester: 03,
        url:
            "",
      ),
      BookModel(
        bookCodeNameId: "TOC03",
        bookName: "Theory of Computation",
        bookCover: "assets/mca/Sem3/TOC03.jpg",
        semester: 03,
        url:
            "",
      ),],

    [
      BookModel(
        bookCodeNameId: "AI04",
        bookName: "Artificial Intelligence & Applications",
        bookCover: "assets/mca/Sem4/AI04.jpg",
        semester: 04,
        url:
            "https://firebasestorage.googleapis.com/v0/b/collegebooks-29b42.appspot.com/o/mca%2Fsem%204%2Fartificial%20interlligence%20%26%20applications.pdf?alt=media&token=3cb3fc50-8341-456a-b8e3-9d1b40d74fd7",
      ),
      BookModel(
        bookCodeNameId: "CG04",
        bookName: "Computer Graphics & Multimedia",
        bookCover: "assets/mca/Sem4/CG04.jpg",
        semester: 04,
        url:
            "https://firebasestorage.googleapis.com/v0/b/collegebooks-29b42.appspot.com/o/mca%2Fsem%204%2Fcomputer%20graphics%20%26%20multimedia.pdf?alt=media&token=fa5a12f1-a845-4cad-bc6c-c1a3c3bfcdc5",
      ),
      BookModel(
        bookCodeNameId: "D&A04",
        bookName: "Design & Analysis of Algorithm",
        bookCover: "assets/mca/Sem4/D&A04.jpg",
        semester: 04,
        url:
            "https://firebasestorage.googleapis.com/v0/b/collegebooks-29b42.appspot.com/o/mca%2Fsem%204%2Fdesign%20%26%20analysis%20of%20algorithm.pdf?alt=media&token=f2f2275a-423e-4756-acc9-3b91bf6b2ecc",
      ),
      BookModel(
        bookCodeNameId: "ISM04",
        bookName: "Information Storage & Management",
        bookCover: "assets/mca/Sem4/ISM04.jpg",
        semester: 04,
        url:
            "https://firebasestorage.googleapis.com/v0/b/collegebooks-29b42.appspot.com/o/mca%2Fsem%204%2Finformation%20storage%20%26%20management.pdf?alt=media&token=c2a08f1d-cec2-4c76-8ddf-f458b5ea4f59",
      ),
      BookModel(
        bookCodeNameId: "JAVA04",
        bookName: "Java Programming",
        bookCover: "assets/mca/Sem4/JAVA04.jpg",
        semester: 04,
        url:
            "https://firebasestorage.googleapis.com/v0/b/collegebooks-29b42.appspot.com/o/mca%2Fsem%204%2Fjava%20programming.pdf?alt=media&token=a870d2e2-ee31-4fc9-b6df-0d31531864c0",
      ),],
      
];
}
