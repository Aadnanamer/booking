import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/constants.dart';
import '/utils/static_data.dart';
import '/widgets/house_card.dart';
//Dashboard
 class Dashboard extends StatefulWidget {
   const Dashboard({Key? key}) : super(key: key);

   @override
   State<Dashboard> createState() => _DashboardState();
 }

 class _DashboardState extends State<Dashboard> {
   String? _savedData=" ";
   lodeSaveData() async
   {

     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     if(sharedPreferences.getString("USER")!=null) {

       setState(() {
         _savedData = sharedPreferences.getString("USER").toString();
       });

     }
     else
     {
       _savedData= "not vallue";


     }
     return _savedData;
   }
   @override
   void initState() {
     super.initState();
   lodeSaveData();

   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: SingleChildScrollView(
         child: Container(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             mainAxisSize: MainAxisSize.min,
             children: [
               SafeArea(child: SizedBox()),
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 24.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     SvgPicture.asset("assets/svg/menu.svg"),
                     CircleAvatar(
                       backgroundColor: Colors.transparent,
                       radius: 20.0,
                       backgroundImage: AssetImage("assets/images/user.png"),
                     )
                   ],
                 ),
               ),
               SizedBox(
                 height: 15.0,
               ),
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 24.0),
                 child: Text(
                   "مرحبا بـك \n "+'$_savedData',
                   textAlign: TextAlign.right,
                   style: TextStyle(
                     fontSize: 26.0,
                     height: 1.5,
                     color: Color.fromRGBO(33, 45, 82, 1),
                     fontWeight: FontWeight.w600,
                   ),
                 ),
               ),
               SizedBox(
                 height: 15.0,
               ),
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 24.0),
                 child: Container(
                   height: ScreenUtil().setHeight(59.0),
                   decoration: BoxDecoration(
                     color: Color.fromRGBO(251, 251, 251, 1),
                     borderRadius: BorderRadius.circular(8.0),
                   ),
                   padding: EdgeInsets.only(left: 16.0, right: 8.0),
                   child: Row(
                     children: [
                       Container(
                         height: ScreenUtil().setHeight(50.0),
                         width: ScreenUtil().setWidth(50.0),
                         decoration: BoxDecoration(
                           color: Constants.primaryColor,
                           borderRadius: BorderRadius.circular(10.0),
                         ),
                         child: Icon(
                           Icons.search,
                           color: Colors.white,

                         ),
                       ),
                       Expanded(

                         child: TextField(
                           textAlign: TextAlign.right,
                           decoration: InputDecoration(
                             border: InputBorder.none,
                             hintText: " ...   ابحث عن ",

                           ),
                         ),
                       ),

                     ],
                   ),
                 ),
               ),
               SizedBox(
                 height: 15.0,
               ),
               Padding(
                 padding: EdgeInsets.symmetric(
                   horizontal: 24.0,
                 ),
                 child: Text(
                   "الثمامة",
                   textAlign:TextAlign.right,
                   style: TextStyle(
                     fontSize: 18.0,
                     height: 1.5,
                     color: Color.fromRGBO(33, 45, 82, 1),
                     fontWeight: FontWeight.w600,
                   ),
                 ),
               ),
               SizedBox(
                 height: 10.0,
               ),
               Container(
                 height: ScreenUtil().setHeight(300.0),
                 // Lets create a model to structure property data
                 child: ListView.separated(
                   padding: EdgeInsets.symmetric(horizontal: 24.0),
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (BuildContext context, int index) {
                     // Lets create a property card widget
                     return HouseCard(
                       house: StaticData.properties[index],apart: "2",
                     );
                   },
                   separatorBuilder: (BuildContext context, int index) {
                     return SizedBox(
                       width: 10.0,
                     );
                   },
                   // Make the length our static data length
                   itemCount: StaticData.properties.length,
                 ),
               ),
               SizedBox(
                 height: 25.0,
               ),
               Padding(
                 padding: EdgeInsets.symmetric(
                   horizontal: 24.0,
                 ),
                 child: Text(
                   "الدمام ",
                   textAlign:TextAlign.right,
                   style: TextStyle(
                     fontSize: 18.0,
                     height: 1.5,
                     color: Color.fromRGBO(33, 45, 82, 1),
                     fontWeight: FontWeight.w600,

                   ),
                 ),
               ),
               SizedBox(
                 height: 10.0,
               ),
               Container(
                 height: ScreenUtil().setHeight(300.0),
                 // Lets create a model to structure property data
                 child: ListView.separated(
                   padding: EdgeInsets.symmetric(horizontal: 24.0),
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (BuildContext context, int index) {
                     // Lets create a property card widget
                     return HouseCard(
                       house: StaticData.Khoper[index], apart: '3',
                     );
                   },
                   separatorBuilder: (BuildContext context, int index) {
                     return SizedBox(
                       width: 10.0,
                     );
                   },
                   // Make the length our static data length
                   itemCount: StaticData.Khoper.length,
                 ),
               )
             ],
           ),
         ),
       ),
     );
   }
 }

