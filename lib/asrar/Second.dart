//Second
import 'package:drive011221/Screens/Home/mainscreen.dart';
import 'package:drive011221/asrar/doing.dart';
import 'package:flutter/material.dart';
class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  TextEditingController text = new TextEditingController ();

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
                      hintText: "ادخل الذكر",
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
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context)=>
                            doing(text: text.text)),
                            (Route<dynamic> route) => false,
                      );

                    },

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("بدء الذكر", style: TextStyle(
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
