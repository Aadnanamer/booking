import 'package:flutter/material.dart';
import '/widgets/input_widget.dart';
import 'package:http/http.dart'as http;
class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          InputWidget(obscureText: false, suffixIcon: Icons.person,hintText: " ",onPressed: () {  },onChanged: (String value) {  }, ),
          SizedBox(height: 10.0),
          Text(
            "كلمة المرور",
            textAlign: TextAlign.right,

          ),
          SizedBox(
            height: 5.0,
          ),
          InputWidget(obscureText: true, suffixIcon: Icons.password,hintText: " ",
            onPressed: () {
          }, onChanged: (String value) {  },),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "تاكيد كلمة المرور",
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 5.0,
          ),
          InputWidget(obscureText: true, suffixIcon: Icons.password,hintText: " ",onPressed: () {  },onChanged: (String value) {  }, ),
        ],
      ),
    ));
  }
}
