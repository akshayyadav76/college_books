import 'dart:io';

import 'package:college_books/data/models/papers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'package:connectivity/connectivity.dart';
import './pdf_screen.dart';





class PapersScreen extends StatefulWidget {
  @override
  _PapersScreenState createState() => _PapersScreenState();
}

class _PapersScreenState extends State<PapersScreen> {
  int index = 0;

  List<Paper> allpapers = AllPapers().papers[0];

  //final _scaffoldKey = GlobalKey<ScaffoldState>();

  File file;

  bool isLoding = false;

  Future<void> cacheFile(String url) async {
    final store = await CacheStore.getInstance();

    file = await store.getFile(url);
    print(" dowanlod ${file.path}");
    // do something with file...
  }

  void todo(int index) {
    allpapers = AllPapers().papers[index];
  }

  Future<void> deleteCache() async {
    file.delete().then((sf) {
      print("then delete ${file.path}");
    });

    setState(() {
      isLoding = false;
      print(" delete ${file.path}");
    });
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      var dilog = AlertDialog(
        content: Text("Please turn on Internet and Restart the App"),
      );

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (df) {
            return dilog;
          });
      return false;
    }
    return null;
   }
//
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
     // key: _scaffoldKey,
      //drawer: AppDrawer(),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    // child: IconButton(
                    //     icon: Icon(
                    //       Icons.menu,
                    //       size: 30,
                    //     ),
                    //     onPressed: () {
                    //       _scaffoldKey.currentState.openDrawer();
                    //     }),
                  ),
                  Expanded(
                      child: Text(
                    "Papers",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  )),
                  PopupMenuButton(
                      icon: Icon(
                        Icons.filter_list,
                        size: 30,
                      ),
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
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: Text("Sem 1"),
                                    value: 0,
                                  ),

                                  PopupMenuItem(
                                    child: Text("Sem 2"),
                                    value: 1,
                                  ),

                                  PopupMenuItem(
                                    child: Text("Sem 3"),
                                    value: 2,
                                  ),

                                  PopupMenuItem(
                                    child: Text("Sem 4"),
                                    value: 3,
                                  ),

                                  // PopupMenuItem(

                                  //   child: Text("Sem 5"),

                                  //   value: 4,

                                  // ),

                                  // PopupMenuItem(

                                  //   child: Text("Sem 6"),

                                  //   value: 5,

                                  // ),
                                ],
                                onSelected: (selectedValue) {
                                  todo(selectedValue);

                                  setState(() {
                                    print(selectedValue);

                                    //popSelectedIndex = selectedValue;

                                    //  print(popSelectedIndex);
                                  });
                                },
                              ),
                            ),
                          ]),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: allpapers.length,
                    itemBuilder: (context, i) {
                      return Container(
                        height: 80,
                        child: InkWell(
                          splashColor: Theme.of(context).primaryColor,
                          onTap: () {
                            checkInternet().then((val) {
                              if (val) {
                                setState(() {
                                  isLoding = true;
                                });
                                cacheFile(allpapers[i].url).then((val) {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return PdfScreen(file.path);
                                  })).then((see) {
                                    deleteCache();
                                  });
                                });
                              } else {
                                print("no connection");
                              }
                            });
                          },
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  allpapers[i].paparName,
                                  style: Theme.of(context).textTheme.title,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  allpapers[i].year,
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
          isLoding ? Center(child: CircularProgressIndicator()) : Container()
        ],
      ),
    ));
  }
}
