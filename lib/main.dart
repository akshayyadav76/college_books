import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import './MyApp.dart';

void main() {
  runApp( CollegeBooks());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark)
  );

} 

class CollegeBooks extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      

      theme: ThemeData(
        
        
        primaryColor: Colors.purple,
        primarySwatch: Colors.purple
        
        
      ),
      
      home: MyApp(),
    );
  }
}
