import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {

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
    return   SafeArea(
          child: Scaffold( 
           backgroundColor: Colors.white,
        //appBar: AppBar(title: Text("About",style: TextStyle(color: Colors.black),)),
            body: ListView(  
                      children: <Widget>[
                        SizedBox(height:20,),
                     Center(
                       child: Text("About",
                            style: Theme.of(context).textTheme.display2,),
                     ),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                        
                        ),
                        Text("**Shivani Publication Digital books**" ,textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.title,
                        ),
                       // Text("So with Application you can find all Mca Shivani digial copys"),
                        SizedBox(height: 30,),

                        Text("well, i'm a little bit lazzy person" 
                        " i hava't added mca 1st 2nd 3rd and other branches like - b.tech books..."
                        "there only mca 4th sem books avaliable right now but if you want to help me or"
                         " want to part of this project you can contact me at ", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400)
                        ),
                        
                        FlatButton(onPressed:()=>_launchURL("mailto:akshayyadav7613@gmail.com"), child: Text("akshayyadav7613@gmail.com",
                        style: TextStyle(fontSize: 22,color: Colors.blue),))

                      ],
                    ),
      ),
    );
  }
}