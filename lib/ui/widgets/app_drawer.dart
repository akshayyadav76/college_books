
import 'package:college_books/ui/screen/papers_screen.dart';
import 'package:college_books/ui/widgets/textfield_widget.dart';
import 'package:college_books/ui/widgets/theme_container.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:share/share.dart';

import './About.dart';
import '../theme/extention.dart';

class AppDrawer extends StatelessWidget {

//   _launchURL(String url) async {
//  //const url = geturl;
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
Color baseColor = Color(0xFFF2F2F2);


  @override
  Widget build(BuildContext context) {
    return
    Drawer(
    
     child: Container(
       color: Theme.of(context).primaryColor,
       child: Column(
            children: <Widget>[
           Container(
             margin: EdgeInsets.only(top: 20),
             child: Text("College Books",style: TextStyle(fontSize: 40.sp,color:Theme.of(context).accentColor),
             ),
           ),
           SizedBox(height: 10.h,),
           Text("Version 2.0",style:Theme.of(context).textTheme.headline6,),
            Divider(),

            ListTile(title: Text("Update App",style: Theme.of(context).textTheme.headline6,),
               trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.update,color: Theme.of(context).accentColor,)),
           onTap: () {
             launch("https://drive.google.com/open?id=1yyZKnSLwJCE_u7kPfr6aMSORY-xdCWsy");
           }
           ),

            ListTile(title: Text("Papers",style: Theme.of(context).textTheme.headline6,),
               trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.pageview ,color: Theme.of(context).accentColor,)),
           onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
              builder: (context){
                return PapersScreen();
              }));
           }
           ),

           ListTile(title: Text("Source Code",style: Theme.of(context).textTheme.headline6,),
               trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.code ,color: Theme.of(context).accentColor,)),
           onTap: () {
             launch("https://github.com/akshayyadav76/college_books");
           }
           ),

            ListTile(title: Text("Themes",
              style: Theme.of(context).textTheme.headline6,),
              trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.color_lens,color: Theme.of(context).accentColor,)),
              onTap: (){
                Navigator.pop(context);
               var di = SimpleDialog(
                 titlePadding: EdgeInsets.symmetric(vertical: 20),
                 title: Column(children: [
                  Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
             ThemeContainer(colorName: "Light",color: Color(0xFFF2F2F2),),
              SizedBox(width: 50.w),
              ThemeContainer(colorName: "Dark",color: Colors.black,)
               
            ],
          ),
                ],),

                );
                showDialog(context:context,builder: (context)=>di);
              // launch("https://play.google.com/store/apps/developer?id=Akshay+yadav&hl=en");
              },),
            
            ListTile(title: Text("Share the App",style: Theme.of(context).textTheme.headline6,),
              trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.share,color: Theme.of(context).accentColor,)),
            onTap: (){
              
              Share.share("RGPV Syllabus All Shivani Publications Digital Books Download and read"
              " Download the App Now "
                 "Link-: https://drive.google.com/open?id=1yyZKnSLwJCE_u7kPfr6aMSORY-xdCWsy",);
            },),

              // ListTile(title: Text("Rate on Google play",style: Theme.of(context).textTheme.title,),
              //   trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.next_week)),
              //   onTap: (){
              //     launch("https://play.google.com/store/apps/developer?id=com.akshay.quiz_app");
              //   },),

               ListTile(title: Text("FeedBack",style: Theme.of(context).textTheme.headline6),
                trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.feedback,color: Theme.of(context).accentColor,)),
              onTap: (){
                Navigator.of(context).pop();
                showModalBottomSheet(
                  backgroundColor: Theme.of(context).primaryColor,
                  isScrollControlled: true,
                  
                  shape:  RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10.0),
               ),
                  context: context,
                  builder:(context)=> Container(
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
                        intialValue: "Tab here to add snapshot",
                        prefixIconData: null,
                        obscureText: false,
                      ),
                      SizedBox(height: 15,),
                       Padding(
                         padding: EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom,),
                         child: Row(
                            children: [
                               Expanded(
                                 child: TextFieldWidget(
                                       obscureText: false,
                                       hintText: "your issue",
                                     ),     
                               ),
                               IconButton(icon: Icon(Icons.send),onPressed: (){

                               },)
                            ],
                          ),
                       ),
                      


                    ],
                  ),
                ),
                );
                // Scaffold.of(context).showBottomSheet(
                  
                //   (s,)=>);
              },),

              ListTile(title: Text("About & Contact",style: Theme.of(context).textTheme.headline6),
                trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.error,color: Theme.of(context).accentColor,)),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder:(context)=>About() ));
              },),

               

          ],
          ),
     ),
      
    )
        ;
  }
}
