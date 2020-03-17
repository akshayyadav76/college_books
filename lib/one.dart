import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import './pdf_screen.dart';




class MyApp extends StatefulWidget {
  
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String pathPDF = "";
  String corruptedPathPDF = "";


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


  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PDF View',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(child: Builder(
          builder: (BuildContext context) {
            return Column(
              children: <Widget>[

                RaisedButton(
                  child: Text("Open PDF"),
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
                RaisedButton(
                  child: Text("Open Corrupted PDF"),
                  onPressed: () {
                    if (pathPDF != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PdfScreen(path: corruptedPathPDF),
                        ),
                      );
                    }
                  },
                )
              ],
            );
          },
        )),
      ),
    );
  }
}
