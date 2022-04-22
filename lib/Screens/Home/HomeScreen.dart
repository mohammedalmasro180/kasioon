// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names

import 'dart:io';
import 'package:drive011221/Screens/Home/message.dart';
import 'package:drive011221/Screens/Home/notificationservice.dart';
import 'package:drive011221/widget/myAd.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:drive011221/Screens/Home/pickimage.dart';
import 'package:drive011221/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';
import 'package:drive011221/theme/color.dart';
import 'package:drive011221/widget/ViewPaths.dart';
import 'package:drive011221/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'dart:convert';
class HomeScreen extends StatefulWidget {
  final  String name;
  const HomeScreen({Key? key, required this.name }) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var msg;
class _HomeScreenState extends State<HomeScreen> {

  FirebaseMessaging messaging = FirebaseMessaging.instance;



  var token;
  var str;
  Future<void> gettoken() async {

    messaging.getToken().then((String? token) async {
      assert(token != null);
      setState(() {
        str = token.toString();
      });
      print(str.toString());
    });
  }
  Future getmesg() async {   Uri uri = Uri.parse(
      "https://tpowep.com/pro/api/meslast.php");

  http.Response response = await http.get(uri);


  var jsonsDataString = response.body;

  var _data = json.decode(jsonsDataString);
  print(_data);

  setState(() {
    msg= _data[0]['text'];
//    loadedok();

  });
  return _data;
  }

  TextEditingController serr= new TextEditingController ();
  Future loadedok() async {

    Uri uri = Uri.parse(
        "https://tpowep.com/pro/api/loaded.php");
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(json.decode(response.body));
    } else {
      print(response.statusCode);
    }

  }



  @override

  void initState() {
    super.initState();
    getmesg();
    gettoken();

getdata();

    tz.initializeTimeZones();



    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
          Message()));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      FirebaseMessaging.onMessageOpenedApp;
    });
  }


/*
  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }

 */


  final LocalStorage storage = new LocalStorage('todo_app');

  removeperf()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove("username");

  }


  Future getdata() async {
    Uri uri = Uri.parse(
        "https://mhd.tpowep.com/json" + widget.name.toString() + "");

    http.Response response = await http.get(uri);

    var DataString = response.body;
    var _dataa = json.decode(DataString);

    if (_dataa.toString()== "[]") {
      removeperf();
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
          MyLogin()));
      print("nullok");

    } else {
      print(response.statusCode);
    }

    var jsonsDataString = response.body;
    var _data = json.decode(jsonsDataString);
    //saveperf(_data[0]['name'],_data[0]['address'], _data[0]['Specialization']);
    setState(() {
      storage.setItem('name', _data[0]['name']);
      storage.setItem('address', _data[0]['address']);
      storage.setItem('text', _data[0]['Specialization']);
      storage.setItem('note', _data[0]['note']);

    });
    return _data;
  }


  _saveToStorage(String item) {
    storage.setItem('todos', item);
  }

  @override
  Widget build(BuildContext context) {



    final LocalStorage storage = new LocalStorage('todo_app');
    int h=int.parse(DateTime.now().second.toString());
//333if({}
    if(storage.getItem("hour")!=null){
      if(DateTime.now().hour >=6 &&DateTime.now().minute >=30 &&
          (storage.getItem("hour") < 6 &&storage.getItem("M") < 30

              || storage.getItem("day")!=DateTime.now().day)
      ){

        setState(() {
          storage.setItem('todos',"لم يتم الحجز");
          storage.setItem("day",0);
          storage.setItem("hour",0);
          //delpath(context);


        });


      }

    }
    DateTime pre_backpress = DateTime.now();

  var mdw=MediaQuery.of(context).size.width;
    var mdh=MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async{
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if(cantExit){
          //show snackbar
          final snack = SnackBar(content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),);
          exit(0);
          return false;
        }else{
          return true;
        }
      },
      child:


      Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(


          drawer: drawer(),
          appBar: AppBar(
            backgroundColor: primary,
            title: Text("الصفحة الشخصية"),
          ),
          body: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 20, right: 10),
                  child: Container(
                    height: mdh/2,

                    child: Row(
                      children: [
                        Expanded(child:
                        ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: MyImagePicker(),
                            ),


                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Countdown(


                                  seconds:1,
                                  build: (BuildContext context, double time) => Text(''),
                                  interval: Duration(milliseconds: 100),
                                  onFinished: () {

                                    setState(() {
                                    });
                                  },
                                )
                            ),

                          ],


                        ),


                        ),
                        Expanded(child: Container(
                          height: mdh/2,
                          child:ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: ListTile(

                                  title: Text("الاسم"+":"+" "+
                                      storage.getItem('name').toString()
                                  ),

                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: ListTile(

                                  title: Text("العنوان"+":"+" "+  storage.getItem('address').toString()),

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: ListTile(         title: Text("الاختصاص"+":"+" "+  storage.getItem('text').toString()),

                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: ListTile(         title: Text("الملاحظات"+":"+" "+  storage.getItem('note').toString()),

                                ),

                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: myAd(),
                              )


                            ],
                          ),
                        ))

                      ],

                    ),
                  )

              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Container(
                    height: mdh/2,
                    child: Path()),
              ),

            ],
          ),
        ),
      ),
    );
  }


  saveperf(
      String name,
      String address,
      String text,

      )async  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString("name", name);
    sharedPreferences.setString("address",address);
    sharedPreferences.setString("text", text);

    print(sharedPreferences.get("name"));

  }
}


delpath(BuildContext context) async {
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

  var ser=sharedPreferences.get("username");

  var data = {
    "txt":ser,
  };
  Uri url = Uri.parse(
      "https://tpowep.com/pro/api/delpath.php?txt='$ser'");

  var reesponse = await http.post(url, body: data);
  var responsebody = jsonDecode(reesponse.body);
  print(responsebody);





}

nof(

    String title,
    String body,
    String tokin,



    ) async {

  var data = {
    "ad":title,
    "b":body,
    "t":tokin


  };
  Uri url = Uri.parse(
      "https://tpowep.com/pro/api/seb.php?t=$tokin");
  print("url="+url.toString());
  var reesponse = await http.post(url, body: data);
  var responsebody = jsonDecode(reesponse.body);
  print("ccccccccccccccccccccccc="+responsebody.toString());





}
