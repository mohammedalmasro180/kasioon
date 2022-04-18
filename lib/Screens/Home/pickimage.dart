import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:drive011221/Screens/Home/HomeScreen.dart';
import 'package:drive011221/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class MyImagePicker extends StatefulWidget {



  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  final LocalStorage storage = new LocalStorage('todo_app');
  late PickedFile _imageFile;
  final String uploadUrl = 'https://api.imgur.com/3/upload';
  final ImagePicker _picker = ImagePicker();
  PickedFile? pickedImage;
  late File imageFile;
  bool _load = false;

  late bool _disabale;
  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/$_imageFile'; // 3

    return filePath;
  }
  void eble()
  {

  }


  Widget _previewImage() {

    String url=  storage.getItem('img').toString();

//print('=== '+url);


    return    SingleChildScrollView(
        child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                      height: MediaQuery.of(context).size.height/3,
                      child:Container(
                        height:850,
                        width: 850,
                        child: Image.file(File(url.toString()) , width:850,height: 850,
                          errorBuilder: (BuildContext context,
                              Object error,
                              StackTrace? stackTrace){
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Image.asset("img/0.jpg" , width: 190,height: 140,),
                                ),

                                Padding(
                                    padding: const EdgeInsets.only(bottom: 1,top: 0),
                                    child: RaisedButton(
                                      color:
                                      c2,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 30),
                                      onPressed: () {
                                        _pickImage();
                                      },

                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("صورة   شخصية", style: TextStyle(
                                              color: Colors.white),),
                                          Icon(Icons
                                              .picture_in_picture_alt_outlined,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ],

                            );
                          },),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.all(1.0),
                      ))),

            ] )
    );

  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _imageFile = pickedFile!;
        _load=true;

        //      print(_imageFile.path.toString());
        // Step 1: Save image/file path as string either db or shared pref
        storage.setItem("img", _imageFile.path.toString());
        _disabale=false;
      });
    } catch (e) {
//      print("Image picker error " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    return _previewImage();
  }

}

