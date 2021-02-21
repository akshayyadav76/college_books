import 'dart:convert';
import 'dart:io';

import 'package:college_books/constant/endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';


class Auth extends ChangeNotifier {
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


Future<void>firebaseChat({String msg,String name,String dateTime})async{
  final url = "https://collegebooks-29b42.firebaseio.com/chats.json";
  final body={
    "msg":msg,
    'name':name,
    'dataTime':dateTime,
  };

  try{
    final response =await http.post(url,body:json.encode(body));
    if(response.statusCode ==200){
      print("submit");
    }else{
      print("error status code ${response.statusCode}");
    }
  }catch(e){
    print("exceptin i firevase chate $e");
  }
}

Future<String>feedBack({String filePath,String issue,String email,String dateTime})async{
  var  fromData ;
  if(filePath !=null){
    print("file not null");
   String fileName= basename(filePath);
   fromData ={
            "issue_msg": issue,
            "email":email,
            "date_time":dateTime,
            "snapshot": await MultipartFile.fromFile(filePath, filename: fileName),
            };
  }else{
      fromData ={
            "issue_msg": issue,
            "email":email,
            "date_time":dateTime,
            //"snapshot": filePath
            };


  }
   String res ="";

print(filePath);
   try {
      FormData formData = new FormData.fromMap(fromData);
      Response response = await Dio().post(EndPoints.feedbackURl,data: formData);
      if(response.statusCode ==200){
        res = response.data;
      }else{
        print("error ststus code ${response.statusCode}");
      }
      return res;
    } catch (e) {
            print("expectation Caugch: $e");
            throw "Can't submit Feedback Try Again";
          }

}

}
