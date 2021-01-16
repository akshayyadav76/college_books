import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';



class PdfScreen extends StatefulWidget {
  final String path;
//
  PdfScreen(this.path);

  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> with WidgetsBindingObserver {
  Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int pages = 1;
  int currentPage = 0;
  int stupFixPageValue =0;
  bool isReady = false;
  double pi=3.14;
  String errorMessage = '';
  bool nightMode = false;
  bool horizontal = false;
  bool autoSpacing = false;
  Color modeColor = Colors.black;
  int turnSlider =3;
  Color barHideColor = Colors.transparent;
  //ScrollController _rectController = ScrollController();

  UniqueKey pdfViewerKey = UniqueKey();

  bool stopBuild = true;
  bool stopBuild2 = false;

  Widget smallButton(String text) {
    return Container(
      height: 50,
      width: 40,
      child: Center(
          child: Text(
        text,
        style: TextStyle(color: modeColor, fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
      )),
      decoration: BoxDecoration(shape: BoxShape.circle),
    );
  }

  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarBrightness: Brightness.light
    // ));
    print("build");
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    print(isLandscape);
    if (isLandscape) {
      if (stopBuild) {
        setState(() {
          _controller = Completer<PDFViewController>();
          print("object if");
          pdfViewerKey = UniqueKey();
          stopBuild = false;
          stopBuild2 = true;
        });
      }
    }
    if (!isLandscape) {
      if (stopBuild2) {
        setState(() {
          print("object else");
          _controller = Completer<PDFViewController>();
          pdfViewerKey = UniqueKey();
          stopBuild2 = false;
          stopBuild = true;
        });
      }
    }

    // print(widget.path);
    return Scaffold(
            key: pdfViewerKey,
           /// resizeToAvoidBottomPadding: false,
           appBar: PreferredSize(
             preferredSize: Size.fromHeight(25),
             child: AppBar(
               backgroundColor: Theme.of(context).primaryColor,
               title: Text("${currentPage +1}/ $stupFixPageValue",),
               automaticallyImplyLeading: false,
               centerTitle: true,
               leading: IconButton(icon: Icon(Icons.arrow_back),
               padding: EdgeInsets.all(0),
               onPressed: (){
                 Navigator.pop(context);
               },
               ),
               actions: <Widget>[
                PopupMenuButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.more_vert),
                  itemBuilder:(context) =>[
                    PopupMenuItem(
                      child: Row(children: <Widget>[
                        Text("Night Mode  "),Checkbox(value:nightMode,onChanged:(value){
                          setState(() {
                            nightMode = value;
                            _controller = Completer<PDFViewController>();
                            pdfViewerKey = UniqueKey();
                          });
                          Navigator.pop(context);

                        },)
                      ],)
                    ),
                    PopupMenuItem(
                      child: Row(children: <Widget>[
                        Text("Horizontal    "),
                        Checkbox(value:horizontal,onChanged:(value){
                          setState(() {
                            horizontal = value;
                            if(value){
                              turnSlider =0;
                              pi =0;
                            }else{
                              turnSlider=3;
                              pi=3.14;
                            }
                            _controller = Completer<PDFViewController>();
                            pdfViewerKey = UniqueKey();
                          });
                          Navigator.pop(context);

                        },)
                      ],)
                    ),
                     PopupMenuItem(
                      child: Row(children: <Widget>[
                        Text("AutoSpacing"),
                        Checkbox(value:autoSpacing,
                        onChanged:(value){
                          setState(() {                          
                            if(value){
                              autoSpacing  =value;                             
                            }else{
                              autoSpacing =value;
                            }
                            _controller = Completer<PDFViewController>();
                            pdfViewerKey = UniqueKey();
                          });
                          Navigator.pop(context);

                        },)
                      ],)
                    ),
                    // PopupMenuItem(
                    //   child: FlatButton(
                    //     child: Text("Print",textAlign: TextAlign.start,
                    //     style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.w400),),
                    //     onPressed:()async{
                    //       var pr = await File(widget.path).readAsBytes();

                    //   pri.Printing.layoutPdf(
                    //       onLayout: (_) => pr.buffer.asUint8List());
                    //     } , 
                    //     ),
                    // ),
                  ]),
               ],
            // backgroundColor: Colors.white
             )),
            body: Stack(
                children: <Widget>[
                  PDFView(                   
                    filePath: widget.path,
                    fitPolicy: FitPolicy.BOTH,
                    pageSnap: false,
                    enableSwipe: true,
                    pageFling: true,
                    defaultPage: currentPage,

                    swipeHorizontal: horizontal,
                    autoSpacing: autoSpacing,                  
                    nightMode: nightMode,
                    onRender: (_pages) {
                      print("on render $_pages");
                      setState(() {
                        if(_pages <2){
                           pages = _pages ;
                           stupFixPageValue =pages;
                           isReady = true;
                        }else{
                        pages = _pages -1;
                        stupFixPageValue = pages+1;
                        isReady = true;
                        }
                      });
                    },
                    onError: (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                      print(error.toString());
                    },
                    onPageError: (page, error) {
                      setState(() {
                        errorMessage = '$page: ${error.toString()}';
                      });
                      print('$page: ${error.toString()}');
                    },
                    onViewCreated: (PDFViewController pdfViewController) {
                      _controller.complete(pdfViewController);
                    },
                    onPageChanged: (int page, int total) {
                      print('page change: $page/$total');
                      setState(() {
                        //currentPage = page;
                        
                      });
                    },
                  ),
                  errorMessage.isEmpty
                      ? !isReady
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container()
                      : Center(
                          child: Text(errorMessage),
                        ),
                         RotatedBox(
                           quarterTurns: turnSlider,
                          child:
                         Align(
                  alignment: Alignment.bottomLeft,

                  child: Transform.rotate(
                    angle: pi,
                      child: Container(
                       
                      height: 18,
                      width: double.infinity,
                     // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height -30),
                      child: FutureBuilder<PDFViewController>(
                        future: _controller.future,
                        builder:
                            (context, AsyncSnapshot<PDFViewController> snapshot) {
                          if (snapshot.hasData) {
                            return CupertinoSlider(
                              activeColor: Colors.transparent,
                              thumbColor: Colors.deepPurple.shade800,

                                value: currentPage.toDouble(),
                                min: 0.0,
                                max: pages.toDouble(),
                                onChanged: (value) {
                                  setState(() {
                                    snapshot.data.setPage(value.toInt());
                                  });
                                },
                            );
                            
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                ),
                         ),
  
      ]),
    );
  }
}