import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final VoidCallback  onPressed;

  const ProfileListItem({
    required Key key,
    required this.icon,
    required this.text,
    this.hasNavigation = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
       this.onPressed();
    },
    child: Container(
      height: 55,

      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ).copyWith(
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade300,
      ),
      child: Row(
        children: <Widget>[

          if (this.hasNavigation)
            Icon(

          LineAwesomeIcons.angle_left,
              size: 25,
            ),
          Spacer(),
          Text(
            this.text,
            style: kTitleTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins"
            ),
          ),

          SizedBox(width: 15),
          Icon(
            this.icon,
            size: 25,
          ),



        ],
      ),
    ));
  }
}
