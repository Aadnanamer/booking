import 'dart:convert';
import '../../models/Bottom_admin.dart';
import '../../models/Res_item_admin.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:flutter/material.dart';
import '/models/Reserved.dart';
import 'package:http/http.dart'as http;
import '/utils/constants.dart';
class ListPage extends StatefulWidget {
  ListPage({required Key key, required this.title}) : super(key: key);

  final String title;
    String Stat="0";
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late List ReservedList,ReservedList1,ReservedList2;
  late String Stat="0";
  Future ReservedShow(stat) async {


    //print(ReservedList.length);

    String url = Constants.URL+"ReservedAdmin.php?ID="+stat;
    try { //Starting Web API Call.
      var response = await http.get(Uri.parse(url));


      if (response.statusCode == 200) {
        var msg = json.decode(response.body);
        {
          List<Reserved> users = [];


          for (var singleUser in msg) {
            var Statlocal="";
            if(singleUser['STATE']=='1')
              {Statlocal='موكد ';

              }
            else
            if(singleUser['STATE']=='0')
            {
              Statlocal='غير موكد';

            }
            else
            if(singleUser['STATE']=='3')
            {
              Statlocal='ملغي';

            }
            users.add( Reserved(
                USER: singleUser['USERNAME'],
                STATE: Statlocal,
                DATE_FROM: singleUser['DATE_FROM'],
                DATE_TO:singleUser['DATE_TO'],
                ID_APARTMENT:singleUser['NAME'],
                ID: singleUser['ID'],
                USERID: ''));

          }
          setState(() {
            ReservedList=users;
          });
          //Navigator.pop(context);
        }

      }


    }
    catch(err)
    {
print("errorr");
    }
  }
  @override
  void initState() {

    ReservedList = getLessons();
    ReservedList1 = getLessons();
    ReservedList2 = getLessons();
    ReservedShow(Stat);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        

    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        bottom:
        // Directly use inside yoru [TabBar]
        TabBar(
        indicatorColor: Colors.red,
          onTap: (int index) {

            setState(() {
              ReservedList=getLessons();
            });
          var stat=index;
          if(index==2)
            {
              stat=index+1;
            }
            ReservedShow(stat.toString());
          },
        tabs: [
          Tab(
            text: "غير موكده",

          ),
        Tab(
        text: "موكده",
    ),
    Tab(
    text: "ملغيه",
    ),
    ],
    labelColor: Colors.black,
    // add it here
     indicator: MaterialIndicator(
          height: 5,
          topLeftRadius: 8,
          topRightRadius: 8,
          horizontalPadding: 50,
          tabPosition: TabPosition.bottom,
        ),
    ),
    ),
      body: TabBarView(
        children: <Widget>[

          ListTab("0"),
          ListTab("1"),

          ListTab("3"),
        ]),

    ));
  }
}

List getLessons() {
  return [

  ];
}



class ListTab extends StatefulWidget {
late String Stat;
    ListTab(String stat, {Key? key})

  {
    Stat=stat;
  }


  @override
  State<ListTab> createState() => _ListTabState(Stat);
}

class _ListTabState extends State<ListTab> {
  late String Stat;
  _ListTabState(stat)
  {
    this.Stat=stat;
  }
  late List ReservedList,ReservedList1,ReservedList2;

  Future ReservedShow(stat) async {


    //print(ReservedList.length);

    String url = Constants.URL+"ReservedAdmin.php?ID="+stat;
    try { //Starting Web API Call.
      var response = await http.get(Uri.parse(url));


      if (response.statusCode == 200) {
        var msg = json.decode(response.body);
        {
          List<Reserved> users = [];


          for (var singleUser in msg) {
            var Statlocal="";
            if(singleUser['STATE']=='1')
            {Statlocal='موكد ';

            }
            else
            if(singleUser['STATE']=='0')
            {
              Statlocal='غير موكد';

            }
            else
            if(singleUser['STATE']=='3')
            {
              Statlocal='ملغي';

            }
            users.add( Reserved(
                USER: singleUser['USERNAME'],
                STATE: Statlocal,
                USERID: singleUser['USER'],
                DATE_FROM: singleUser['DATE_FROM'],
                DATE_TO:singleUser['DATE_TO'],
                ID_APARTMENT:singleUser['NAME'],
                ID: singleUser['ID'],

            ));

          }
          setState(() {
            ReservedList=users;
          });
          //Navigator.pop(context);
        }

      }


    }
    catch(err)
    {
      print("errorr");
    }
  }
  @override
  void initState() {

    ReservedList = getLessons();
    ReservedList1 = getLessons();
    ReservedList2 = getLessons();
    ReservedShow(Stat);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: ReservedList.length,
      itemBuilder: (BuildContext context, int index) {

        return GestureDetector(
            onTap: (){
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context)=>boottom_admin( companyInfo: ReservedList[index],),
              );
            },

            child: ReservationItem_admin(ReservedList[index]));


      },





    );
  }


  List getLessons() {
    return [

    ];
  }
}
