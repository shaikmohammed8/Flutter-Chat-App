import 'package:chat_app/controller/authantication_controller.dart';

import 'package:chat_app/screens/SignUpScreen/widgets/confirm_password.dart';
import 'package:chat_app/screens/SignUpScreen/widgets/pickImage.dart';
import 'package:get/get.dart';

import './widgets/other_options.dart';
import './widgets/text_fields.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 70, bottom: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Sign up",
                style: Theme.of(context).textTheme.headline1,
              ),
              GestureDetector(
                onTap: () => Get.offNamed("/login"),
                child: Row(children: [
                  Text(
                    "LOGIN",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black),
                  ),
                  Icon(Icons.arrow_forward_ios)
                ]),
              ),
            ]),
            Text("Your Welcome",
                style: GoogleFonts.suravaram(
                  color: Theme.of(context).primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                )),
            Obx(
              () => Get.find<SignupController>().formPage.value == 0
                  ? TextFields()
                  : Get.find<SignupController>().formPage.value == 1
                      ? ConfirmPassword()
                      : PickImage(),
            ),
            SizedBox(
              height: 100,
            ),
            Center(child: LoginOptions()),
          ],
        ),
      ),
    ));
  }
}
