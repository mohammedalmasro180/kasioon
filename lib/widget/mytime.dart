import 'package:drive011221/widget/myAd.dart';
import 'package:flutter/material.dart';
import 'package:time/time.dart';
class mytime extends StatefulWidget {
  const mytime({Key? key}) : super(key: key);
  //String mytimee=DateTime.now().minute.toString();
void myt(){

}
  @override
  _mytimeState createState() => _mytimeState();
}

class _mytimeState extends State<mytime> {

  @override

  Widget build(BuildContext context) {
    if(DateTime.now().minute.toString()=="31")
      print("ok");
    return Scaffold(
      body: Center(
        child: myAd()
        ),

    );
  }
}
