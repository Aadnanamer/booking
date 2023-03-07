import 'dart:convert';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '/utils/constants.dart';
import '/widgets/primary_button.dart';

import 'package:http/http.dart'as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
class User {

  final String NAME;
  final String ID;
  User(  {required this.ID,required this.NAME});
}

class BookingScreen_admin extends StatefulWidget
{
  String Apartment="";
  @override
  BookingStat createState() => BookingStat(Apartment);

  BookingScreen_admin(String apartment)
  {
    Apartment=apartment;
  }
}

class BookingStat extends State<BookingScreen_admin>  {
  String Apartment="";
  BookingStat(String apartment)
  {
    Apartment=apartment;
  }
  PageController controller = PageController();
  int currentPage =1;
  var Rang =PickerDateRange(DateTime.now().add(Duration(days: 1)), DateTime.now().add(Duration(days: 5)));
  late String _startDate, _endDate;
  final DateRangePickerController _controller = DateRangePickerController();
  String _date = DateTime.now().toString();
 List<DateTime> date_dis=[];
 late  String selectUsernaem="";
  late  String selectuserID="";
  late  String hint_name="اسم المستخدم ";
  void viewChanged(DateRangePickerViewChangedArgs args) {
    SchedulerBinding.instance!.addPostFrameCallback((Duration duration) {
      _controller.selectedDate = args.visibleDateRange.startDate;
      _date= args.visibleDateRange.startDate.toString();
    });
  }


  String? _savedData=" ";
  Future GetDate() async {
    String url = Constants.URL+"ReservedDay.php?ID="+Apartment;
    try { //Starting Web API Call.
      var response = await http.get(Uri.parse(url));


      if (response.statusCode == 200) {
        var msg = json.decode(response.body);
        {
          List<DateTime> DATE_DAY=[];
          for (var singleUser in msg) {
            DateTime? f=DateTime.tryParse((singleUser['DATE']));
            DATE_DAY.add(f!);

            //date_dis.add(DateTime.tryParse((singleUser['DATE'])));

          }
          setState(() {
            date_dis=DATE_DAY;
            DateTime? f=DateTime.tryParse((date_dis.last.toString()));

            Rang =PickerDateRange(f?.add(Duration(days: 1)), f?..add(Duration(days: 2)));
            _controller.selectedRange = Rang;
          });
          //Navigator.pop(context);
        }

      }


    }
    catch(err)
    {

    }
    EasyLoading.dismiss();
  }

