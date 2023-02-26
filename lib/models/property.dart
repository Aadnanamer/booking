import 'package:shared_preferences/shared_preferences.dart';

class Property {
  final String name;
  final String description;
  final String imagePath;
  final String price;

  Property({required this.name, required this.description,required this.imagePath,required this.price});

  lodeSaveData() async
  {
    String? _savedData=" ";
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.getString("USER")!=null) {
      _savedData = sharedPreferences.getString("USER");

    }
    else
    {
      _savedData= "not vallue";


    }
    return _savedData;
  }
}
