import 'dart:io';

import 'package:drive011221/theme/color.dart';
import 'package:drive011221/widget/drawer.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {

    Future getdata() async{

      Uri uri =     Uri.parse("https://tpowep.com/pro/api/mes.php");
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        print(response.statusCode);
        print(json.decode(response.body));
      } else {
        print(response.statusCode);
      }


      String jsonsDataString = response.body.toString();
      var    _data = jsonDecode(jsonsDataString);
      print(_data.toString());


      return _data;

    }
    var mdw=MediaQuery.of(context).size.width;
    return  Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(


        drawer: drawer(),
    appBar: AppBar(
    backgroundColor: primary,
    title: Text("رسائل المدير"),
    ),



          body: FutureBuilder(
              future: getdata(),
              builder:(BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(

                      itemCount: snapshot.data.length,

                      itemBuilder: (context,i) {
                        return ListTile(
                          title: Container(
                            width: mdw/2,
                            height: 60,
//                        color: Colors.amber,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                        color:sub,
                        boxShadow: [
                        BoxShadow(


                        )

                        ]

                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data[i]['text'].toString(),style: TextStyle(fontSize:16 ),),
                        ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(snapshot.data[i]['dete'].toString(),),
                          ),
                        );

                      }
                  );

                }
                else
                  return CircularProgressIndicator();
              }
          )

      ),
    );
  }
}
