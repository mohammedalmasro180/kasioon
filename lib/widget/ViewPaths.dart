import 'dart:convert' show utf8;
import 'package:localstorage/localstorage.dart';

import 'package:time/time.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'package:timer_count_down/timer_controller.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
bool
enble=true;
class Path extends StatefulWidget {

  const Path({Key? key,}) : super(key: key);


  @override
  _PathState createState() => _PathState();
}
var person;
var encoded = utf8.encode(storage.getItem('name').toString());
var
name = utf8.decode(encoded);

final LocalStorage storage = new LocalStorage('todo_app');

_saveToStorage(String item) {
  storage.setItem('todos', item);
  storage.setItem('day', DateTime.now().day);

  storage.setItem('hour', DateTime.now().hour);
  storage.setItem('M', DateTime.now().minute);


}


final CountdownController _controller =
new CountdownController(autoStart: false);

class _PathState extends State<Path> {
late double op=0;

  var username="لم يتم الحجز";

@override

  removeperf()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove("Path");


  }

  getuser(String user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    user =  preferences.getString("username").toString();
    print(user);
    return user;
  }
 @override
  Widget build(BuildContext context) {
    int t=int.parse(DateTime.now().minute.toString());
    setState(() {
      //cheakpath();
    });

    if(

    storage.getItem('todos').toString()=="لم يتم الحجز"
        ||
        storage.getItem('todos').toString()=='null')

    {enble=true;}
    else
    {enble=false;}

    saveperf(String Path)async  {
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setString("Path", Path);
      print(sharedPreferences.get("Path"));

    }

    Future getdata() async{

      Uri uri = Uri.parse("https://tpowep.com/pro/api/api.php");

      http.Response response = await http.get(uri);
      String jsonsDataString = response.body.toString();
      var    _data = jsonDecode(jsonsDataString);

      return _data;

    }

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate); // 2016-01-25
    return  Scaffold(


      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
        children: [


          Expanded(child: Text(
            //DateTime.now().toString()
            storage.getItem('todos').toString()=="null"?"لم يتم الحجز":storage.getItem('todos').toString()
            ,style: TextStyle(color: Colors.black),)),
          Expanded(child: InkWell(
              onTap: () async {
                SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                var ser=sharedPreferences.get("username");



                setState(()  {
  enble=true;


  _saveToStorage("لم يتم الحجز");
  delpath(context, ser.toString(),);
});
},
 child: Icon(Icons.close,color: Colors.black,))),

        ],
      ),),

        body: FutureBuilder(
            future: getdata(),
            builder:(BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(

                    itemCount: snapshot.data.length,

                    itemBuilder: (context,i) {
                      return ListTile(
                        subtitle:  Text(formattedDate,),
                        title:  Row(
                          children: [
                            Expanded(child: Text(
                              snapshot.data[i]['form'].toString(),
                              style: TextStyle(fontSize: 15,),)),


                            Expanded(child:Row(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: RaisedButton(

                                    color: Colors.black,
                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                                    onPressed:enble?() async {
                                      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

                                      var ser=sharedPreferences.get("username");
                                      setState(() {
                                        enble=false;



                                        getnum(

        snapshot.data[i]['id'].toString(),


                                            storage.getItem('name').toString(),
                                            snapshot.data[i]['id'].toString(),
                                            context,

                                            //count
                                            snapshot.data[i]['count'].toString(),
                                            snapshot.data[i]['form'].toString(),
                                          ser.toString()


                                        );

                                        op=1;
                                      });






                                      _controller.restart();

                                    }:null,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [

                                        Text("حجز",style: TextStyle(color:Colors.white),),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Countdown(
                                      controller: _controller,

                                      seconds:1,
                                      build: (_, double time) =>

                                          Opacity(opacity: op,
                                              child: CircularProgressIndicator()),
                                      interval: Duration(milliseconds: 100),
                                      onFinished: () {
                                        setState(() {

                                        });
                                        op=0;
                                      },
                                    )
                                ),
                              ],
                            )),


                          ],

                        ),
                      );

                    }
                );

              }

              else
                return CircularProgressIndicator();
            }
        )

    );
  }

}







  post(BuildContext context,String number,String ser,String name) async {
  var data = {
    "txt": number,
    "ser":ser,
    "name":name
  };
  Uri url = Uri.parse(
      "https://tpowep.com/pro/api/code.php");

  var reesponse = await http.post(url, body: data);
  var responsebody = jsonDecode(reesponse.body);
  enble=false;





}
delpath(BuildContext context,String ser) async {
  var data = {
    "txt":ser,
  };
  Uri url = Uri.parse(
      "https://tpowep.com/pro/api/delpath.php?txt='$ser'");

  var reesponse = await http.post(url, body: data);
  var responsebody = jsonDecode(reesponse.body);
  print(responsebody);





}


Future getnum(
    String number,
    String user,
    String id,
    BuildContext context,
    String cont,
    String storage,
String usernamee,
    )
async {
  Uri uri = Uri.parse(
      "https://tpowep.com/pro/api/countpath.php?id=$number");
  int gool=int.parse(cont);
  http.Response response = await http.get(uri);

  print(response.body);
  var jsonsDataString = response.body;
  var _data = json.decode(jsonsDataString);
  int coun = int.parse(_data);
  if (coun >=gool) {
    msg(context);
  }
  else {
    _saveToStorage(storage);
post(context, number, user,usernamee);
  }

}
Future<void> msg(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must t\\ap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Icon(Icons.error,color: Colors.red,),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('الحجز ممتلئ'),

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
