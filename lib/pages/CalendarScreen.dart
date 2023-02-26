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
  List<Reserved> users = [];
  List<NeatCleanCalendarEvent> _todaysEvents = [

  ];

  for (var singleUser in msg) {
    _todaysEvents.add( NeatCleanCalendarEvent(singleUser['USERNAME']+ '--'+ singleUser['NAME'],
        startTime:  DateTime.parse(singleUser['DATE_FROM']),
        endTime:  DateTime.parse(singleUser['DATE_TO']),
description:singleUser['DATE_FROM']+' :: '+singleUser['DATE_TO'] ,
        location:" 1  c",
        multiDaySegement:["  2الثامة","الثامة"],

        color: Colors.blue[700]));
}
  setState(() {
    _eventList=_todaysEvents;
  });
  //Navigator.pop(context);
}
  /*
    //Check Login Status
    if (msg['loginStatus'] == true) {
      show("yes");
      /*
      setState(() {
    //   DateTime DATE_FROM = DateTime.parse(msg['userInfo']['DATE_FROM']);
      //  DateTime DATE_TO = DateTime.parse(msg['userInfo']['DATE_TO']);


        _eventList = [
          NeatCleanCalendarEvent('   amer A',
              description: '  adnan',
              startTime: DateTime(DateTime
                  .now()
                  .year, DateTime
                  .now()
                  .month,
                  DateTime
                      .now()
                      .day, 10, 0),
              endTime: DateTime(DateTime
                  .now()
                  .year, DateTime
                  .now()
                  .month,
                  DateTime
                      .now()
                      .day, 10, 0),
              color: Colors.orange,
              isMultiDay: true),


        ];
      });


       */
      // Navigate to Home Screen

    } else {
      show("Message");
    }
  } else {
    //hide progress indicator
    show("Error during connecting to Server");

    //Show Error Message Dialog
    //  showMessage("Error during connecting to Server.");




   */
  }


    }
    catch(err)
    {

    }
  }

  List<NeatCleanCalendarEvent> _todaysEvents = [
    NeatCleanCalendarEvent('Event A',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 12, 0),
        description: 'A special event',
        color: Colors.blue[700]),
  ];

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
        child: Calendar(
          startOnMonday: true,
          weekDays: ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'],
          eventsList: _eventList,
          isExpandable: true,
          eventDoneColor: Colors.green,
          selectedColor: Colors.pink,
          selectedTodayColor: Colors.green,
          todayColor: Colors.blue,
          eventColor: null,
          locale: 'de_DE',
          todayButtonText: 'Heute',
          allDayEventText: ' ',
          multiDayEndText: ' ',
          isExpanded: true,
          expandableDateFormat: 'EEEE, dd. MMMM yyyy',
          datePickerType: DatePickerType.date,
          dayOfWeekStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {userLogin();},
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _handleNewDate(date) {
    print('Date selected: $date');
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