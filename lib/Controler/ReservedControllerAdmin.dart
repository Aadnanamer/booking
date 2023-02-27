import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../models/Reserved.dart';
import '../utils/constants.dart';
class ReservedControllerAdmin extends GetxController
{

  RxList<Reserved> ReservedList=RxList() ;
  RxList<Reserved> ReservedList1=RxList() ;
  RxList<Reserved> ReservedList3=RxList() ;

  var loder=true.obs;
  // final userdata = GetStorage();
  String? stat=" ";

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }


  @override
  void onInit() {
    //   lodeSaveData();
    GetReserved(stat);
    super.onInit();

  }


  @override
  void onClose() {

    super.onClose();
  }
  Future<void> GetReserved(stat )
  async {
    loder.value=true;


    String url = Constants.URL+"ReservedAdmin.php?ID="+stat;

    try { //Starting Web API Call.
      var response = await http.get(Uri.parse(url));


      if (response.statusCode == 200) {
        var msg = json.decode(response.body);
        {

          ReservedList=RxList();
          ReservedList1=RxList();
          ReservedList3=RxList();

          var tmep;
          for (var singleUser in msg) {
           /*  tmep= Reserved(
                USER: singleUser['USERNAME'],
                STATE: (singleUser['STATE'] == '1' ? 'موكد ' : 'غير موكد'),
                DATE_FROM: singleUser['DATE_FROM'],
                DATE_TO: singleUser['DATE_TO'],
                ID_APARTMENT: singleUser['NAME'],
                ID: singleUser['ID'],
                USERID: '',
           );

            */
           //  ReservedList.add(tmep);
            // ReservedList1.add(tmep);
             //ReservedList3.add(tmep);

           if(singleUser['STATE']=='0') {
             tmep= Reserved(
               USER: singleUser['USERNAME'],
               STATE: ('غير موكد'),
               DATE_FROM: singleUser['DATE_FROM'],
               DATE_TO: singleUser['DATE_TO'],
               ID_APARTMENT: singleUser['NAME'],
               ID: singleUser['ID'],
               USERID: '',
             );
             ReservedList.add(tmep);
           }
           else if(singleUser['STATE']=='1') {
             tmep= Reserved(
               USER: singleUser['USERNAME'],
               STATE: ('  موكد'),
               DATE_FROM: singleUser['DATE_FROM'],
               DATE_TO: singleUser['DATE_TO'],
               ID_APARTMENT: singleUser['NAME'],
               ID: singleUser['ID'],
               USERID: '',
             );
             ReservedList1.add(tmep);
           }
             if(singleUser['STATE']=='3') {
               tmep= Reserved(
                 USER: singleUser['USERNAME'],
                 STATE: ('  ملفيه'),
                 DATE_FROM: singleUser['DATE_FROM'],
                 DATE_TO: singleUser['DATE_TO'],
                 ID_APARTMENT: singleUser['NAME'],
                 ID: singleUser['ID'],
                 USERID: '',
               );
               ReservedList3.add(tmep);
             }



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