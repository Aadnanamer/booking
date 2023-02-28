import 'package:flutter/material.dart';
import '/widgets/input_widget.dart';

class LoginrForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late var userController = " ";
    late var pwdController = " ";
    return Container(
        child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(

            "الايميل",
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 5.0,
          ),
          InputWidget(obscureText: false, suffixIcon: Icons.person,hintText: " ", onPressed: () {  }, onChanged: (String value) { userController=value;
          },),
          SizedBox(height: 10.0),
          Text(
            "كلمة المرور",
            textAlign: TextAlign.right,

          ),
          SizedBox(
            height: 5.0,
          ),
          InputWidget(obscureText: true, suffixIcon: Icons.password,hintText: " ",onPressed: () {  },onChanged: (String value) {pwdController=value;},),
          SizedBox(
            height: 10.0,
          ),
             ],
      ),
    ));
  }
}
