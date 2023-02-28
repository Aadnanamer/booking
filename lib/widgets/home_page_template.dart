import 'package:flutter/material.dart';
import '../pages/login.dart';
import '/pages/register.dart';
import '/utils/helper.dart';
import '/widgets/page_indicator.dart';
import '/widgets/primary_button.dart';

class HomePageTemplate extends StatelessWidget {
  final int activePage;
  final String imagePath;
  final String title;

  HomePageTemplate({required this.activePage, required this.imagePath,required this.title});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    this.imagePath,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            constraints: BoxConstraints(minWidth: _size.height * 0.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  this.title,
                  style: TextStyle(
                    fontSize: 26.0,
                    height: 1.5,
                    color: Color.fromRGBO(33, 45, 82, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                PageIndicator(activePage: activePage),
                SizedBox(
                  height: 50.0,
                ),
                PrimaryButton(
                  text: "أبــداء",
                  onPressed: () {
                    Helper.nextPage(context, LOGIN());
                  },
                )
              ],
            ),
          ),
          Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                TextButton(
                  onPressed: () {

                    Helper.nextPage(context, Register());
                  },
                  child: Text(
                    " انشاء حساب  ",

                  ),
                )
                ,
                Text(
                  "هل تمتلك حساب ؟",

                ),

              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
