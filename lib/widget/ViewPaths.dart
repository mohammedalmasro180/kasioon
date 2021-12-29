import 'package:localstorage/localstorage.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Path extends StatefulWidget {

  const Path({Key? key,}) : super(key: key);


  @override
  _PathState createState() => _PathState();
}
var person;
class _PathState extends State<Path> {

  final LocalStorage storage = new LocalStorage('todo_app');

  _saveToStorage(String item) {
    storage.setItem('todos', item);

  }
  bool enble=true;
  var username="لم يتم الحجز";
  removeperf()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove("Path");

  }
  getperf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getString("Path") != null) {
      username = preferences.getString("Path").toString();
    }
    else if (preferences.getString("Path") == null) { username="لم يتم الحجز";}
    print(username);
  }


  getuser(String user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    user =  preferences.getString("username").toString();
    print(user);
    return user;
  }


  @override
  Widget build(BuildContext context) {
    storage.getItem('todos').toString()=="لم يتم الحجز";


    if( storage.getItem('todos').toString()=="لم يتم الحجز"|| storage.getItem('todos').toString()=='null')

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

    storage.getItem('todos').toString()=='';

    return  Scaffold(


      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
        children: [
          Expanded(child: Text( storage.getItem('todos').toString()
            ,style: TextStyle(color: Colors.black),)),
          Expanded(child: InkWell(
              onTap: () async {
setState(()  {
  enble=true;

removeperf();
  _saveToStorage("لم يتم الحجز");
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
                        subtitle:  Text(snapshot.data[i]['timer'].toString(),),
                        title:  Row(
                          children: [
                            Expanded(child: Text(
                              snapshot.data[i]['form'].toString(),
                              style: TextStyle(fontSize: 15,),)),


                            Expanded(child:RaisedButton(

                              color: Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                              onPressed:enble?() async {
                                setState(()=>enble=false);
                                print(enble);

                                _saveToStorage(snapshot.data[i]['form'].toString());

                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                var   user =  preferences.getString("username").toString();
                                                                post(context,
                                    snapshot.data[i]['id'].toString(),
                                    user);


                                getnum(snapshot.data[i]['id'].toString(),context);




                              }:null,

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Text("حجز",style: TextStyle(color:Colors.white),),

                                ],
                              ),
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

post(BuildContext context,String number,String ser) async {
  var data = {
    "txt": number,
    "ser":ser
  };
  Uri url = Uri.parse(
      "https://tpowep.com/pro/api/code.php");

  var reesponse = await http.post(url, body: data);
  var responsebody = jsonDecode(reesponse.body);
  print(responsebody);




}
delpath(BuildContext context,String ser) async {
  var data = {
    "txt":ser,
  };
  Uri url = Uri.parse(
      "https://tpowep.com/pro/api/delpath.php");

  var reesponse = await http.post(url, body: data);
  var responsebody = jsonDecode(reesponse.body);
  print(responsebody);





}
Future getnum(String number,BuildContext context) async {
  Uri uri = Uri.parse(
      "https://tpowep.com/pro/api/countpath.php?id=$number");
  http.Response response = await http.get(uri);

  if (response.statusCode == 200) {
    print(response.statusCode);
    print(json.decode(response.body));
  } else {
    print(response.statusCode);
  }


  var jsonsDataString = response.body;

   var _data = json.decode(jsonsDataString);
int   coun=int.parse(_data);
  if(coun>40)
    msg(context);
  else



  return coun;
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