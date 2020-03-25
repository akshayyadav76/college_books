import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../book_model.dart' ;
import '../pdf_screen.dart';
import '../database/database_model.dart';

String pathPDF = "";
String corruptedPathPDF = "";




class BottomBarScreen1 extends StatefulWidget {
  @override
  _BottomBarScreen1State createState() => _BottomBarScreen1State();
}

class _BottomBarScreen1State extends State<BottomBarScreen1> {

  var popSelectedIndex=0;
  var indexChange= true;
 List<BookModel> data= AllBooks().mca[0];   //AllBooks().mca[popSelectedIndex];

void todo(int index){
    data = AllBooks().mca[index];
}

Future<void> createFileOfPdfUrl(BookModel oneBookData) async {
  // final url =
  // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
 
   print("woring");
   
  //final url = "https://pdfkit.org/docs/guide.pdf"; i will use id as big pdf chakck
  // http://download1592.mediafire.com/edcmebg0npwg/2d10fupy1adey1q/blueprint.pdf
  //http://download1586.mediafire.com/fpceelv21zzg/sb2v1cy7lye4q0e/smple1.pdf

  final url = oneBookData.url;
  //final filename = url.substring(url.lastIndexOf("/") + 1);
  var request = await HttpClient().getUrl(Uri.parse(url));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/${oneBookData.bookCodeNameId}');
  await file.writeAsBytes(bytes);

  DatabaseModel.insert("saved", 
  {
   'bookCodeNameId':oneBookData.bookCodeNameId,
   'bookName':oneBookData.bookName,
   'bookCover':oneBookData.bookCover,
   'url':oneBookData.url,
   'bookPath': file.path,
   'semester':oneBookData.semester,
  });
  //return file;
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.drag_handle),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }),
            Expanded(
              child: RaisedButton(
                child: Text(
                  "College Books",
                  style: Theme.of(context).textTheme.title,
                ),
                onPressed: () {
                  if (pathPDF != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfScreen(path: pathPDF),
                      ),
                    );
                  }
                },
              ),
            ),
            PopupMenuButton(
                icon: Icon(Icons.filter_list),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: PopupMenuButton(
                          padding: EdgeInsets.zero,
                          child: Row(
                            children: <Widget>[
                              Text("MCA"),
                              Icon(Icons.arrow_right),
                            ],
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(child: Text("Sem 1"),value: 0,),
                            PopupMenuItem(child: Text("Sem 2"),value: 1,),
                            PopupMenuItem(child: Text("Sem 3"),value: 2,),
                            PopupMenuItem(child: Text("Sem 4"),value: 3,),
                            PopupMenuItem(child: Text("Sem 5"),value: 4,),
                            PopupMenuItem(child: Text("Sem 6"),value: 5,),
                          ],
                          onSelected: (selectedValue){
                             todo(selectedValue);
                            setState(() {
                               print(selectedValue);
                              popSelectedIndex = selectedValue;
                            print(popSelectedIndex);
                            });

                          },
                        ),
                      ),
                    ]),
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: 120,
                      color: Colors.purple,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Card(
                        child: Image.asset(
                          data[i].bookCover,
                          fit: BoxFit.fill,
                        ),
                        elevation: 7,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            data[i].bookName,
                            style: Theme.of(context).textTheme.title,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Samester: ${data[i].semester}",
                            style: TextStyle(fontSize: 17),
                          ),
                          IconButton(
                            icon: Icon(Icons.cloud_download),
                            onPressed: () {
                            createFileOfPdfUrl(data[i]).then((res){
                             showDialog(context:  context,
                              builder: (va)=>AlertDialog(content: Text("File Downloaded Sucessfully"),
                              actions: <Widget>[
                                FlatButton(child:Text("OK"),onPressed: (){
                                  Navigator.of(context).pop();
                                },)
                                ],
                              )
                              );
                            }).catchError((err)=>print("thie waht case error $err"));
                            },
                          )
                        ],
                      ),
                    )
                  ],
                );
              }),
        ),
      ],
    );
  }
}
