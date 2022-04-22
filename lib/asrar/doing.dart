
import 'package:flutter/cupertino.dart';
import 'package:drive011221/asrar/sqllite/db.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
class doing extends StatefulWidget {
final String text;
  const doing({Key? key,required this.text}) : super(key: key);

  @override
  _doingState createState() => _doingState();
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

class _doingState extends State<doing> {
  @override
  int _counter = 0;

  void _resetCounter() {
    setState(() {
      _counter=0;
    });
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
      final item = new TodoItem(title: widget.text
          , numner:_counter.toString() );
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
  Widget build(BuildContext context) {
    SqlDb sqlDb=new SqlDb();
    late int i=0;
        return Directionality(
          textDirection: TextDirection.rtl,

          child: Scaffold(

          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/wq.jpg",),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("${widget.text}",style: TextStyle(fontSize: 23),),
                ),

      Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text("$_counter",style: TextStyle(fontSize: 23),),
      ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                      onTap: (){
                        _incrementCounter();
                      },
                      child: Image.asset("assets/csm.png")),
                ),

                GestureDetector(
                  onTap: (){
  _resetCounter();
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/csm.png",width: 22,height: 22,),
                  ),
                ),


SizedBox(width: MediaQuery.of(context).size.width,),


                Padding(
                    padding: const EdgeInsets.only(bottom: 1,top: 0),
                    child: RaisedButton(
                      color: Colors.grey.shade100,
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      onPressed: ()async {
                        int response=await sqlDb.insertData(
                            "INSERT INTO `azkar` ('text','num','dete') VALUES"
                                "('"+widget.text+"','"+_counter.toString()+"','"+DateTime.now().toString()+"')");


                        List<Map> result=await sqlDb.readData("SELECT *FROM azkar");
                        print("$result");

                        chlog(context);
                      },        child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("حفظ في الذاكرة", style: TextStyle(
                              color: Colors.black),),

]

                      ),
                    )
                ),



              ],
            ),
          ),


    ),
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
