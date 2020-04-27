import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfScreen extends StatefulWidget {
  final String path;

  PdfScreen(this.path);

  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> with WidgetsBindingObserver {
  Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  bool nightMode = false;
  Color modeColor = Colors.black;

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
    return SafeArea(
      key: pdfViewerKey,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            PDFView(
              filePath: widget.path,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: true,
              pageFling: true,
              defaultPage: currentPage,
              nightMode: nightMode,
              fitPolicy: FitPolicy.BOTH,
              onRender: (_pages) {
                setState(() {
                  pages = _pages;
                  isReady = true;
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
                  currentPage = page;
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
            Stack(
              children: <Widget>[
                Positioned(
                  top: 1,
                  child: Container(
                    height: 40,
                    width: 80,
                    child: Center(
                        child: Text(
                      "$currentPage / $pages",
                      style: TextStyle(
                          color: modeColor, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    )),
                    decoration: BoxDecoration(shape: BoxShape.rectangle),
                  ),
                ),
                Positioned(
                    top: 1,
                    right: 1,
                    child: IconButton(
                        icon: Icon(
                          Icons.brightness_auto,
                          color: modeColor,
                        ),
                        onPressed: () {
                          setState(() {
                            nightMode = !nightMode;
                            nightMode
                                ? modeColor = Colors.white
                                : modeColor = Colors.black;
                            _controller = Completer<PDFViewController>();
                            pdfViewerKey = UniqueKey();
                          });
                        })),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 10,
                    child: FutureBuilder<PDFViewController>(
                      future: _controller.future,
                      builder:
                          (context, AsyncSnapshot<PDFViewController> snapshot) {
                        if (snapshot.hasData) {
                          return Slider(
                            value: currentPage.toDouble(),
                            min: 0,
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
              ],
            )
          ],
        ),

        //   floatingActionButton: Stack(
        //     children: <Widget>[

        //  FutureBuilder<PDFViewController>(
        //     future: _controller.future,
        //     builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
        //       if (snapshot.hasData) {
        //         return FloatingActionButton.extended(
        //           label: Text("Go to ${pages ~/ 2}"),
        //           onPressed: () async {
        //             await snapshot.data.setPage(pages ~/ 2);
        //           },
        //         );
        //       }

        //       return Container();
        //     },
        //   ),
        //   Positioned(
        //      bottom: 30,
        //      child:  FutureBuilder<PDFViewController>(
        //     future: _controller.future,
        //     builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
        //       if (snapshot.hasData) {
        //         return FloatingActionButton.extended(
        //           label: Text("Go"),
        //           onPressed: () async {
        //             await snapshot.data.setPage(pages ~/ 2);
        //           },
        //         );
        //       }

        //       return Container();
        //     },
        //   ),)
        //     ],
        //   )
      ),
    );
  }
}
