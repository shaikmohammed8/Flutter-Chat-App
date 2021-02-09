import 'package:chat_app/controller/authantication_controller.dart';
import 'package:chat_app/screens/SignUpScreen/widgets/signup_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFields extends StatefulWidget {
  static String name;
  static String email;
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  var nameController = TextEditingController(text: TextFields.name);
  var emailController = TextEditingController(text: TextFields.email);

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
                  if (!GetUtils.isUsername(val)) {
                    return "please enter a valid name";
                  } else
                    return null;
                },
                controller: nameController,
                keyboardType: TextInputType.name,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Name",
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.disabledBorder,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)))),
            SizedBox(
              height: 35,
            ),
            TextFormField(
                validator: (val) {
                  if (!GetUtils.isEmail(val)) {
                    return "please enter a valid Email";
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
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(15)))),
            SizedBox(
              height: 25,
            ),
            SignupButton(chekValidation, "Next")
          ],
        ),
      ),
    );
  }

  void chekValidation() {
    if (TextFields.formKey.currentState.validate()) {
      Get.find<SignupController>().formPage.value = 1;
      submit();
    } else
      Get.snackbar('title', "null");
  }

  void submit() {
    Get.find<SignupController>().name.value = nameController.text;
    Get.find<SignupController>().email.value = emailController.text;
  }
}
