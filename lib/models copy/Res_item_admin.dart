import 'dart:developer';

import '/utils/constants.dart';
import 'package:flutter/material.dart';

import 'Reserved.dart';


class ReservationItem_admin extends StatelessWidget {
 late final Reserved ReservedInfo;

 ReservationItem_admin(this.ReservedInfo);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
            borderRadius: BorderRadius.circular(30)
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.bookmark_border_outlined, color: Colors.grey, size: 30),

              Row(
                children: [

                  Text("رقم :"+ ReservedInfo.ID, style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 20),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)

                    ),
                    child: Image.asset("assets/images/logo.png"),
                  ),

                ],
              ),

            ],
          ),
          SizedBox(height: 15),
          Text(ReservedInfo.USER, style:
          TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
          Text(ReservedInfo.DATE_FROM+ " ............ "+ReservedInfo.DATE_TO, style:
          TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                padding: EdgeInsets.all(0),
                backgroundColor: Constants.primaryColor,
                label: Text(ReservedInfo.STATE, style: TextStyle(color: Colors.white)),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Text(ReservedInfo.ID_APARTMENT,style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey.withOpacity(0.9)
                  ),),
                  SizedBox(width: 10),
                  Icon(Icons.location_on, color: Constants.primaryColor,size: 24),


                ],

              ),


            ],

          ),

        ],
      ),
    );
  }
}
