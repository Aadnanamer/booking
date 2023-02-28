import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/ADMIN/tabs_screen.dart';
import '../pages/USER/booking_screen.dart';
import '/models/property.dart';
import '../pages/ADMIN//booking_screen_admin.dart';
import '/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_core/src/get_main.dart';
class HouseCard extends StatelessWidget {
  final Property house;
 final String apart;
  HouseCard({required this.house, required this.apart});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        if (sharedPreferences.getString("USERTYPE") != "0") {


          Helper.nextPage(context, BookingScreen_admin(apart));
        }
        else
        {

          Helper.nextPage(context, BookingScreen(apart));
        }
      },
      child: Container(
        height: ScreenUtil().setHeight(300.0),
        width: ScreenUtil().setWidth(MediaQuery.of(context).size.width-80.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Color(0xFFF4F5F6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      house.imagePath,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
