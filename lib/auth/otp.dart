import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/home.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart'as http;
import 'package:art_sweetalert/art_sweetalert.dart';
import '../pages/login.dart';
import '../utils/constants.dart';
import '../widgets/primary_button.dart';
import 'package:get/get.dart';
class OTPScreen extends StatefulWidget {
  final String phone;
  final String name;
  final String pass;
  final String username;


  OTPScreen(this.phone, this.name, this.pass, this.username );
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  Future userLogin() async {


    //Login API URL
    //use your local IP address instead of localhost or use Web API

    try {
      String url = Constants.URL+"signin.php?name=" +
          widget.name + "&uname=" +  widget.username + "&pass=" +  widget.pass+ "&PHONE=" +  widget.phone;
      //  String url = "https://ahla-alamirat.com/RSG/API/signin.php?name=adnan&uname=ad&pass=;
      // Showing LinearProgressIndicator.


      // Getting username and password from Controller


      //Starting Web API Call.
      var response = await http.get(
          Uri.parse(url));
      if (response.statusCode == 200) {
        //Server response into variable

        var msg = jsonDecode(response.body);

        //Check Login Status
        if (msg['loginStatus'] == true) {
          ArtDialogResponse response = await ArtSweetAlert.show(
              barrierDismissible: false,
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "تم ارسال الطللب ",
                text: "  سوف  يتم مراجعت طلبك من قبل لادمن",
                confirmButtonColor: Constants.primaryColor,
                confirmButtonText: "تــــــم ",

              )
          );
          if (response == null) {
            return;
          }

          if (response.isTapConfirmButton) {
            Get.to(LOGIN());
            return;
          }
          //  Get.to(LOGIN());
          // Navigate to Home Screen
          //  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(uname:msg['userInfo']['NAME'])));
        } else {
          //Show Error Message Dialog
          ArtDialogResponse response = await ArtSweetAlert.show(
              barrierDismissible: false,
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.warning,
                title: "لم يتم ارسال الطللب ",

                confirmButtonColor: Constants.primaryColor,
                confirmButtonText: "تــــــم ",

              )
          );
          if (response == null) {
            return;
          }

          if (response.isTapConfirmButton) {
            return;
          }
        }
      }
      else {
        //     show("error");
      }
    }
    catch(error)
    {
      //    show("error");
    }


  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();


  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('OTP Verification'),
        backgroundColor: Colors.white,

      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +966-${widget.phone}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,

              controller: _pinPutController,

              pinAnimationType: PinAnimationType.fade,
              onSubmitted: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                      verificationId: _verificationCode!, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                    }
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

                }
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          PrimaryButton(
            text: "تسجيل", onPressed: () async {

            try {
              await FirebaseAuth.instance
                  .signInWithCredential(PhoneAuthProvider.credential(
                  verificationId: _verificationCode!, smsCode: _pinPutController.text.toString()))
                  .then((value) async {
                if (value.user != null) {
                  userLogin();
                }
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("كود التحقق غير صحيح ")));

            }



          },

          ),
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+966${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {

              userLogin();
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}
