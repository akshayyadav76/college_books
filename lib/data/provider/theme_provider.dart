import 'package:college_books/ui/theme/theme_const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeProvider(){
    checkTheme();
  }


  ThemeData theme = ThemeConst.lightTheme;
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }

  void setTheme(value, c) {
    theme = value;
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("theme", c).then((val){
        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: c == "Dark" ? ThemeConst.darkPrimary : ThemeConst.lightPrimary,
          statusBarIconBrightness: c == "Dark" ? Brightness.light:Brightness.dark,
        ));
      });
    });
    notifyListeners();
  }

  ThemeData getTheme(value) {
    return theme;
  }

  Future<ThemeData> checkTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeData t;
    String r = prefs.getString("theme") == null ? "Light" : prefs.getString(
        "theme");

    if(r == "Light"){
      t = ThemeConst.lightTheme;
      setTheme(ThemeConst.lightTheme, "Light");
    }else{
      t = ThemeConst.darkTheme;
      setTheme(ThemeConst.darkTheme, "Dark");
    }

    return t;
  }
}