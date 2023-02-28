import 'dart:convert';
import '../../Controler/UserController.dart';
import '../../models/Bottom_user_admin.dart';
import '../../models/Res_user_admin.dart';
import '../../models/USER.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '/utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

        }

      }


    }
    catch(err)
    {

    }


  }
  @override
  void initState() {


    UserController userController=Get.put(UserController());
    userController.GetReserved();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    UserController post=Get.put(UserController());
    return  Scaffold(

      appBar: AppBar(
        title: const Text('المستخدمين'  ,style: TextStyle(color: Colors.black),),
          backgroundColor:Colors.white,
      ),
      body:   Obx(()=>post.loder.value?Center(child: SpinKitThreeInOut(
        color: Constants.primaryColor,
        size: 50.0,
      ),):
      ListView.builder(

        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: post.users.length,
        itemBuilder: (BuildContext context, int index) {

          return GestureDetector(
              onTap: (){
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context)=>boottom_user_admin( companyInfo: post.users[index],),
                );
              },

              child: List_User_admin(post.users[index]));

        },
      ),


    ));
  }


}

List getLessons() {
  return [

  ];
}


