import 'package:college_books/data/provider/auth.dart';
import 'package:college_books/ui/widgets/textfield_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/utils/utils.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => new _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  var controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    //board = Board("", "");
    databaseReference = database.reference().child("chats");
    databaseReference.onChildAdded.listen((snap){
   print(snap.snapshot.value);
    });
    //databaseReference.onChildChanged.listen(_onEntryChanged);
  } //  void _incrementCounter() {


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth>(context,listen: false);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Chat"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
           Expanded(
             child: Container(
               alignment: Alignment.bottomCenter,
              child: FirebaseAnimatedList(

                reverse: false,
                query: databaseReference,
                itemBuilder: (_, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return snapshot.value["name"]=="aksay"
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      alignment: Alignment.bottomRight,
                     // width: double.infinity,
                      child: Card(

                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          Text(snapshot.value['msg']),
                          Icon(Icons.arrow_right)
                          ]),
                      ),
                    
                  )
                  :Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      alignment: Alignment.bottomLeft,
                     // width: double.infinity,
                      child: Card(

                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          Text(snapshot.value['msg']),
                          Icon(Icons.arrow_right)
                          ]),
                      ),
                    
                  );
                },
              ),
          ),
           ),
           SizedBox(height: 10,),
         Padding(
                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                         child: Row(
                            children: [
                               Expanded(
                                 child: TextFieldWidget(
                                   controller: controller,
                                       obscureText: false,
                                       hintText: "As akshay yadav",
                                     ),     
                               ),
                               IconButton(icon: Icon(Icons.send),onPressed: (){
                                 var msg =controller.text;
                                 controller.clear();
                              provider.firebaseChat(msg:msg,name: "aksay",dateTime: "20/1/2021 1:20am");
                               },)
                            ],
                          ),
                       ),
         
        ],
      ),
    );
  }

 

 


}
