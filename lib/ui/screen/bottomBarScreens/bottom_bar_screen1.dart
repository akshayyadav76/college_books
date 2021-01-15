import 'dart:async';

import 'package:college_books/data/database/database_model.dart';
import 'package:college_books/data/models/book_model.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import '../../theme/extention.dart';






String pathPDF = "";
String corruptedPathPDF = "";

class BottomBarScreen1 extends StatefulWidget {
  @override
  _BottomBarScreen1State createState() => _BottomBarScreen1State();
}

class _BottomBarScreen1State extends State<BottomBarScreen1> {
  var popSelectedIndex = 0;
  var indexChange = true;
  List<BookModel> data = AllBooks().mca[0]; //AllBooks().mca[popSelectedIndex];
   double actualSize =00;
   double totalSize=00;
   String showMb;
   bool isFinishDownlaod = false;


  void todo(int index) {
    data = AllBooks().mca[index];
  }


  Future<void> createFileOfPdfUrl(BookModel oneBookData) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String filePath = '$dir/${oneBookData.bookCodeNameId}.pdf';
    var respons = await Dio().download(oneBookData.url, filePath,
        onReceiveProgress: (actualBytes, totalBytes) {
           setState(() {
             actualSize= actualBytes/1024/1024;
             totalSize=totalBytes/1024/1024;
           });
        },);

    DatabaseModel.insert("saved", {
      'bookCodeNameId': oneBookData.bookCodeNameId,
      'bookName': oneBookData.bookName,
      'bookCover': oneBookData.bookCover,
      'bookPath': filePath,
      'semester': oneBookData.semester,
    });
    setState(() {
      isFinishDownlaod = true;
    });
    
  }

Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
         return true;
    }else if(connectivityResult == ConnectivityResult.none){
     var dilog = AlertDialog(content: Text("Please turn on Internet and Restart the App"),
     );

      showDialog(
        barrierDismissible: false,
        context:context,builder: (df){
        return dilog;
      } );
      return false;
    }
    return null;
  }

// Future<void> createFileOfPdfUrl(BookModel oneBookData) async {
//   // final url =
//   // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";

//    print("woring");

//   //final url = "https://pdfkit.org/docs/guide.pdf"; i will use id as big pdf chakck
//   // http://download1592.mediafire.com/edcmebg0npwg/2d10fupy1adey1q/blueprint.pdf
//   //http://download1586.mediafire.com/fpceelv21zzg/sb2v1cy7lye4q0e/smple1.pdf

//   final url = oneBookData.url;
//   //final filename = url.substring(url.lastIndexOf("/") + 1);
//   var request = await HttpClient().getUrl(Uri.parse(url));
//   var response = await request.close();
//   var bytes = await consolidateHttpClientResponseBytes(response);
//   String dir = (await getApplicationDocumentsDirectory()).path;
//   File file = new File('$dir/${oneBookData.bookCodeNameId}.pdf');
//   await file.writeAsBytes(bytes);

//   DatabaseModel.insert("saved",
//   {
//    'bookCodeNameId':oneBookData.bookCodeNameId,
//    'bookName':oneBookData.bookName,
//    'bookCover':oneBookData.bookCover,
//    'url':oneBookData.url,
//    'bookPath': file.path,
//    'semester':oneBookData.semester,
//   });
//   //return file;
// }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.menu,size: 15.h, color: Theme.of(context).accentColor,),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }),
            Expanded(
              child: Text("College Books",style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.w400,
              color: Theme.of(context).accentColor),
              textAlign: TextAlign.center,)
            ),
            PopupMenuButton(
              color: Theme.of(context).primaryColor,
                icon: Icon(Icons.filter_list,size: 15.h,color: Theme.of(context).accentColor),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        
                        child: PopupMenuButton(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.zero,
                          child: Row(
                            children: <Widget>[
                              Text("MCA",style: TextStyle( color: Theme.of(context).accentColor),),
                              Icon(Icons.arrow_right, color: Theme.of(context).accentColor,),
                            ],
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text("Sem 1",style: TextStyle(color: Theme.of(context).accentColor),),
                              value: 0,
                            ),
                            PopupMenuItem(
                              child: Text("Sem 2",style: TextStyle(color: Theme.of(context).accentColor),),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Text("Sem 3",style: TextStyle(color: Theme.of(context).accentColor),),
                              value: 2,
                            ),
                            PopupMenuItem(
                              child: Text("Sem 4",style: TextStyle(color: Theme.of(context).accentColor),),
                              value: 3,
                            ),
                            // PopupMenuItem(
                            //   child: Text("Sem 5"),
                            //   value: 4,
                            // ),
                            // PopupMenuItem(
                            //   child: Text("Sem 6"),
                            //   value: 5,
                            // ),
                          ],
                          onSelected: (selectedValue) {
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
                      height: 70.h,
                      width: 130.w,
                      color:  Theme.of(context).accentColor,
                      margin: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.w),
                      child: Card(
                        child: Image.asset(
                          data[i].bookCover,
                          fit: BoxFit.fill,
                        ),
                        elevation: 15,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            data[i].bookName,
                            style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,
                            color: Theme.of(context).accentColor),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          
                          Text(
                            "Samester: ${data[i].semester}",
                            style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,
                            color: Theme.of(context).accentColor
                            ),
                          ),
                          Row(
                            children: <Widget>[
                           data[i].url.isEmpty ? 
                           Padding(
                             padding: EdgeInsets.only(top: 10.h),
                             child: Text("Not Avaliable yet",style:
                              TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600,
                             color:  Theme.of(context).accentColor))): 
                            Padding(
                              padding:  EdgeInsets.only(top: 10.h),
                              child: IconButton(
                                  icon: Icon(Icons.cloud_download,size: 17.h,),
                                  onPressed: () {
                                    checkInternet().then((connectinvety){
                                      if(connectinvety){
                                        print("connected");
                                         setState(() {
                                      showMb = data[i].bookCodeNameId;
                                    });
                                    createFileOfPdfUrl(data[i]).then((res) {
                                      showDialog(
                                          context: context,
                                          builder: (va) => AlertDialog(
                                            title: Text(
                                                    "File Downloaded Sucessfully"),
                                                content: Text(
                                                    "Check Download Screen"),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  )
                                                ],
                                              ));
                                    }).catchError((err) =>
                                        print("thie waht case error $err"));


                                      }else{
                                        print("not connected");
                                      }
                                    });
                                  
                                   
                                  },
                                ),
                            ),
                           isFinishDownlaod ?Container():
                            showMb == data[i].bookCodeNameId ? Row(
                                children: <Widget>[
                                  Text("${actualSize.toStringAsFixed(2)} MB"),
                                  Text(" / "),
                                  Text("${totalSize.toStringAsFixed(2)} MB")
                                ],
                              ):Container(),
                          
                             
                            ],
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
