import 'package:flutter/material.dart';
class PropertyFeatures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          item(Icons.import_contacts_sharp, "2 Adults"),
          SizedBox(
            width: 10.0,
          ),
          item(Icons.import_contacts_sharp, "1 Bed"),
          SizedBox(
            width: 10.0,
          ),
          item(Icons.import_contacts_sharp, "Free Wifi")
        ],
      ),
    );
  }
}

Widget item(IconData icon, String text) {
  return Expanded(
    child: Container(
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16.0,
            color: Color(0xFF494A6A),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            text,

          )
        ],
      ),
    ),
  );
}
