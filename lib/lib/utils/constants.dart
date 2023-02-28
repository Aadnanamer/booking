import 'package:flutter/material.dart';

class Constants {
  static final Color primaryColor =
      Color(0xFF314441);  //Preffered primary color
  static final Color highlightColor =
      Color.fromRGBO(71, 148, 255, 0.2); //Preffered primary color
  static final Color highlightColor2 =
      Color.fromRGBO(71, 148, 255, 0.3);
  static final Color FontColor =
  Color(0xFFE9D0AF);

  static final String URL ="https://ahla-alamirat.com/RSG/API/";


///Preffered primary color
}
Color kAppPrimaryColor = Colors.grey.shade200;
Color kWhite = Colors.white;
Color kLightBlack = Colors.black.withOpacity(0.075);
Color mCC = Colors.green.withOpacity(0.65);
Color fCL = Colors.grey.shade600;


IconData twitter = IconData(0xe900, fontFamily: "CustomIcons");
IconData facebook = IconData(0xe901, fontFamily: "CustomIcons");
IconData googlePlus =
IconData(0xe902, fontFamily: "CustomIcons");
IconData linkedin = IconData(0xe903, fontFamily: "CustomIcons");

const kSpacingUnit = 10;

final kTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

BoxDecoration avatarDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: kAppPrimaryColor,
    boxShadow: [
      BoxShadow(
        color: kWhite,
        offset: Offset(10, 10),
        blurRadius: 10,
      ),
      BoxShadow(
        color: kWhite,
        offset: Offset(-10, -10),
        blurRadius: 10,
      ),
    ]
);