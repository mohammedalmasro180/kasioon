import 'package:drive011221/Screens/Home/message.dart';
import 'package:drive011221/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:drive011221/theme/color.dart';
class drawer extends StatefulWidget {
  @override
  _drwaerState createState() => _drwaerState();

}

bool sign=false;
class _drwaerState extends State<drawer> {
  var username;
  getperf() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    username=   preferences.getString("username");
    if(username!= null){
      setState(() {
        username=   preferences.getString("username");



        print(username);
      });
    }
  }

  void initState() {
    // TODO: implement initState
    getperf();
  }


  @override

  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(""),
            accountName: Text(""),
            currentAccountPicture: CircleAvatar(child: Image.asset("img/logo.png"),),
            decoration: BoxDecoration(
                color:primary
              //image: DecorationImage(image: NetworkImage("data:image/jpeg;base64,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"),fit: BoxFit.cover)
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  Message()));
            },
            child: ListTile(
              title: Text("رسائل المدير"),

              leading: Icon(Icons.category),
            ),
          ),
          Divider(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                ListTile(
                  title: Text("المطور المهندس محمد المصري"),
                  subtitle: Text("0940071446 - tpowep.com"),
                )
              ],
            ),
          )



        ],

      ),


    );
  }
}
