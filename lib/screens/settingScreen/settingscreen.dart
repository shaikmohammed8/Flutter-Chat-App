import 'package:chat_app/controller/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  var controller = Get.find<FireStoreController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Setting",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Get.theme.primaryColor,
      body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, border: Border.all(width: 2)),
                width: 200,
                height: 200,
                child: Obx(
                  () => CircleAvatar(
                    backgroundImage: NetworkImage(
                      controller.currentUser.value.profileImage,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                controller.currentUser.value.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                controller.currentUser.value.email,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text("Log out"),
                onPressed: () {
                  controller.logout();
                },
              ),
            ],
          )),
    );
  }
}
