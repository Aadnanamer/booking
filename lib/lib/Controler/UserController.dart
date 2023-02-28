import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../models/Reserved.dart';
import '../models/USER.dart';
import '../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserController extends GetxController
{
  RxList<User> users=RxList() ;
  var loder=true.obs;
  // final userdata = GetStorage();
  String? _savedData=" ";
  lodeSaveData() async
  {

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.getString("USER")!=null) {


      late String savedData = sharedPreferences.getString("ID").toString();


      return savedData;
    }
    else
    {
      _savedData= "not vallue";


    }

    return _savedData;
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }


  @override
  void onInit() {
    //   lodeSaveData();
    GetReserved( );
    super.onInit();

  }


  @override
  void onClose() {

    super.onClose();
  }
  Future<void> GetReserved( )
  async {
    loder.value=true;

    String url = Constants.URL+"ListUser.php?";
    try { //Starting Web API Call.
      var response = await http.get(Uri.parse(url));


      if (response.statusCode == 200) {
        var msg = json.decode(response.body);
        {
        users = RxList();

print(msg);
          for (var singleUser in msg) {
            var Statlocal="";
            if(singleUser['STATE']=='1')
            {Statlocal='موكد ';

            }
            else
            if(singleUser['STATE']=='0')
            {
              Statlocal='غير موكد';

            }

            users.add( User(
              NAME: singleUser['USERNAME'],
              ID: singleUser['ID'],
              TYPE: singleUser['TYPE'],
              STAT: Statlocal,));


          }

          //Navigator.pop(context);
        }

      }


    }
    catch(err)
    {
      print("errorr");
    }
    loder.value=false;
    //  username++;
    //   update();
  }

}