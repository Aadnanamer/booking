import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'pages/SplashScreen.dart';
import 'utils/constants.dart';
import 'pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:get/get.dart';
/*
void main() {
  runApp(MyApp());
}

 */
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  String? token = await FirebaseMessaging.instance.getToken();
  print("token : "+token.toString());
  print("Handling a background message: ${message.messageId}");
}
_getPermeesion()
async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    late String m= message.data.toString();


    final notification = message.notification;
    if (notification != null) {
      var title=notification.title.toString();
      var body=notification.body.toString();
      print('Message also contained a notification: ${notification}');
      Get.defaultDialog(

          title: title,
          middleText: body,
          backgroundColor: Constants.primaryColor,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          radius: 30

      );
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  _getPermeesion();
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    builder: EasyLoading.init(),

  ));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (BuildContext context,child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Airbnb Redesign',
        theme: ThemeData(
          primaryColor: Constants.primaryColor,
          scaffoldBackgroundColor: Color.fromRGBO(229, 229, 229, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,

        ),
        initialRoute: "/",
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }
}

// We need to make an onGenerateRoute function to handle routing

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (BuildContext context) {
        return SplashScreen(); //To be created
      });
    case "adnan":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Home(); //To be created
      });
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return Home(); //To be created
      });
  }
}
