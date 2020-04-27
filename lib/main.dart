import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  CameraController controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[1], ResolutionPreset.medium);
    _initializeControllerFuture = controller.initialize();
  }

  Future<void> doSameting() async {
    try {
      await _initializeControllerFuture;
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      await controller.takePicture(path);
      print(path);
      File getFile = File(path);
      final StorageReference ref =
          FirebaseStorage.instance.ref().child("${DateTime.now()}");
      final StorageUploadTask upload = ref.putFile(getFile);
      getFile.delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // doSameting();
    print("main method");
    return FutureBuilder(
      future: doSameting(),
      builder: (context, data) {
        if (data.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Colors.purple, primarySwatch: Colors.purple),
            home: MyApp(),
          );
        }else if(data.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
