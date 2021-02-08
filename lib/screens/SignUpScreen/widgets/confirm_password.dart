import 'package:chat_app/controller/authantication_controller.dart';
import 'package:chat_app/screens/SignUpScreen/widgets/signup_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmPassword extends StatefulWidget {
  static var formKey = GlobalKey<FormState>();

  @override
  _ConfirmPasswordState createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  var password = TextEditingController();

  var confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Form(
        key: ConfirmPassword.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                validator: (val) {
                  if (val.length < 8)
                    return "Password should be grater than 8 ";
                  else
                    return null;
                },
                controller: password,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Password",
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.disabledBorder,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)))),
            SizedBox(
              height: 35,
            ),
            TextFormField(
                validator: (val) {
                  if (val != password.text)
                    return "Password does'nt match";
                  else
                    return null;
                },
                controller: confirmPassword,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Confirm Password",
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.disabledBorder,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(15)))),
            SizedBox(
              height: 25,
            ),
            SignupButton(() {
              if (ConfirmPassword.formKey.currentState.validate()) {
                Get.find<SignupController>().password.value = password.text;
                Get.find<SignupController>().signup();
              } else
                return;
            }, "Sign up")
          ],
        ),
      ),
    );
  }
}
