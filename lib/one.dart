import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import './pdf_screen.dart';




class MyApp extends StatefulWidget {
  
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String pathPDF = "";
  String corruptedPathPDF = "";

  
  void initState() {
    super.initState();

    fromAsset('assets/smple1.pdf', 'smple1.pdf').then((f) {
      setState(() {
        corruptedPathPDF = f.path;
      });
    });

    // fromAsset('assets/smple2.pdf', 'smple2.pdf').then((f) {
    //   setState(() {
    //     pathPDF = f.path;
    //   });
    // });
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }

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


  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
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
