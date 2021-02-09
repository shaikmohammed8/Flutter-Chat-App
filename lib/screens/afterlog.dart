import 'package:chat_app/controller/authantication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AfterLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: TextButton(
            child: Text("Log out"),
            onPressed: () {
              Get.find<AuthController>().logout();
            },
          ),
        )
      ],
    ));
  }
}
