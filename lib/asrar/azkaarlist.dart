


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
  final LocalStorage storage = new LocalStorage('azkaar');
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
    storage.setItem('azkaar', list.toJSONEncodable());
  }

  _clearStorage() async {
    await storage.clear();

    setState(() {
      list.items = storage.getItem('azkaar') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Localstorage demo'),
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          constraints: BoxConstraints.expand(),
          child: FutureBuilder(
            future: storage.ready,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!initialized) {
                var items = storage.getItem('azkaar');

                if (items != null) {
                  list.items = List<TodoItem>.from(
                    (items as List).map(
                          (item) => TodoItem(
                        title: item['title'],
                        numner: item['number'],
                      ),
                    ),
                  );
                }

                initialized = true;
              }

              List<Widget> widgets = list.items.map((item) {
                return ListTile(
                  title: Text(item.title),
                  subtitle:   Text(item.numner),
                );
              }).toList();

              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: widgets,
                      itemExtent: 50.0,
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }


}