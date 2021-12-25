// ignore_for_file: deprecated_member_use
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:drive011221/Screens/Home/HomeScreen.dart';
import 'package:drive011221/model/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:localstorage/localstorage.dart';


class HomePage extends StatefulWidget {
  final  String name;
  const HomePage({Key? key, required this.name }) : super(key: key);


  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class TodoList {
  List<TodoItem> items = [];

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}

class _MyHomePageState extends State<HomePage> {
  final TodoList list = new TodoList();
  final LocalStorage storage = new LocalStorage('todo_app');
  bool initialized = false;
  TextEditingController controller = new TextEditingController();
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

    saveperf(_data[0]['name'],_data[0]['address'], _data[0]['Specialization']);


  }
  _toggleItem(TodoItem item) {
    setState(() {
      item.done = !item.done;

    });
  }

  _addItem(String title) {
    setState(() {
      final item = new TodoItem(title: title, done: false);
      list.items.add(item);

    });
  }

  _saveToStorage(String string) {
    storage.setItem('todos', string);
  }

  _clearStorage() async {
    await storage.clear();

    setState(() {
      list.items = storage.getItem('todos') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      getdata();

      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
          HomeScreen(name:'1')));


    });

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Localstorage demo'),
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          constraints: BoxConstraints.expand(),
          child:Center(
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
"محمد"
                  ,style: TextStyle(fontSize: 33),),
                ),



              ],
            ),
          )
      ),
    );
  }

  void _save() {
    _addItem(controller.value.text);
    controller.clear();
  }
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
getperf(
    String name,
    String address,
    String text,

    )async  {
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  name=sharedPreferences.get("name").toString();
  address=sharedPreferences.get("address").toString();
  text=sharedPreferences.get("text").toString();


}