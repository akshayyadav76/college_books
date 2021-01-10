import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:share/share.dart';
import './papers_screen.dart';
import './About.dart';

class AppDrawer extends StatelessWidget {

//   _launchURL(String url) async {
//  //const url = geturl;
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

  @override
  Widget build(BuildContext context) {
    return
    Drawer(

     child: Column(
          children: <Widget>[
         Container(
           margin: EdgeInsets.only(top: 20),
           child: Text("College Books",style: TextStyle(fontSize: 40)),
         ),
         SizedBox(height: 10,),
         Text("Version 2.0",style:Theme.of(context).textTheme.title,),
          Divider(),

          ListTile(title: Text("Update App",style: Theme.of(context).textTheme.title,),
             trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.update)),
         onTap: () {
           launch("https://drive.google.com/open?id=1yyZKnSLwJCE_u7kPfr6aMSORY-xdCWsy");
         }
         ),

          ListTile(title: Text("Papers",style: Theme.of(context).textTheme.title,),
             trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.pageview)),
         onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
            builder: (context){
              return PapersScreen();
            }));
         }
         ),

         ListTile(title: Text("Source Code",style: Theme.of(context).textTheme.title,),
             trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.code)),
         onTap: () {
           launch("https://github.com/akshayyadav76/college_books");
         }
         ),

          ListTile(title: Text("More Apps On Google Play",
            style: Theme.of(context).textTheme.title,),
            trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.file_download)),
            onTap: (){
            launch("https://play.google.com/store/apps/developer?id=Akshay+yadav&hl=en");
            },),
          
          ListTile(title: Text("Share the App",style: Theme.of(context).textTheme.title,),
            trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.share)),
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

            ListTile(title: Text("About & Contact",style: Theme.of(context).textTheme.title),
              trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.error)),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder:(context)=>About() ));
            },),

             

        ],
        ),
      
    )
        ;
  }
}
