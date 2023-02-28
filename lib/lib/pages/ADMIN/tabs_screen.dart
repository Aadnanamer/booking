import '../../Controler/ReservedControllerAdmin.dart';
import '../../utils/constants.dart';
import '../Profil.dart';
import 'ListResvition.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../dashboard.dart';
import '../CalendarScreen.dart';
import 'ListUser.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _page = 0;
  ReservedControllerAdmin post=Get.put(ReservedControllerAdmin());
  late String user="",res="";
  Future get_bar() async {

    //Login API URL
    //use your local IP address instead of localhost or use Web API

    String url = Constants.URL+"get_bar.php?";

    // Showing LinearProgressIndicator.


    // Getting username and password from Controller


    //Starting Web API Call.
    var response = await http.get(
        Uri.parse(url));
    if (response.statusCode == 200) {
      //Server response into variable

      var msg = jsonDecode(response.body);

      //Check Login Statu




setState(() {
  res= msg['res'];
  user= msg['user'];
});


        // Navigate to Home Screen
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(uname:msg['userInfo']['NAME'])));
      }
    print(res);
    }




  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
@override
  void initState() {
    // TODO: implement initState
  get_bar();
  super.initState();
  }
  final List<Widget> _screen=[
    Dashboard(),
    ListPage(key: UniqueKey(), title: '',),
    CalendarScreen(),
    ListUser(key: UniqueKey(), title: '',),
    Profile(key: UniqueKey(), title: '',),

  ];
  @override
  Widget build(BuildContext context) => WillPopScope(child: Scaffold(

    bottomNavigationBar: CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,

      items: <Widget>[
        Icon(Icons.home, size: 26, color: Color(0xFF354259)),
        Badge(
          label: Text(post.counter.value.toString()),
          child:  Icon(Icons.calendar_today, size: 26, color: Color(0xff354259)),
        ),
        Icon(Icons.calendar_today, size: 26, color: Color(0xff354259)),
        Badge(
          label: Text(user),
          child:  Icon(Icons.person, size: 26, color: Color(0xff354259)),
        ),
        Icon(Icons.person, size: 26, color: Color(0xff354259)),

      ],
      color: Colors.white,
      backgroundColor: Colors.grey.withOpacity(0.1),
      // buttonBackgroundColor:  Color(0xffCDC2AE),
      height: 50,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
      letIndexChange: (index) => true,
    ),
    body:_screen[_page] ,


  ), onWillPop: () async
  {
    return false;
  }
  ) ;





}

