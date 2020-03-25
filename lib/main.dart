import 'package:flutter/material.dart';
import './MyApp.dart';

void main() => runApp(CollegeBooks());

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
