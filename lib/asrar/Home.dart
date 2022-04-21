import 'dart:convert';

import 'package:drive011221/Screens/Home/mainscreen.dart';
import 'package:drive011221/asrar/Second.dart';
import 'package:drive011221/asrar/azkaarlist.dart';
import 'package:drive011221/asrar/naflheadd.dart';
import 'package:drive011221/asrar/naflhlist.dart';
import 'package:drive011221/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  loginchek() async {
    var response;
    var result;



    Uri uri =     Uri.parse("https://tpowep.com/bol.json");

    var reesponse = await http.get(uri);
    result = jsonDecode(reesponse.body);
    Map<String , dynamic> map=result as Map<String , dynamic>;
    print(map['boool']);
    String ok=map['boool'];
    if (ok=='true')
    {

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyLogin()));

    }
    else
    {

    }

  }

  Widget build(BuildContext context) {
    loginchek();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wq.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                    Second()));
                  },

                  child: Image.asset("assets/btn1.png")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        addnaflh()));
                  },
                  child: Image.asset("assets/btn2.png")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child:

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                              Second()));
                        },
                        child:
                        InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                  nafelhList()));
                            },

                            child: Image.asset("assets/btn1000.png",width: 50,height: 50,))),
                  ),
                  ),
                  Expanded(child:

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                              azkarList()));
                        },
                        child: Image.asset("assets/btn100.png",width: 50,height: 50,)),
                  ),
                  ),

                ],
              ),
            )

          ],
        ),
        )

    );
  }
}
