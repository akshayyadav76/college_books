import 'package:flutter/material.dart';
import './extention.dart';

class ThemeConst{

  static String appName = "College books";

  //Colors for theme
//  Color(0xfffcfcff);
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  // static Color lightAccent = Colors.red;
  // static Color darkAccent = Colors.red[400];
  // static Color lightBG = Color(0xfffcfcff);
  // static Color darkBG = Colors.black;
  // static Color ratingBG = Colors.yellow[600];

  static ThemeData lightTheme = ThemeData(
  //  backgroundColor: Colors.white,
    primaryColor: Colors.white,
    accentColor:  Colors.black,
    scaffoldBackgroundColor: Colors.white,
    //cursorColor: lightAccent,
   // textTheme: TextTheme(),
   // appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 20.0.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
    //  iconTheme: IconThemeData(
    //    color: lightAccent,
    //  ),
 
  );

  static ThemeData darkTheme = ThemeData(
    //brightness: Brightness.dark,
    //backgroundColor: darkBG,
    primaryColor: Colors.black,
    accentColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    //cursorColor: darkAccent,
      textTheme: TextTheme(
        
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 20.0.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
    
    appBarTheme: AppBarTheme(
      // textTheme: TextTheme(
      //   headline6: TextStyle(
      //     color: lightBG,
      //     fontSize: 18.0.sp,
      //     fontWeight: FontWeight.w800,
      //   ),
      // ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
  );


}