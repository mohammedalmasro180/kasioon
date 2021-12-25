import 'package:shared_preferences/shared_preferences.dart';
class SaveVal{
// ignore: non_constant_identifier_names
  SavePersonInformation(String name,String address,String  text ) async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString("name", name);
    name=sharedPreferences.get("name").toString();
    print(sharedPreferences.get("name"));
//--------
    sharedPreferences.setString("address", address);
    address=sharedPreferences.get("address").toString();
    print(sharedPreferences.get("address"));
//--------
    sharedPreferences.setString("text", text);
    text=sharedPreferences.get("text").toString();
    print(sharedPreferences.get("text"));
//--------


  }
}