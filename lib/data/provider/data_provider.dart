import 'dart:convert';

import 'package:college_books/constant/endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class DataProvider extends ChangeNotifier {
  String _email;
  String _password;
  bool _rememberMe = false;


  String get email => _email;
  String get password => _password;
  bool get rememberMe => _rememberMe;
 

  Future<String> login(
      {@required String email,
      @required String password,
      @required bool rememberMe}) async {
    _email = email;
    _password = password;
    _rememberMe = true;

    final url = EndPoints.login;
    var body = {"email": email, "password": password};
    var response = await http.post(url, body: body);

    if (response.body.contains("Login")) {
      print("true container");
      if (rememberMe) {
        final sharePref = await SharedPreferences.getInstance();
        final userData = json.encode(
            {"email": email, "password": password, "rememberMe": rememberMe});
        sharePref.setString("userData", userData);
      } else {
        print("rememberMe $rememberMe");
      }
    }
    return response.body;
  }



  Future<String> resgisterUser(
      {@required String firstName,
      @required String lastName,
      @required String email,
      @required String password}) async {
    final url = EndPoints.registerUserApi;
    final body = {
      "jsname": firstName,
      "jslname": lastName,
      "email": email,
      "password": password
    };
    String msg;
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      msg = response.body;
    } else {
      print("error ${response.statusCode}");
    }
    return msg;
  }

  Future<String> resetPass({@required String email}) async {
    final url = EndPoints.resetPassApi;
    final body = {"email": email};
    final response = await http.post(url, body: body);
    String msg;
    if (response.statusCode == 200) {
      msg = response.body;
    } else {
      msg = "Error: ${response.statusCode}";
    }
    return msg;
  }

  Future<bool> tryAutoLogin() async {
    print("ener");

    final sharePref = await SharedPreferences.getInstance();

    if (sharePref.containsKey('userData')) {
      final userData = sharePref.get("userData");
      final decode = json.decode(userData);

      _email = decode["email"];
      _password = decode["password"];
      _rememberMe = decode["rememberMe"];

      notifyListeners();
      return true;
    }
    return true;
  }

  Future<void> clearSavedLoginDeatils() async {
    final sharePref = await SharedPreferences.getInstance();
    _rememberMe = false;
    // print("1");
    // _appliedJobs.clear();
    // print("2");
    // _findJobs.clear();
    // print("3");
    // _recentJobs.clear();
    // print("4");
    sharePref.clear().catchError((e) => print("error $e"));
    // print("5");
    notifyListeners();
    print("value $_rememberMe");
  } //


}
