import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../widgets/primary_button.dart';
import 'package:http/http.dart'as http;
import 'package:art_sweetalert/art_sweetalert.dart';
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> with InputValidationMixin {
  final formGlobalKey = GlobalKey < FormState > ();
  late String oldpassword,newpassword,textoldpassword,ID,comfnewpassword;
  lodeSaveData() async
  {

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.getString("USER")!=null) {

      setState(() {
        ID = sharedPreferences.getString("ID").toString();
        oldpassword = sharedPreferences.getString("password").toString();

      });

    }
    else
    {
      ID= "null";


    }
    return ID;
  }
  show(messg, bool bool) {
    var  type;
    if(bool)
    {
      type= ArtSweetAlertType.success;
    }
    else
      {
           type= ArtSweetAlertType.danger;
      }
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(

        type: type,

            confirmButtonText: "تــــم",
            confirmButtonColor :  Constants.primaryColor,
            title: messg
        )
    );
  }
  Future<void> Keep(Key,Value) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //final int counter = (prefs.getInt(msg) ?? 0) + 1;


    prefs.setString(Key, Value);
  }

  Future ACCEPT() async {

    //Login API URL
    //use your local IP address instead of localhost or use Web API

    String url = Constants.URL+"RestPassword.php?uid="+ID +"&newpassword="+ newpassword+"&oldpassword="+ oldpassword ;

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

Keep("password", newpassword);
        show("تم  إعادة تعيين كلمة المرور بنجاح ",true);


        // Navigate to Home Screen
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(uname:msg['userInfo']['NAME'])));
      } else {

        //Show Error Message Dialog

        show("فشل ",false);

      }
    } else {

      show("فشل ",false);
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    lodeSaveData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
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
                              "  إعادة تعيين كلمة المرور ",
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

                                        "كلمة مرور القديمه ",
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
                                          onChanged: (String value) { textoldpassword=value;} ,
                                          validator: (email) {
                                            if (email.toString().trim()==oldpassword) return null;
                                            else
                                              return "كلمة مرور القديمه غير مطابقه";
                                          },
                                          obscureText:false,
                                          decoration: InputDecoration(
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
                                        "كلمة مرور الجديده ",
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

                                          onChanged: (String value) { newpassword=value;} ,
                                          validator: (password) {
                                            if (password==comfnewpassword) return null;
                                            else
                                              return 'كلمة مرور غير مطابقه ';
                                          },
                                          obscureText:false,
                                          decoration: InputDecoration(

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
                                      ),
                                      Text(
                                        "كلمة مرور الجديده ",
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

                                          onChanged: (String value) { comfnewpassword=value;} ,
                                          validator: (password) {
                                            if (password==newpassword) return null;
                                            else
                                              return 'كلمة مرور غير مطابقه ';
                                          },
                                          obscureText:false,
                                          decoration: InputDecoration(

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
                                      ),SizedBox(
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




                    ],)),
                  PrimaryButton(
                    text: "تاكيد",
                    onPressed: () {
          if (formGlobalKey.currentState!.validate()) {
          formGlobalKey.currentState!.save();
          ACCEPT();
          // use the email provided here
          }


                      //   userLogin();



                      //       fet();
//Get.to(Dashboard());
                    },
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
}

class FormValidationExample extends StatelessWidget with InputValidationMixin {
  final formGlobalKey = GlobalKey < FormState > ();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Form validation example'),
        ),
        body:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formGlobalKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Email"
                  ),
                  validator: (email) {
                    if (isEmailValid(email!)) return null;
                    else
                      return 'Enter a valid email address';
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  maxLength: 6,
                  obscureText: true,
                  validator: (password) {
                    if (isPasswordValid(password!)) return null;
                    else
                      return 'Enter a valid password';
                  },
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      if (formGlobalKey.currentState!.validate()) {
                        formGlobalKey.currentState!.save();
                        // use the email provided here
                      }
                    },
                    child: Text("Submit"))
              ],
            ),
          ),
        ));
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String email) {
    String pattern ='^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';
    RegExp regex = new RegExp(pattern);


    return regex.hasMatch(email);
  }
}