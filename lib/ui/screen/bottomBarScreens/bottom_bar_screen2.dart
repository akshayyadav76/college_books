import 'dart:async';

import 'package:college_books/data/database/database_model.dart';
import 'package:flutter/material.dart';

import '../pdf_screen.dart';
import '../../theme/extention.dart';





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
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getSaved(),
      builder: (context, data) {
        if (data.hasData) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                     icon: Icon(Icons.menu,size: 15.h, color: Theme.of(context).accentColor,),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      }),
                  Expanded(
                 child: Text("College Books",style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.w400,
              color: Theme.of(context).accentColor),
              textAlign: TextAlign.center,)
            ),
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
                          splashColor: Theme.of(context).primaryColor,
                          child: Container(
                            width: size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 70.h,
                                  width: 125.w,
                                  color: Theme.of(context).accentColor,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8.h, vertical: 8.w),
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
                                        height: 5.h,
                                      ),
                                       Text(
                                          data.data[i]['bookName'],
                                          style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,
                            color: Theme.of(context).accentColor
                            ),
                                        
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Samester: ${data.data[i]['semester']}",
                                        style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,
                            color: Theme.of(context).accentColor
                            ),
                                      ),
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        } else {
          return Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(         
            "You haven't download any books yet :)",
            style: TextStyle(fontSize: 30.sp,color: Theme.of(context).accentColor),
          ),
              ));
        }
      },
    );
  }
}
