import 'package:shared_preferences/shared_preferences.dart';

class Storage {



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
