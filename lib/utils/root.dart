import 'package:chat_app/controller/authantication_controller.dart';

import 'package:chat_app/utils/custombottomnavigation.dart';
import 'package:chat_app/screens/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      builder: (_) {
        if (Get.find<AuthController>().user.value?.uid != null) {
          // Get.find<AuthController>().dispose();
          print(Get.find<AuthController>().user.value?.uid);
          return CustomBottomNavigationBar();
        } else {
          //Get.find<AuthController>().dispose();
          return HomeScreen();
        }
      },
    );
  }
}
