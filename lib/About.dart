import 'package:flutter/material.dart';


class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: Text("About"),),
          body: ListView(
                        
                    children: <Widget>[
                   Text("About",
                        style: Theme.of(context).textTheme.headline,),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                        indent: 5,
                      ),
                      RichText(
                        
                         "As MCA Student of TiT Affliated by RGPV.We all face problems well yup"
                      "a lot of problems and one of them problem is RGPV has not changed it's syllabus"
                      "from many year.Becouse of that Shivani Publications Stop publicing book"
                      "now these days if you go market to buy MCA Shivani you will not find"
                      "Becous Books not avalible in market any more..",
                        style: Theme.of(context).textTheme.title,
                      ),
                      Text("So with Application you can find all Mca Shivani digial copys"),
                      Center(
                        child: Text("Credits",
                        style: Theme.of(context).textTheme.headline,),
                      ),

                    ],
                  ),
    );
  }
}