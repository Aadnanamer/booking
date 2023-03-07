
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/pages/login.dart';
import 'ADMIN/tabs_screen.dart';
import 'USER/tabs_screen_user.dart';
import '/widgets/home_page_template.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller = PageController();
  int currentPage = 0;
  String? _savedData=" ";
  lodeSaveData() async
  {
try {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString("Keep") != null && sharedPreferences.getString("Keep").toString().isNotEmpty
      &&sharedPreferences
      .getString("Keep")
      .toString()=="true") {

    if (sharedPreferences.getString("USERTYPE") != "0") {

      Get.to(TabScreen());
    }
    else
    {
      Get.to(TabScreenUser());
    }
  }
}
catch(ee)
    {

    }
  }
  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!.round();
      });
    });
    lodeSaveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          // Since all pages follow same pattern, let's make a template for them
          children: [
            HomePageTemplate(
              activePage: currentPage,
              title: "Let's Start  Together",
              imagePath: "assets/images/page1.png",
            ),
            HomePageTemplate(
              activePage: currentPage,
              title: "Let's Start  Together",
              imagePath: "assets/images/page2.png",
            ),

          ],
        ),
      ),
    );
  }
}
