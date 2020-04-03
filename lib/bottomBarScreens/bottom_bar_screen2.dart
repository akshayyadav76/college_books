import 'dart:async';

import 'package:flutter/material.dart';
import '../database/database_model.dart';

import '../pdf_screen.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

Future<List<Map<String, dynamic>>> getSaved() async {
  var list = await DatabaseModel.read("saved");
  print(list[0]);
  return list;
}

class BottomBarScreen2 extends StatefulWidget {
  @override
  _BottomBarScreen2State createState() => _BottomBarScreen2State();
}

class _BottomBarScreen2State extends State<BottomBarScreen2> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSaved(),
      builder: (context, data) {
        if (data.hasData) {
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
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: data.data.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () async {

                          //   String pathfile;
                          // await  fromAsset(data.data[i]["bookPath"]).then((f){
                          // setState(() {
                          //   pathfile = f.path;
                          // });
                          // });

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PdfScreen(data.data[i]["bookPath"])));
                          print(data.data[i]["bookPath"]);
                        },
                        hoverColor: Colors.blue,
                        splashColor: Colors.red,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 150,
                              width: 120,
                              color: Colors.purple,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Card(
                                child: Image.asset(
                                  data.data[i]["bookCover"],
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
                                  data.data[i]['bookName'],
                                  style: Theme.of(context).textTheme.title,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Samester: ${data.data[i]['semester']}",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            )),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          );
        } else {
          return Text("Pehele Download to Karlo, abhi kuch nahi h khali");
        }
      },
    );
  }

  //  Future<File> fromAsset(String path) async {
  //   // To open from assets, you can copy them to the app storage folder, and the access them "locally"
  //   Completer<File> completer = Completer();

  //   try {
    
  //     File file = File(path);
  //     // var data = await rootBundle.load(asset);
  //     // var bytes = data.buffer.asUint8List();
  //     await file.readAsBytes();
  //     completer.complete(file);
  //   } catch (e) {
  //     throw Exception('Error parsing asset file!');
  //   }
  //   return completer.future;
  // }

  // Future<File> getBook(String name) async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   // String path = ;
  //   File file = File("${dir.path}/name.pdf");
  //   String content = await file.readAsString();
  //   print("object");
  //   print(content);
  // }
}
