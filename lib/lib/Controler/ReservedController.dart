import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../models/Reserved.dart';
import '../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ReservedController extends GetxController
{
  RxList<Reserved> ReservedList=RxList() ;
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
    late String savedData;
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.getString("USER")!=null) {
      savedData= sharedPreferences.getString("ID").toString();
    }
    String url = Constants.URL + "ReservedUser.php?ID=" + savedData;

    try { //Starting Web API Call.
      var response = await http.get(Uri.parse(url));


      if (response.statusCode == 200) {
        var msg = json.decode(response.body);
        {

          ReservedList=RxList();

          for (var singleUser in msg) {
            ReservedList.add( Reserved(
                USER: singleUser['USERNAME'],

                STATE: (singleUser['STATE']=='1' ?  'موكد ' : 'غير موكد'),
                DATE_FROM: singleUser['DATE_FROM'],
                DATE_TO:singleUser['DATE_TO'],
                ID_APARTMENT:singleUser['NAME'],
                ID: singleUser['ID'],
                USERID: ''));

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