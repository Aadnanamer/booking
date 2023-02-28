import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/models/bottom_bar_item.dart';
import '/pages/dashboard.dart';
import '/utils/constants.dart';

class AppBottomNavigation extends StatefulWidget {
  @override
  _AppBottomNavigationState createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  String activePage = "home"; // Track active page

  void setActivePage(String page) {
    setState(() {
      activePage = page;
    });
  }

  //LEts create a model for the items on the bar
  List<BottomBarItem> items = [

  ];

  @override
  void initState() {
    items = [
      BottomBarItem(
        icon: Icons.import_contacts_sharp,
        onPressed: () {
          setActivePage("home");
        },
        key: "home",
      ),
      BottomBarItem(
        icon: Icons.calendar_today,
        onPressed: () {
          setActivePage("favorites");
        },
        key: "favorites",
      ),
      BottomBarItem(
        icon: Icons.person,
        onPressed: () {
          setActivePage("dashboard");
        },
        key: "dashboard",
      ),
      BottomBarItem(
        icon: Icons.person,
        onPressed: () {
          setActivePage("menu");
        },
        key: "menu",
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 12.0,
        bottom: 12.0,
        right: 12.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      height: ScreenUtil().setHeight(65.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items
            .map(
              (BottomBarItem item) =>
                  getBottomWidgetItem(item, activePage == item.key),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomWidgetItem(BottomBarItem item, bool isActive) {
  return Container(
    height: ScreenUtil().setHeight(62.0),
    width: ScreenUtil().setWidth(62.0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: isActive ? Constants.primaryColor : Colors.transparent,
    ),
    child: AnimatedSwitcher(
      duration: Duration(milliseconds: 450),
      child: isActive
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  height: 5.0,
                  width: 5.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                )
              ],
            )
          : Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: IconButton(
                icon: Icon(
                  item.icon,
                  color: Color.fromRGBO(156, 166, 201, 1),
                ),
                onPressed: item.onPressed,
              ),
            ),
    ),
  );
}
