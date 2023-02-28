import 'dart:developer';

import 'package:booking/models/USER.dart';

import '/utils/constants.dart';
import 'package:flutter/material.dart';

import 'Reserved.dart';


class List_User_admin extends StatelessWidget {
 late final User ListUser;

 List_User_admin(this.ListUser);


  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl, child: ListTile(
      leading: CircleAvatar(
        radius: 24.0,
        backgroundImage: AssetImage('assets/images/user.png'),
      ),
      title: Row(
        children: <Widget>[
          Text(ListUser.NAME),
          SizedBox(
            width: 16.0,
          ),

        ],
      ),
      subtitle: Text(ListUser.STAT),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 14.0,
      ),
    ),
    );
  }
}
