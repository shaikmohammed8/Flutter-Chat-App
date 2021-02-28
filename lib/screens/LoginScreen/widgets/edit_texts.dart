import 'package:chat_app/controller/authantication_controller.dart';
import 'package:chat_app/screens/LoginScreen/widgets/login_button.dart';
import 'package:chat_app/screens/utilsscreen/forgetPasswordScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFields extends StatefulWidget {
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Form(
        key: TextFields.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                validator: (val) {
                  if (!GetUtils.isEmail(val)) {
                    return "please enter a valid email";
                  } else
                    return null;
                },
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "Email",
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.disabledBorder,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)))),
            SizedBox(
              height: 30,
            ),
            TextFormField(
                validator: (val) {
                  if (val.length < 8) {
                    return "please enter correct password";
                  } else
                    return null;
                },
                controller: passwordController,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
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
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(15)))),
            SizedBox(
              height: 20,
            ),
            TextButton(
              child: Text("Forget Password?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black)),
              onPressed: () {
                Get.to(ForgetPassword());
              },
            ),
            SizedBox(
              height: 15,
            ),
            Center(child: LoginButton(chekValidation))
          ],
        ),
      ),
    );
  }

  void chekValidation() {
    if (TextFields.formKey.currentState.validate()) {
      submit();
    }
  }

  void submit() {
    Get.find<LoginController>()
        .login(emailController.text, passwordController.text);
  }
}
