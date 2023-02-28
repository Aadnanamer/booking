import 'package:flutter/material.dart';

import '/utils/constants.dart';

class BookingDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Book a Room",
            textAlign: TextAlign.center,

          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CHECK IN",

                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Oct 14",

                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Wednesday",

                    ),
                  ],
                ),
                Container(
                  width: 45.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    shape: BoxShape.circle,
                  ),

                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CHECK OUT",

                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Oct 17",

                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Saturday",

                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
