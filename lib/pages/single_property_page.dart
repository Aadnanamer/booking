import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/utils/constants.dart';
import '/widgets/property_features.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
class SinglePropertyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        double heightFromWhiteBg =
            size.height - 300.0; // height for white section
        return Container(
          height: size.height,
          child: Stack(
            children: [

              Positioned(
                width: size.width,

                child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(
                height: 90.0,
              ),
              Container(
                height: 350.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.range,
                  headerStyle: DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                  ),
                ),
              ),



            ],
          ),
        ),
              ),
              Positioned(
                top: 450.0,
                width: size.width,
                child: Container(
                  height: heightFromWhiteBg,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Soneve Kiri",
                            style: TextStyle(
                              fontSize: 18.0,
                              height: 1.5,
                              color: Color.fromRGBO(33, 45, 82, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.favorite,
                            color: Constants.primaryColor,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                      Icons.import_contacts_sharp,
                            color: Color.fromRGBO(138, 150, 190, 1),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              "Bashundhara, Dhaka, Bangladesh",

                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      //Property features
                      PropertyFeatures(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "This is one of the best houses you can get around the vicinity, check in to experience pleasure.",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,

                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 16.0, right: 5.0),
                        height: ScreenUtil().setHeight(56.0),
                        decoration: BoxDecoration(
                          color: Constants.primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "120\$ / ",

                                  ),
                                  TextSpan(
                                    text: " night",

                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                height: ScreenUtil().setHeight(45.0),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  "BOOK ROOM",

                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

}
