import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

CollectionReference messageRef =
    FirebaseFirestore.instance.collection("message");
CollectionReference userRef = FirebaseFirestore.instance.collection("users");
CollectionReference requestRef =
    FirebaseFirestore.instance.collection("friendrequest");

void displayDialog(String msg) {
  Get.dialog(
    CupertinoAlertDialog(
      title: new Text(
        "Error",
        style: TextStyle(color: Colors.red),
      ),
      content: new Text(msg, style: TextStyle(fontSize: 15)),
      actions: [
        CupertinoDialogAction(
            onPressed: () => Get.back(),
            isDefaultAction: true,
            child: Text("Close"))
      ],
    ),
  );
}

enum UserState { OFFLINE, ONLINE, AWAY }
