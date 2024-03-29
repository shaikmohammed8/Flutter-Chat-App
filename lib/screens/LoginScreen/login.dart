import 'package:chat_app/screens/LoginScreen/widgets/login_options.dart';

import 'package:get/get.dart';
import './widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/edit_texts.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 70, bottom: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.headline1,
              ),
              GestureDetector(
                onTap: () => Get.offNamed("/signup"),
                child: Row(children: [
                  Text(
                    "SIGNUP",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Icon(Icons.arrow_forward_ios)
                ]),
              ),
            ]),
            Text("Welcom Back",
                style: GoogleFonts.suravaram(
                    color: Theme.of(context).primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic)),
            TextFields(),
            Center(child: LoginButton()),
            SizedBox(
              height: 100,
            ),
            Center(child: LoginOptions())
          ],
        ),
      ),
    ));
  }
}
