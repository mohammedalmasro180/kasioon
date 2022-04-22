


import 'package:drive011221/asrar/sqllite/db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:localstorage/localstorage.dart';


class azkarList extends StatefulWidget {
  azkarList({Key? key}) : super(key: key);

  @override
  _MyazkarListState createState() => new _MyazkarListState();
}

class TodoItem {
  String title;
  String numner;

  TodoItem({required this.title, required this.numner});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['title'] = title;
    m['number'] = numner;

    return m;
  }
}

class TodoList {
  List<TodoItem> items = [];

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}


class _MyazkarListState extends State<azkarList> {

  TextEditingController text = new TextEditingController ();
  TextEditingController num = new TextEditingController ();

  final TodoList list = new TodoList();
  final LocalStorage storage = new LocalStorage('azkar');
  bool initialized = false;
  TextEditingController controller = new TextEditingController();

  _toggleItem(TodoItem item) {
    setState(() {

      _saveToStorage();
    });
  }

  _addItem(String title,String num) {
    setState(() {
      final item = new TodoItem(title: title, numner:num );
      list.items.add(item);
      _saveToStorage();
    });
  }


  void _save() {
    _addItem(text.text,num.text);
    controller.clear();
  }
  _saveToStorage() {
    storage.setItem('azkar', list.toJSONEncodable());
  }

  _clearStorage() async {
    await storage.clear();

    setState(() {
      list.items = storage.getItem('azkar') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
getdata();
    return Directionality(
      textDirection: TextDirection.rtl,

      child: new Scaffold(

        body: Container(
            padding: EdgeInsets.all(10.0),
            constraints: BoxConstraints.expand(),
            child:    FutureBuilder(
            future: getdata(),
          builder:(BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
              itemCount: snapshot.data!.length,
physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,i) {
                    return ListTile(
                      title: Text("  الذكر"+"  "+snapshot.data![i]['text'].toString()),
                    subtitle: Text("  العدد"+" "+snapshot.data![i]['num'].toString()),
                      //  leading: Text(snapshot.data![i]['dete'].toString()),
                    );

                  }
              );

            }

            else
              return CircularProgressIndicator();
          }
      )
    ),
    ),
    );
  }
  SqlDb sqlDb=new SqlDb();

  Future<List<Map>> getdata () async{

  List<Map> result= await sqlDb.readData("SELECT *FROM azkar");
  print("$result");
return result;
}
}