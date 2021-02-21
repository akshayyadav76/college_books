import 'package:college_books/ui/screen/chat_screen.dart';
import 'package:college_books/ui/widgets/app_drawer.dart';
import 'package:flutter/material.dart';


import './bottomBarScreens/bottom_bar_screen1.dart';
import './bottomBarScreens/bottom_bar_screen2.dart';
import '../theme/extention.dart';

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   var _scaffoldKey = new GlobalKey<ScaffoldState>();



List<Widget>bottomNavigationScreens=[
BottomBarScreen1(),
BottomBarScreen2(),
];

int index =0;

  Widget build(BuildContext context) {
    
    return SafeArea(
          child: Scaffold(
          
           floatingActionButton: FloatingActionButton(

             child: Icon(Icons.chat),
             onPressed:(){
               Navigator.push(context,MaterialPageRoute(builder: (context)=>ChatScreen()));
             }
           ),
          drawer: AppDrawer(_scaffoldKey),
          bottomNavigationBar: BottomNavigationBar(
          fixedColor: Theme.of(context).accentColor,unselectedItemColor: Theme.of(context).accentColor,
          selectedLabelStyle: TextStyle(fontSize: 20.sp,color: Theme.of(context).accentColor),
          unselectedLabelStyle: TextStyle(fontSize: 15.sp,color: Theme.of(context).accentColor),
          backgroundColor: Theme.of(context).primaryColor,
            currentIndex: index,
            onTap: (s){
              setState(() {
                index = s; 
              });
            },
            items: [
            BottomNavigationBarItem(
              
                label: "All Books", icon: Icon(Icons.dashboard,color: Theme.of(context).accentColor,)),
            BottomNavigationBarItem(
                label: "Downloaded", icon: Icon(Icons.file_download,color: Theme.of(context).accentColor,)),
          ]
          ),
          body:  bottomNavigationScreens[index],
          ),
    );
  }
}


