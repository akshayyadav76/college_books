



import 'dart:io';

import 'package:college_books/data/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'textfield_widget.dart';
import '../theme/extention.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class FeedBack extends StatefulWidget {

   var _scaffoldKey = new GlobalKey<ScaffoldState>();
   FeedBack(this._scaffoldKey);

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {

  String snapshotPath  ;
var controller = TextEditingController();
var controllerSnapshot = TextEditingController(text: "Tab here to add snapshot");
var formkey = GlobalKey<FormState>();
String responseFeedback;
  @override
  Widget build(BuildContext context) {
    return Container(
                  //height: 300.h,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("FeedBack",style:TextStyle(fontSize: 10.h),),
                      SizedBox(height: 15,),
                      TextFieldWidget(
                        controller: controllerSnapshot,
                        focusNode: AlwaysDisabledFocusNode(),
                        //intialValue: "Tab here to add snapshot",
                        prefixIconData: null,
                        obscureText: false,
                        onTap: ()async{
                          
                         var result = await FilePicker.getFilePath(
          type: FileType.custom,
          allowedExtensions: ['jpg','pdf',],
        );
          if (result != null) {
            print(result);
             String fileName = basename(result);
            setState(() {
           snapshotPath = result;
           controllerSnapshot.text = fileName;
                          
                        });
          } else {
             print('No image selected.');
          }
  
                        },
                      ),
                      SizedBox(height: 15,),
                       Padding(
                         padding: EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom,),
                         child: Form(
                           key: formkey,
                           child: Row(
                              children: [
                                 Expanded(
                                   child: TextFieldWidget(
                                     controller: controller,
                                         obscureText: false,
                                         hintText: "your issue",
                                         validate: (String va){
                                           if(va.isEmpty){ return "enter Sameting";}
                                           return null;
                                         },
                                       ),     
                                 ),
                                 IconButton(icon: Icon(Icons.send),onPressed: (){
                                  
                                   String formattedDate = DateFormat('dd-MM-yyyy – h:mm:a').format(DateTime.now());
                                  print(formattedDate);
                                    if(formkey.currentState.validate()){
                                      print("true");
                                      //var dd =context;
                                      Navigator.pop(context);
                                   Provider.of<Auth>(context,listen:false).feedBack(
                                        email: "akshay@gmail.com",
                                        issue: controller.text,
                                        dateTime: formattedDate,
                                        filePath: snapshotPath
                                      ).then((msg){
                                         //final scaffold = Scaffold.of(dd);
                                         print("thsi msg is $msg");
                                         Get.snackbar("success",msg,
                                         backgroundColor: Colors.black,
                                         colorText: Colors.white,
                                         snackPosition: SnackPosition.BOTTOM);
                          //          widget._scaffoldKey.currentState.showSnackBar(
                          //      SnackBar(
                          //  content:  Text(msg),
                          // ),
                          //       );
                                      }).catchError((er){
                                        print(er);
                                       Get.snackbar("Error",er,
                                         backgroundColor: Colors.black,
                                         colorText: Colors.white,
                                         snackPosition: SnackPosition.BOTTOM);
                                        //Get.showSnackbar(GetBar(message: "dkkkkkkkkd",));
                                      });
                                    }else{
                                      print("false");
                                      Navigator.pop(context);
                                     // Get.defaultDialog(backgroundColor: Colors.black, );
                                     // Get.showSnackbar(GetBar(message: "dkkkkkkkkd",));
                                      //Get.snackbar("this msg ","msg",snackPosition: SnackPosition.BOTTOM);
                                    }

                                 },)
                              ],
                            ),
                         ),
                       ),
                      


                    ],
                  ),
                );
  }
}


class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}