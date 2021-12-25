import 'dart:async';
import 'dart:io';
import 'package:drive011221/Screens/Home/HomeScreen.dart';
import 'package:drive011221/Screens/Home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:drive011221/login.dart';
import 'package:flutter/services.dart';
var username;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);



  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splashIconSize: 333,
        duration: 3000,
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
        nextScreen: MyLogin(),
        splashTransition: SplashTransition.sizeTransition,
        //pageTransitionType: PageTransitionType.scale,


)  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Timer Periodic Demo', home: RopSayac());
  }
}

class RopSayac extends StatefulWidget {
  _RopSayacState createState() => _RopSayacState();
}

class _RopSayacState extends State<RopSayac> {
  late String _now;
  late Timer _everySecond;

  @override
  void initState() {
    super.initState();

    // sets first value
    _now = DateTime.now().second.toString();

    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _now = DateTime.now().second.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: new Text(_now),
      ),
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
//
// getperf() async {
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>

    HomeScreen(name: username.text)));


    print(username);
  }
  else
{}
  }