  Future GetUSER() async {
    String url = Constants.URL+"getUser.php?";
    try { //Starting Web API Call.
      var response = await http.get(Uri.parse(url));

      _listOfCities.clear();
      if (response.statusCode == 200) {
        var msg = json.decode(response.body);
        {
          List<User> list_user=[];
          for (var singleUser in msg) {
            
            list_user.add(User(ID: singleUser['ID'], NAME: singleUser['USERNAME'] ));
              setState(() {
                _listOfCities.add(SelectedListItem(value:singleUser['ID'],  name: singleUser['USERNAME']));
              });

            //date_dis.add(DateTime.tryParse((singleUser['DATE'])));

          }
          setState(() {
           // date_dis=Dr;
          });
          //Navigator.pop(context);
        }

      }


    }
    catch(err)
    {

    }
    EasyLoading.dismiss();
  }
  lodeSaveData() async
  {

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.getString("ID")!=null) {

      setState(() {
        _savedData = sharedPreferences.getString("ID").toString();
      });

    }
    else
    {
      _savedData= "not vallue";


    }
    return _savedData;
  }
  final List<SelectedListItem> _listOfCities = [
    SelectedListItem(
      name: "kTokyo",
      value: "TYO",
      isSelected: false,
    ),


  ];
    show(messg, bool bool) {
     var type=ArtSweetAlertType.success;
      if(bool)
        {type=ArtSweetAlertType.success;
        }
      else
        {type=ArtSweetAlertType.danger;
        }
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type:type,
              text: messg,
              confirmButtonColor: Constants.primaryColor,
              confirmButtonText: "تـــم",
          )
      );
    }
  Future userLogin() async {
    //ReservedControllerAdmin post=Get.put(ReservedControllerAdmin());
   // ReservedControllerAdmin post=Get.put(ReservedControllerAdmin());
    EasyLoading.show(maskType: EasyLoadingMaskType.black,


    );
    //Login API URL
    //use your local IP address instead of localhost or use Web API
    String url = Constants.URL+"Booking.php?start="+_startDate +"&end="+_endDate+"&user="+selectuserID! +"&apartment="+Apartment ;

    // Showing LinearProgressIndicator.


    // Getting username and password from Controller


    //Starting Web API Call.
    var response = await http.get(
        Uri.parse(url));
    if (response.statusCode == 200) {
      //Server response into variable

      var msg = jsonDecode(response.body);

      //Check Login Status
      if (msg['Status'] == true) {
        EasyLoading.dismiss();

show("تم الحجز",true);


        // Navigate to Home Screen
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(uname:msg['userInfo']['NAME'])));
      } else {
        EasyLoading.dismiss();
        //Show Error Message Dialog

        show("التاريخ المحدد غير متاح",false);

      }
    } else {
      EasyLoading.dismiss();
      show("التاريخ المحدد غير متاح",false);
    }
    //post.GetReserved("stat");

  }
  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDate =
          DateFormat('dd-MM-yyyy').format(args.value.startDate).toString();
      _endDate =
          DateFormat('dd-MM-yyyy').format(args.value.endDate ?? args.value.startDate).toString();
    });
  }
  @override
  void initState() {



    EasyLoading.instance.indicatorType=EasyLoadingIndicatorType.threeBounce;
    EasyLoading.show(
      maskType: EasyLoadingMaskType.none,

    );
    lodeSaveData();
    GetUSER();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!.round();
      });
      //lodeSaveData();
    });
    final DateTime today = DateTime.now();
    _startDate = DateFormat('dd-MM-yyyy').format(today).toString();
    _endDate = DateFormat('dd-MM-yyyy')
        .format(today.add(Duration(days: 1)))
        .toString();
    _controller.selectedRange = PickerDateRange(today, today.add(Duration(days: 1)));
    GetDate();
    super.initState();
  }
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          "المستخدمين ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data:  _listOfCities ?? [],
        selectedItems: (List<dynamic> selectedList) {
          List<String> list = [];
          for(var item in selectedList) {
            if(item is SelectedListItem) {
              list.add(item.name);
              setState(() {
                hint_name=item.name;

              selectuserID=item.value.toString();
         //       hint_name=item.value.toString();
              });

            }
          }

        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),
        title: Text(
          "تحديد التاريخ",
          style: TextStyle(
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Container(
                height: 550.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child:  Card(

                  child: SfDateRangePicker(
                    view: DateRangePickerView.month,
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedDate: DateTime.now(),
                    enablePastDates : false,
                    monthViewSettings: DateRangePickerMonthViewSettings(blackoutDates:date_dis),
                    controller: _controller,
                    onSelectionChanged: selectionChanged,
                    onViewChanged: viewChanged,

                  ),
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("اسم المستخدم"),
                const SizedBox(
                  height: 5.0,
                ),
                TextFormField(

                  cursorColor: Colors.black,
                  onTap:() {
                    FocusScope.of(context).unfocus();
                    onTextFieldTap();
                  },


                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    contentPadding: const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
                    hintText: hint_name,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
              ],
            ),
              Container(
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
                      "فترة الحجز",
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
                                "دخول",

                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                '$_startDate',

                              ),
                              SizedBox(
                                height: 5.0,
                              ),

                            ],
                          ),
                          Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: BoxDecoration(

                              shape: BoxShape.circle,
                            ),

                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "خروج",

                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                '$_endDate',

                              ),
                              SizedBox(
                                height: 5.0,
                              ),

                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 10.0,
              ),
              PrimaryButton(
                text:"حجز الان",
                onPressed: () {
                  userLogin();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}



