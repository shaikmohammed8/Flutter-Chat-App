import 'package:chat_app/controller/authantication_controller.dart';
import 'package:chat_app/screens/afterlog.dart';
import 'package:chat_app/screens/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      builder: (_) {
        if (Get.find<AuthController>().user.value?.uid != null) {
          //Get.find<AuthController>().dispose();
          return AfterLog();
        } else {
          //Get.find<AuthController>().dispose();
          return HomeScreen();
        }
      },
    );
  }
}
