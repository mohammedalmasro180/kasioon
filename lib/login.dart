import 'package:drive011221/Screens/Home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drive011221/Screens/Home/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';





import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  GlobalKey<FormState> formstate=new GlobalKey();
  bool selected = false;

  TextEditingController username = new TextEditingController ();
  TextEditingController passwordd = new TextEditingController ();

  bool liading=false;


  // For CircularProgressIndicator.
  bool visible = false ;
  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  logiwn() async {
    var response;
    var result;
    var fromdata = formstate.currentState;



    fromdata?.save();
    Uri uri =     Uri.parse("https://tpowep.com/pro/api/loginmhd.php");
    var data = {"username": username.text, "password": passwordd.text};










    var reesponse = await http.post(uri, body: data);
    result = jsonDecode(reesponse.body);
    //ed=responsebody;
    print(result);

    if (result=="Login") {

      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
          HomeScreen(name: username.text)));
      setState(() {

        saveperf(username.text);
      });
      liading=true;




    }
    else {
      msg(context);
      liading=false;
    }
    print(liading);

  }



  @override
  Widget build(BuildContext context) {
setState(() {
  go(context);
});
    return         Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(),
              Container(
                padding: EdgeInsets.only(right: 35, top: 130),
                child: Text(
                  'مرحباً',
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Form(
                          key: formstate,
                          child: Column(
                            children: [
                              TextField(
                                controller: username,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "اسم المستخدم",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(

                                height: 30,
                              ),
                              TextField(
                                controller: passwordd,
                                style: TextStyle(),
                                obscureText: true,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "كلمة المرور",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'تسجيل دخول',
                                    style: TextStyle(
                                        fontSize: 27, fontWeight: FontWeight.w700),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff4c505b),
                                    child: IconButton(
                                        color: Colors.white,
                                        onPressed: () {
                                          logiwn();
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward,
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),

                            ],
                          ),
                        ),
                      )
                    ],

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Future<void> msg(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Icon(Icons.error,color: Colors.red,),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('خطأ في تسجيل الدخول'),

            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

saveperf(String username)async  {
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  sharedPreferences.setString("username", username);
  print(sharedPreferences.get("username"));

}
go(BuildContext context) async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
var  username=   preferences.getString("username");
  if(username!= null) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
        HomeScreen(name: username)));


    print(username);
  }
  else
  {}
}
