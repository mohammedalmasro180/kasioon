// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'dart:io';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:drive011221/Screens/Home/pickimage.dart';
import 'package:drive011221/login.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';
import 'package:drive011221/theme/color.dart';
import 'package:drive011221/widget/ViewPaths.dart';
import 'package:drive011221/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class HomeScreen extends StatefulWidget {
  final  String name;
  const HomeScreen({Key? key, required this.name }) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final LocalStorage storage = new LocalStorage('todo_app');



Future getdata() async {
    Uri uri = Uri.parse(
        "https://shahieen.tpowep.com/json" + widget.name.toString() + "");
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(json.decode(response.body));
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

    });
    return _data;
  }
  void initState() {
    super.initState();

    // sets first value



    // defines a timer
    setState(() {
      getdata();
    });
  }



  _saveToStorage(String item) {
    storage.setItem('todos', item);
  }
  @override
  Widget build(BuildContext context) {
    var address;
    Future<void> _refreshProducts(BuildContext context) async {
    setState(() {

    });
    }

    setState(() {
  _refreshProducts(context);
});

    var mdw=MediaQuery.of(context).size.width;
    var mdh=MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(


        drawer: drawer(),
        appBar: AppBar(
          backgroundColor: primary,
          title: Text("الصفحة الشخصية"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(

                padding: const EdgeInsets.only(top: 20, right: 10),
                child: Container(
                  height: mdh/2,
                  child: Row(
                    children: [
                      Expanded(child:
                      Column(
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
                      Expanded(child: RefreshIndicator(
                        onRefresh: () => _refreshProducts(context),
                        child: Container(
                          height: mdh/2,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: ListTile(

                                  title: Text("الاسم"+":"+" "+  storage.getItem('name').toString()),

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


                            ],
                          ),
                        ),
                      ))

                    ],

                  ),
                )

              ),
            ),


            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Container(
                  height: mdh/2,
                  child: Path()),
            )),

          ],
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