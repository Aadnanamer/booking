import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../Profil.dart';
import 'ListResvition_user.dart';
import 'personal_info_page.dart';
import '../dashboard.dart';

class TabScreenUser extends StatefulWidget {
  const TabScreenUser({Key? key}) : super(key: key);

  @override
  State<TabScreenUser> createState() => _TabScreenUserState();
}

class _TabScreenUserState extends State<TabScreenUser> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _screen=[
    Dashboard(),
    ListPage(title: '', key: UniqueKey(),),
    Profile(key: UniqueKey(), title: '',),
  ];
  @override
  Widget build(BuildContext context) => WillPopScope(child: Scaffold(

    bottomNavigationBar: CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,

      items: <Widget>[
        Icon(Icons.home, size: 26, color: Color(0xFF354259)),
        Icon(Icons.calendar_today, size: 26, color: Color(0xff354259)),
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

