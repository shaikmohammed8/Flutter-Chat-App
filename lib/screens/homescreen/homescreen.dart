import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor),
      child: Scaffold(
        appBar: AppBar(
          backwardsCompatibility: false,
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
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
                  label: Text("Login"),
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.white, width: 1),
                      elevation: 10,
                      minimumSize: Size.copy(Size(150, 40)),
                      primary: Get.theme.primaryColor,
                      shadowColor: Colors.white),
                ),
                SizedBox(
                  height: 20,
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
                    style: TextStyle(color: Get.theme.primaryColor),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.copy(Size(150, 40)),
                      shadowColor: Colors.white,
                      elevation: 10,
                      primary: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
