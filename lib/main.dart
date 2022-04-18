import 'package:drive011221/Screens/Home/message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:io';
import 'package:drive011221/Screens/Home/HomeScreen.dart';
import 'package:drive011221/Screens/Home/home.dart';
import 'package:drive011221/Screens/Home/mainscreen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:drive011221/login.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


var username;
FirebaseMessaging messaging = FirebaseMessaging.instance;
Future<void> _messageHandler(RemoteMessage message) async {
  print('b');
}
Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onMessageOpenedApp;


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
 ]);


  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splashIconSize: 333,
        duration: 300,
        splash: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("img/logo.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("مكتب النقل",style: TextStyle(fontSize: 22),),
              )
            ],
          ),
        ),
        nextScreen:MyLogin(),
        splashTransition: SplashTransition.sizeTransition,
        //pageTransitionType: PageTransitionType.scale,


      ),
    routes: {

      '/message': (context) =>Message(),
      //'/home': (context) =>HomeScreen(name: ,),
  },
  )

  );
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
//// getperf() async {
//   BuildContext context;
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//
//   if (preferences.getString("Path") != null) {
//
//   }
//   else if (preferences.getString("Path") == null) {
//     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
//         HomeScreen(name: username.text)));
//   }
//
// }
//
//

go(BuildContext context) async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  username=   preferences.getString("username");
  if(username!= null) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context)=>
          HomeScreen(name: username.text)),
          (Route<dynamic> route) => false,
    );


    print(username);
  }
  else
  {}
}

