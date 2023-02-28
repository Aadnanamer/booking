import 'dart:async';

import 'package:flutter/material.dart';

import 'home.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {    //duration of splash screen and auto execute
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), ()
    {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(

          child: Column(

            children: [
              SizedBox(
                height: 100,
              ),

              Image.asset('assets/images/logo.png', height: 500,),
              SizedBox(height: 5),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff01b2b8)),
              )

            ],
          ),
        ),
      ),
    );
  }
}