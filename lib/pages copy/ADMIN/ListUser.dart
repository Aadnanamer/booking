import 'dart:convert';
import '../../models/Bottom_user_admin.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import '../../models/Res_user_admin.dart';
import '../../models/USER.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '/utils/constants.dart';
class ListUser extends StatefulWidget {
  ListUser({required Key key, required this.title}) : super(key: key);

  final String title;
    String Stat="0";
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListUser> {
  late List ReservedList;
  late String Stat="0";
  Future<Null> ReservedShow(stat) async {


    //print(ReservedList.length);

    String url = Constants.URL+"ListUser.php?ID="+stat;
    try { //Starting Web API Call.
      var response = await http.get(Uri.parse(url));


      if (response.statusCode == 200) {
        var msg = json.decode(response.body);
        {
          List<User> users = [];


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

            users.add( User(
                NAME: singleUser['USERNAME'],
                ID: singleUser['ID'],
                TYPE: singleUser['TYPE'],
                STAT: Statlocal,));


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

    }


  }
  @override
  void initState() {

    ReservedList = getLessons();
    ReservedShow(Stat);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        

    return  Scaffold(

      appBar: AppBar(
        title: const Text('المستخدمين'  ,style: TextStyle(color: Colors.black),),
          backgroundColor:Colors.white,
      ),
      body:
          ListView.builder(
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
                      builder: (context)=>boottom_user_admin( companyInfo: ReservedList[index],),
                    );
                  },

                  child: RefreshIndicator(
onRefresh: _pullRefresh,
                    child:  List_User_admin( ReservedList[index]),
                     ),




              );


            },





          ),


    );
  }

  Future<void> _pullRefresh() async {
 //   List<String> freshNumbers = await NumberGenerator().slowNumbers();
    setState(() {
   //   numbersList = freshNumbers;
    });
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }
}

List getLessons() {
  return [

  ];
}


class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: // Directly use inside yoru [TabBar]
          TabBar(
            indicatorColor: Colors.green,
            tabs: [
              Tab(
                text: "Home",
              ),
              Tab(
                text: "Work",
              ),
              Tab(
                text: "Play",
              ),
            ],
            labelColor: Colors.black,
            // add it here
            indicator: DotIndicator(
              color: Colors.black,
              distanceFromCenter: 16,
              radius: 3,
              paintingStyle: PaintingStyle.fill,
            ),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: ListViewBuilder(),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ListView.builder")),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: const Icon(Icons.list),
                trailing: const Text(
                  "GFG",
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
                title: Text("List item $index"));
          }),
    );
  }
}