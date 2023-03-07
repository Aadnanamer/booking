// TODO Implement this library.import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:flutter_neat_and_clean_calendar/neat_and_clean_calendar_event.dart';
import 'package:http/http.dart'as http;
import '../utils/constants.dart';
import '/models/Reserved.dart';
class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),

        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
  Future userLogin() async {
    String url = Constants.URL+"serch.php?ID=0";
    try { //Starting Web API Call.
      var response = await http.get(Uri.parse(url));


  if (response.statusCode == 200) {
    var msg = json.decode(response.body);
{

  List<NeatCleanCalendarEvent> _todaysEvents = [

  ];

  for (var singleUser in msg) {
    _todaysEvents.add( NeatCleanCalendarEvent(singleUser['USERNAME']+ '--'+ singleUser['NAME'],
        startTime:  DateTime.parse(singleUser['DATE_FROM']),
        endTime:  DateTime.parse(singleUser['DATE_TO']),
description:singleUser['DATE_FROM']+' :: '+singleUser['DATE_TO'] ,
        color: Colors.blue[700]));
}
  setState(() {
    _eventList=_todaysEvents;
  });

}

  }


    }
    catch(err)
    {

    }
  }


  late  List<NeatCleanCalendarEvent> _eventList = [

  ];

  @override
  void initState() {
    super.initState();
    userLogin();
    // Force selection of today on first load, so that the list of today's events gets shown.
    _handleNewDate(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: EdgeInsets.all(16),
          child: Calendar(
            startOnMonday: true,
            eventsList: _eventList,
            isExpandable: true,
            eventDoneColor: Colors.green,
            selectedColor: Colors.pink,
            selectedTodayColor: Colors.green,
            todayColor: Colors.blue,
            eventColor: null,
            locale: 'ar',

            isExpanded: true,
            expandableDateFormat: 'EEEE, dd. MMMM yyyy',
            datePickerType: DatePickerType.date,
            dayOfWeekStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
          ),
        ),
      ),

    );
  }

  void _handleNewDate(date) {

  var ele=  _eventList.contains("$date");
    print('Date selected: $ele');
  }
  void add()
  {
    _eventList = [
      NeatCleanCalendarEvent('MultiDay Event A',
          description: 'test desc',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day  , 10, 0),
          color: Colors.orange,
          isMultiDay: true),


    ];
    setState(() {

    });

  }
}