import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../utils/constants.dart';
import '../widgets/profile_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'ResetPasswordPage.dart';
class Profile extends StatefulWidget {
  Profile({required Key key, required this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
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
      backgroundColor: kAppPrimaryColor,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBarButton(
                        icon: Icons.arrow_back,
                      ),
                      SvgPicture.asset("assets/icons/menu.svg"),
                    ],
                  ),
                ),
                AvatarImage(),
                SizedBox(
                  height: 30,
                ),
                SocialIcons(),
                SizedBox(height: 30),
                Text(
                  '$_savedData',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins"),
                ),

                SizedBox(height: 15),

                ProfileListItems(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final IconData icon;

  const AppBarButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kAppPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: kLightBlack,
              offset: Offset(1, 1),
              blurRadius: 10,
            ),
            BoxShadow(
              color: kWhite,
              offset: Offset(-1, -1),
              blurRadius: 10,
            ),
          ]),
      child: Icon(
        icon,
        color: fCL,
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(8),
      decoration: avatarDecoration,
      child: Container(
        decoration: avatarDecoration,
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/user.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class SocialIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

    );
  }
}

class SocialIcon extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final VoidCallback  onPressed;
  Future<void> Keep(Key,Value) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //final int counter = (prefs.getInt(msg) ?? 0) + 1;


    prefs.setString(Key, Value);
  }
  SocialIcon({required this.color, required this.iconData, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    return new Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: onPressed,
          child: Icon(iconData, color: Colors.white),
        ),
      ),
    );
  }
}

class ProfileListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          ProfileListItem(
            icon: LineAwesomeIcons.user_shield,
            text: 'تغير كلمة المروار', key: UniqueKey(),
            onPressed: () {
              Get.to(ResetPasswordPage());
            },

          ),


          ProfileListItem(
            text: 'الاعدادت',key: UniqueKey(),
            icon: LineAwesomeIcons.cog,
            onPressed: () {  },

          ),

          ProfileListItem(
            icon: LineAwesomeIcons.alternate_sign_out,
            text: 'تسجيل الخروج',key: UniqueKey(),
            hasNavigation: false,
            onPressed: () {


    Keep("USER","");
    Keep("ID","");
    Keep("STATE","");
    Keep("USERTYPE","" );
    Keep("Keep","false");
    Navigator.pop(context); },
          ),
        ],
      ),
    );
  }
}


Future<void> Keep(Key,Value) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  //final int counter = (prefs.getInt(msg) ?? 0) + 1;


  prefs.setString(Key, Value);
}