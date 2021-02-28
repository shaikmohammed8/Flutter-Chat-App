import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.amber, Get.theme.primaryColor])),
        width: Get.mediaQuery.size.width,
        height: Get.mediaQuery.size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Get.toNamed("/login");
                },
                label: Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    minimumSize: Size.copy(Size(200, 50)),
                    primary: Get.theme.primaryColor,
                    shadowColor: Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                icon: Icon(
                  Icons.login,
                  color: Get.theme.primaryColor,
                ),
                onPressed: () {
                  Get.toNamed("/signup");
                },
                label: Text(
                  "Signup",
                  style: TextStyle(color: Get.theme.primaryColor, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    minimumSize: Size.copy(Size(200, 50)),
                    shadowColor: Colors.white,
                    elevation: 15,
                    primary: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
