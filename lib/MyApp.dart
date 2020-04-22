import 'package:flutter/material.dart';

import './bottomBarScreens/bottom_bar_screen1.dart';
import './bottomBarScreens/bottom_bar_screen2.dart';
import './app_drawer.dart';

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {




List<Widget>bottomNavigationScreens=[
BottomBarScreen1(),
BottomBarScreen2(),
];

int index =0;

  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
           backgroundColor: Colors.white,
          drawer: AppDrawer(),
          bottomNavigationBar: BottomNavigationBar(
          
            currentIndex: index,
            onTap: (s){
              setState(() {
                index = s; 
              });
            },
            items: [
            BottomNavigationBarItem(
                title: Text("All Books"), icon: Icon(Icons.dashboard)),
            BottomNavigationBarItem(
                title: Text("Downloaded"), icon: Icon(Icons.file_download)),
          ]),
          body:  bottomNavigationScreens[index],
          ),
    );
  }
}


