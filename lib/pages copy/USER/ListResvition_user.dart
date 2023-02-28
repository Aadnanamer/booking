import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Controler/ReservedController.dart';
import '../../Controler/ReservedControllerAdmin.dart';
import '../../models/Res_details.dart';
import '/models/Res_item.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/models/Reserved.dart';
import 'package:http/http.dart'as http;
import '/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListPage extends StatefulWidget {
  ListPage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late List<Reserved> ReservedList=<Reserved>[];
  String? _savedData=" ";
  lodeSaveData() async
  {

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.getString("USER")!=null) {

      setState(() {
        _savedData = sharedPreferences.getString("ID").toString();
        ReservedShow();
      });

    }
    else
    {
      _savedData= "not vallue";


    }

    return _savedData;
  }
  Future ReservedShow() async {


    String url =  Constants.URL+"ReservedUser.php?ID="+_savedData.toString();
    try { //Starting Web API Call.
      var response = await http.get(Uri.parse(url));


      if (response.statusCode == 200) {
        var msg = json.decode(response.body);
        {
          List<Reserved> users = [];


          for (var singleUser in msg) {
            users.add( Reserved(
                USER: singleUser['USERNAME'],

                STATE: (singleUser['STATE']=='1' ?  'موكد ' : 'غير موكد'),
                DATE_FROM: singleUser['DATE_FROM'],
                DATE_TO:singleUser['DATE_TO'],
                ID_APARTMENT:singleUser['NAME'],
                ID: singleUser['ID'],
                USERID: ''));

          }
          setState(() {
            EasyLoading.dismiss();
            ReservedList=users;
          });
          //Navigator.pop(context);
        }

      }


    }
    catch(err)
    {
      print("errorr");
    }
    EasyLoading.dismiss();
  }
  ReservedController post=Get.put(ReservedController());
  @override
  void initState() {
    print("initState");
   // ReservedController post=Get.put(ReservedController());
    //  ReservedList = getLessons();
    // lodeSaveData();
    /*
    EasyLoading.instance ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 60
      ..textColor = Colors.black
      ..radius = 20
      ..backgroundColor = Colors.transparent
      ..maskColor = Colors.white ..indicatorColor = Constants.primaryColor
      ..userInteractions = false ..dismissOnTap = false
      ..boxShadow = <BoxShadow>[]
      ..indicatorType = EasyLoadingIndicatorType.threeBounce;
    EasyLoading.show(maskType: EasyLoadingMaskType.black,




    );
    */
    ReservedControllerAdmin reservedController=Get.put(ReservedControllerAdmin());
    reservedController.GetReserved("");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {





    final makeBody = Container(
      margin: EdgeInsets.only(top: 60),
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child:
      Obx(()=>post.loder.value?Center(child: SpinKitThreeInOut(
        color: Constants.primaryColor,
        size: 50.0,
      ),):
      ListView.builder(

        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: post.ReservedList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: (){
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context)=>   boottom_user(companyInfo: post.ReservedList[index])
                );
              },

              child: ReservationItem(post.ReservedList[index]));

        },
      )),




    );

    return Scaffold(

      body:  Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),

              ),
              Expanded(
                flex: 1,
                child: Container(
                    color: Colors.grey.withOpacity(0.1)
                ),

              ),
            ],
          ),
          makeBody

        ],
      ),

    );
  }
}

List getLessons() {
  return [

  ];
}