import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controler/UserController.dart';
import '../utils/constants.dart';
import 'package:get/get.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:http/http.dart'as http;

import 'USER.dart';
class boottom_user_admin extends StatefulWidget {
  final User companyInfo;
  const boottom_user_admin({Key? key, required this.companyInfo}) : super(key: key);

  @override
  State<boottom_user_admin> createState() => _boottom_userState(companyInfo);
}

class _boottom_userState extends State<boottom_user_admin> {
  final User companyInfo;
  _boottom_userState(this.companyInfo);
  String? _savedData=" ";
  lodeSaveData() async
  {

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.getString("USER")!=null) {

      setState(() {
        _savedData = sharedPreferences.getString("USER").toString();
      });

    }
    else
    {
      _savedData= "not vallue";


    }
    return _savedData;
  }
  show(messg, bool bool) {


    var type=ArtSweetAlertType.success;
    if(bool)
    {type=ArtSweetAlertType.success;
    }
    else
    {type=ArtSweetAlertType.danger;
    }
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type:type,
          text: messg,
          confirmButtonColor: Constants.primaryColor,
          confirmButtonText: "تـــم",
        )
    );

    Get.back();
  }
  Future Cancel() async {
    UserController post=Get.put(UserController());
    //Login API URL
    //use your local IP address instead of localhost or use Web API
    String url = Constants.URL+"ACCEPTUSER.php?id="+companyInfo.ID +"&type=Delete";

    // Showing LinearProgressIndicator.


    // Getting username and password from Controller


    //Starting Web API Call.
    var response = await http.get(
        Uri.parse(url));
    if (response.statusCode == 200) {
      //Server response into variable

      var msg = jsonDecode(response.body);

      //Check Login Status
      if (msg['Status'] == true) {


        show("تم الحـذف  ",true);



        // Navigate to Home Screen
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(uname:msg['userInfo']['NAME'])));
      } else {

        //Show Error Message Dialog

        show("فشل ",false);

      }
    } else {

      show("فشل ",false);
    }

 post.GetReserved();

  }
  Future ACCEPT() async {

    //Login API URL
    //use your local IP address instead of localhost or use Web API

    String url = Constants.URL+"ACCEPTUSER.php?id="+companyInfo.ID +"&type=update";

    // Showing LinearProgressIndicator.


    // Getting username and password from Controller


    //Starting Web API Call.
    var response = await http.get(
        Uri.parse(url));
    if (response.statusCode == 200) {
      //Server response into variable

      var msg = jsonDecode(response.body);

      //Check Login Status
      if (msg['Status'] == true) {

        show("تم    تاكيد  ",true);

      } else {


        show("فشل ",false);

      }
    } else {

      show("فشل ",false);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, child:  Container(
      padding: EdgeInsets.all(16),

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25)
          )
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 5,
                  width: 60,
                  color: Colors.grey,
                ),
              ),
            ),

            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child:Image.asset("assets/images/logo.png"),
                      ),
                      SizedBox(width: 20),
                      Text(
                        companyInfo.ID, style: TextStyle(
                          fontSize: 16
                      ),
                      ),

                    ],

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.bookmark_border_outlined, size: 30),
                      SizedBox(width: 10),
                      Icon(Icons.more_horiz_outlined, size: 30)

                    ],
                  ),
                ),
              ],
            ),


            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(companyInfo.NAME, style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold
              ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [



                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.timer, size: 25, color:Constants.primaryColor),
                      SizedBox(width: 10),
                      Text(companyInfo.STAT)

                    ],
                  ),

                ),

              ],
            ),
            SizedBox(height: 30),


            // ...spread operator




            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,),
              child: Container(

                width: double.infinity,
                height: 40,

                child: ElevatedButton(
                  onPressed: () async {
                    ArtDialogResponse response = await ArtSweetAlert.show(
                        barrierDismissible: false,
                        context: context,

                        artDialogArgs: ArtDialogArgs(
                            denyButtonText: "الغاء",
                            title: "هل انت متاكد من    حذف الحساب ?",
                            confirmButtonText: "نعم , الغاء ",
                            confirmButtonColor :  Constants.primaryColor,
                            type: ArtSweetAlertType.warning
                        )
                    );

                    if (response == null) {
                      return;
                    }

                    if (response.isTapConfirmButton) {
                      Cancel();

                       return;
                    }
                  },

                  //  Navigator.pop(context);

                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                  child: Text(' حذف '),
                ),
              ),
            ),

          ],
        ),


      ),
    ),);

  }
}

