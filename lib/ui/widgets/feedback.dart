



import 'dart:io';

import 'package:college_books/data/provider/auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'textfield_widget.dart';
import '../theme/extention.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {

  File _image;
var controller = TextEditingController();
var controllerSnapshot = TextEditingController(text: "Tab here to add snapshot");
var formkey = GlobalKey<FormState>();
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
                          
                         FilePickerResult result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg','pdf',],
        );
          if (result != null) {
            print(result.paths[0]);
             String fileName = basename(result.names[0]);
            setState(() {
           //_image = File(pickedFile.path);
           controllerSnapshot.text = result.names[0];
                          
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
                                           if(va.isEmpty) return "enter Sameting";
                                         },
                                       ),     
                                 ),
                                 IconButton(icon: Icon(Icons.send),onPressed: (){
                                    if(formkey.currentState.validate()){
                                      print("true");
                                      Provider.of<Auth>(context,listen:false).feedBack(
                                        email: "akshay@gmail.com",
                                        issue: "i have same issue with app",
                                        dateTime: ""
                                      );
                                    }else{
                                      print("false");
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