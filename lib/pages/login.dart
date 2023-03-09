import 'dart:convert';
import 'package:booking/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/helper.dart';
import 'ADMIN/tabs_screen.dart';
import 'USER/tabs_screen_user.dart';
import '/utils/constants.dart';
import '/widgets/primary_button.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class User {
  final int id;
  final int userId;
  final String title;
  final String body;

  User({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });
}
class LOGIN extends StatefulWidget {
  const LOGIN({Key? key}) : super(key: key);

  @override
  State<LOGIN> createState() => _LOGINState();
}

class _LOGINState extends State<LOGIN> with SingleTickerProviderStateMixin{

  late String username;
  late String password;
  late String _token;
  late AnimationController controller;
  final formGlobalKey = GlobalKey < FormState > ();
  gettoken() async{
  String? token = await FirebaseMessaging.instance.getToken();

  setState(() {

  _token=token!;
  });

}
  //Textediting Controller for Username and Password Input
  late var userController = TextEditingController();
  late var pwdController = TextEditingController();
  bool _chickboxVal=false;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String? _savedData=" ";

    Future<void> Keep(Key,Value) async {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      //final int counter = (prefs.getInt(msg) ?? 0) + 1;


      prefs.setString(Key, Value);
    }


    show(messg)  {

      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.warning,
              title:  messg,
            confirmButtonText: "تـــم",
            confirmButtonColor: Constants.primaryColor
          )
      );

    }


    Future userLogin() async {
      EasyLoading.show(maskType: EasyLoadingMaskType.black,


      );
   // showLoaderDialog(context);
      //Login API URL
      //use your local IP address instead of localhost or use Web API
      String url = Constants.URL+"log.php?uname="+username+"&pass="+password+"&token="+_token;

      // Showing LinearProgressIndicator.


      // Getting username and password from Controller


      //Starting Web API Call.
      var response = await http.get(
          Uri.parse(url));

      if (response.statusCode == 200) {
        //Server response into variable
        EasyLoading.dismiss();
        var msg = jsonDecode(response.body);

        //Check Login Status
        if (msg['loginStatus'] == true) {
     //     Navigator.pop(context);
          Keep("USER",msg['userInfo']['NAME']);
          Keep("ID",msg['userInfo']['UID']);
          Keep("STATE",msg['userInfo']['STATE']);
          Keep("USERTYPE",msg['userInfo']['TYPE']);
          Keep("password",msg['userInfo']['UPASS']);
          if(_chickboxVal) {
            Keep("Keep","true");
          }
          else
            {
              Keep("Keep","false");
            }

          if (msg['userInfo']['TYPE'].toString()=="0")
          {
           Get.to(TabScreenUser());
          }
          else
          {
          Get.to(TabScreen());
          }



           // Navigate to Home Screen
          //  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(uname:msg['userInfo']['NAME'])));
        } else {
          EasyLoading.dismiss();
          //Show Error Message Dialog
          show("تاكد من اسم المستخدم او كلمة المروار");

        }
      } else {
        EasyLoading.dismiss();
        show("تاكد من اسم المستخدم او كلمة المروار");
      }
      EasyLoading.dismiss();
    }



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.login,
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),

        title: Text(
          "     تسجيل الدخول",
          style: TextStyle(
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(

        child: Builder(builder: (BuildContext context) {
          return
            Container(
              height: _size.height ,
              //Body height removing appbar height
              padding: EdgeInsets.symmetric(horizontal: 24.0),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [


                  Wrap(
                    runAlignment: WrapAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 30.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              "تسجل الدخول ",
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Color.fromRGBO(33, 45, 82, 1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            //Leta take the form to a new page
                            Container(
                                child: Form(
                                  key: formGlobalKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(

                                        "الايميل",
                                        textAlign: TextAlign.right,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: ScreenUtil().setHeight(59.0),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(247, 247, 249, 1),
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                                        child: TextFormField(

                                          onChanged: (String value) { username=value;} ,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please Enter User Name';
                                            }
                                            return null;
                                          },
                                          obscureText:false,
                                          decoration: InputDecoration(
                                            hintText: "username",
                                            hintStyle: TextStyle(
                                              fontSize: 14.0,
                                              color: Color.fromRGBO(124, 124, 124, 1),
                                              fontWeight: FontWeight.w600,
                                            ),
                                            suffixIcon:  Icon(
                                              Icons.person,
                                              color:Constants.primaryColor,
                                            ),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),     SizedBox(height: 10.0),
                                      Text(
                                        "كلمة المرور",
                                        textAlign: TextAlign.right,

                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: ScreenUtil().setHeight(59.0),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(247, 247, 249, 1),
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                                        child: TextFormField(

                                          onChanged: (String value) { password=value;} ,
                                          validator: (email) {
                                            if (email.toString().isNotEmpty) return null;
                                            else
                                              return " يجب ألا يكون الحقل المطلوب فارغاً";
                                          },
                                          obscureText:false,
                                          decoration: InputDecoration(
                                            hintText: "password",
                                            hintStyle: TextStyle(
                                              fontSize: 14.0,
                                              color: Color.fromRGBO(124, 124, 124, 1),
                                              fontWeight: FontWeight.w600,
                                            ),
                                            suffixIcon:  Icon(
                                              Icons.lock,
                                              color: Color.fromRGBO(105, 108, 121, 1),
                                            ),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),         SizedBox(
                                        height: 10.0,
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(child:
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
  Text(" حفظ كلمة المرور "),
  Checkbox(
      activeColor: Constants.FontColor,
      value: _chickboxVal, onChanged: (bool? values){

    if(values!=null)
    {
      setState(() => _chickboxVal=values);


    }
  }),


      ],)),
                  PrimaryButton(
                    text: "تسجيل",
                    onPressed: () {
                  //
                      if (formGlobalKey.currentState!.validate()) {
                        formGlobalKey.currentState!.save();
                     userLogin();
                        // use the email provided here
                      }


                      //       fet();
//Get.to(Dashboard());
                    },
                  ),
                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {

                            Helper.nextPage(context, Register());
                          },
                          child: Text(
                            " انشاء حساب  ",

                          ),
                        )
                        ,
                        Text(
                          "هل تمتلك حساب ؟",

                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),

                ],
              ),

            );
        }),
      ),

    );
  }
@override

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       Firebase.initializeApp();
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

    gettoken();
  }
}


