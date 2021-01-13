import 'dart:async';

import 'package:college_books/data/database/database_model.dart';

import 'package:flutter/material.dart';

import '../pdf_screen.dart';





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
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      }),
                  Expanded(
                      child: Text(
                    "College Books",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: data.data.length,
                    itemBuilder: (context, i) {
                      return Dismissible(
                        key: ValueKey(data.data[i]["bookCodeNameId"]),
                        background: Container(
                          color: Colors.red,
                        ),
                        confirmDismiss: (d) async {
                          bool value = false;
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content:
                                      Text(" Do You Really Want To Delete?"),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("No")),
                                    FlatButton(
                                        onPressed: () {
                                          DatabaseModel.delete("saved",
                                              data.data[i]["bookCodeNameId"]);
                                          Navigator.of(context).pop();
                                          setState(() {
                                            value = true;
                                          });
                                        },
                                        child: Text("Yes"))
                                  ],
                                );
                              });
                          return value;
                        },
                        child: InkWell(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    PdfScreen(data.data[i]["bookPath"])));
                            print(data.data[i]["bookPath"]);
                          },
                          splashColor: Colors.purple,
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
                                  elevation: 15,
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
                        ),
                      );
                    }),
              ),
            ],
          );
        } else {
          return Center(
              child: Text(
                
            "Pehele Download to Karlo, tabhi to kuch dikhe gaa :)",
            style: TextStyle(fontSize: 30),
          ));
        }
      },
    );
  }
}
