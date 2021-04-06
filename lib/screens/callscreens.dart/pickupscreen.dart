import 'dart:async';

import 'package:chat_app/screens/callscreens.dart/VideoCall.dart';
import 'package:chat_app/services/firestroresevice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickUpScreen extends StatelessWidget {
  Map<String, dynamic> args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    var timer = Timer(Duration(seconds: 9), () {
      Get.back();
      FireStoreDB()
          .deleteCall(FirebaseAuth.instance.currentUser.uid, args['uid']);
    });
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Get.theme.primaryColor.withOpacity(0.8),
              Get.theme.primaryColor
            ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Incomming.....",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                height: 200,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(args['photo']),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                args['name'],
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.red,
                      child: Icon(Icons.call_end),
                      onPressed: () {
                        timer.cancel();
                        FireStoreDB().deleteCall(
                            FirebaseAuth.instance.currentUser.uid, args['uid']);
                        Get.back();
                      }),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.green,
                      child: Icon(Icons.call),
                      onPressed: () {
                        timer.cancel();
                        Get.off(() => VideoCall(
                            channelName: args['chanelName'], uid: args['uid']));
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
