//addnaflh
import 'package:localstorage/localstorage.dart';
import 'package:drive011221/Screens/Home/mainscreen.dart';
import 'package:flutter/material.dart';
class addnaflh extends StatefulWidget {
  const addnaflh({Key? key}) : super(key: key);

  @override
  _addnaflhState createState() => _addnaflhState();
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

class _addnaflhState extends State<addnaflh> {
  @override

  TextEditingController text = new TextEditingController ();
  TextEditingController num = new TextEditingController ();

  final TodoList list = new TodoList();
  final LocalStorage storage = new LocalStorage('todo_app');
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
    storage.setItem('todos', list.toJSONEncodable());
  }

  _clearStorage() async {
    await storage.clear();

    setState(() {
      list.items = storage.getItem('todos') ?? [];
    });
  }

  Widget build(BuildContext context) {
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
                child: TextField(
                  controller: text,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,

                      filled: true,
                      hintText: "النافلة",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: num,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,

                      filled: true,
                      hintText: "عدد الركعات",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),

              Padding(
                  padding: const EdgeInsets.only(bottom: 1,top: 0),
                  child: RaisedButton(
                    color: Colors.grey.shade100,
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    onPressed: () {
                      _save();
                    chlog(context);
                      },

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("حفظ في الذاكرة", style: TextStyle(
                            color: Colors.black),),


                      ],
                    ),
                  )
              ),

            ],
          ),
        )

    );
  }
}



Future<void>chlog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('تم الحفظ'),

        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[

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
