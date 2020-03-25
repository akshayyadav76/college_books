import 'package:flutter/material.dart';

class About extends StatelessWidget {

  var textStyle = TextStyle(
    fontSize: 20
  );

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: Text("About"),),
          body: ListView(
                        
                    children: <Widget>[
                   Center(
                     child: Text("About",
                          style: Theme.of(context).textTheme.headline,),
                   ),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                      
                      ),
                      Text("Shivani Publication Digital books",
                        
                      //    "As MCA Student of TiT Affliated by RGPV.We all face problems well yup"
                      // "a lot of problems and one of them problem is RGPV has not changed it's syllabus"
                      // "from many year.Becouse of that Shivani Publications Stop publicing book"
                      // "now these days if you go market to buy MCA Shivani you will not find"
                      // "Becous Books not avalible in market any more..",
                        style: Theme.of(context).textTheme.title,
                      ),
                     // Text("So with Application you can find all Mca Shivani digial copys"),
                      SizedBox(height: 30,),
                      Center(
                        child: Text("Credits",
                        style: Theme.of(context).textTheme.headline,),
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                        
                      ),
                      Text("Vary big Thanks to all my friends of TiT MCA Batch 2017"
                       " who help me to convert all books into digital copy's",
                      style: textStyle,
                      ),
                      SizedBox(height: 10,),
                      Text("and we all 8 started mca form 1st sem",  style: textStyle,),
                      SizedBox(height: 10,),
                      Text("Thanks To",  style: textStyle,),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                        
                        
                      ),
                      Text("Parvez",  style: textStyle,),
                      Text("Aksah",  style: textStyle,),
                      Text("Dev",  style: textStyle,),

                    ],
                  ),
    );
  }
}