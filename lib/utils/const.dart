import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

CollectionReference callRef = FirebaseFirestore.instance.collection("Call");
CollectionReference friendRef = FirebaseFirestore.instance.collection("Friend");
CollectionReference messageRef =
    FirebaseFirestore.instance.collection("message");
CollectionReference userRef = FirebaseFirestore.instance.collection("users");
CollectionReference requestRef =
    FirebaseFirestore.instance.collection("friendrequest");
CollectionReference callLogtRef =
    FirebaseFirestore.instance.collection("callLogs");

const APP_ID = '11e1c25d02e34aefbddb6f5ccb8c3f79';
const Token =
    '006361640fb6bc74e1ab2c090dc1aefedf5IAD3GZVbp2JOHg6z8VqV9894nUuXkwv+ekALxwudFZYL+tQMZ8MAAAAAEAAEa9nraIM/YAEAAQBmgz9g';

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
