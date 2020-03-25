import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:share/share.dart';
import './About.dart';

class AppDrawer extends StatelessWidget {

  _launchURL(String url) async {
 //const url = geturl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return
    Drawer(
     child: Column(
          children: <Widget>[
         Container(
           margin: EdgeInsets.only(top: 50),
           child: Text("College Books",style: TextStyle(fontSize: 40)),
         ),
          Divider(),

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
            Share.share("RGPV Syllabus All Shivani Publications Digital Books"
               "Link-: https://play.google.com/store/apps/developer?id=Akshay+yadav&hl=en ",);
          },),

            // ListTile(title: Text("Rate on Google play",style: Theme.of(context).textTheme.title,),
            //   trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.next_week)),
            //   onTap: (){
            //     launch("https://play.google.com/store/apps/developer?id=com.akshay.quiz_app");
            //   },),

            ListTile(title: Text("Credits & About",style: Theme.of(context).textTheme.title),
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
