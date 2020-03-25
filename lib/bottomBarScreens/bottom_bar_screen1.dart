import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../book_model.dart';
import '../pdf_screen.dart';

String pathPDF = "";
String corruptedPathPDF = "";
List<BookModel> data = BookModel.mca;

Future<File> createFileOfPdfUrl() async {
  // final url =
  // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
  final url = "https://pdfkit.org/docs/guide.pdf";
  final filename = url.substring(url.lastIndexOf("/") + 1);
  var request = await HttpClient().getUrl(Uri.parse(url));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/$filename');
  await file.writeAsBytes(bytes);
  return file;
}

class BottomBarScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.drag_handle),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }),
            Expanded(
              child: RaisedButton(
                child: Text(
                  "College Books",
                  style: Theme.of(context).textTheme.title,
                ),
                onPressed: () {
                  if (pathPDF != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfScreen(path: pathPDF),
                      ),
                    );
                  }
                },
              ),
            ),
            PopupMenuButton(
                icon: Icon(Icons.filter_list),
                itemBuilder: (context) => [
                      PopupMenuItem(
                      
                        child: PopupMenuButton(
                          padding: EdgeInsets.zero,
                          child: Row(
                            children: <Widget>[
                              Text("MCA"),
                              Icon(Icons.arrow_right),
                            ],
                          ),
                          itemBuilder: (context)=>[
                            PopupMenuItem(
                              child:Text("Sem 1") ),  PopupMenuItem(
                              child:Text("Sem 2") ),  PopupMenuItem(
                              child:Text("Sem 3") ),  PopupMenuItem(
                              child:Text("Sem 4") ),  PopupMenuItem(
                              child:Text("Sem 5") ),  PopupMenuItem(
                              child:Text("Sem 6") ),
                          ],
                        ),
                      ),
                    ]),
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 130,
                      width: 150,
                      color: Colors.purple,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Card(
                        child: Image.asset(
                          data[i].bookCover,
                          fit: BoxFit.fill,
                        ),
                        elevation: 7,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            data[i].bookName,
                            style: Theme.of(context).textTheme.title,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Samester: ${data[i].semester}",
                            style: TextStyle(fontSize: 17),
                          ),
                          IconButton(
                            icon: Icon(Icons.cloud_download),
                            onPressed: () {},
                          )
                        ],
                      ),
                    )
                  ],
                );
              }),
        ),
      ],
    );
  }
}
