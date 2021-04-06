import 'package:chat_app/controller/controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirendRequest extends StatelessWidget {
  var controller = Get.put(FriendController());
  final image, name, uid;
  FirendRequest(this.image, this.name, this.uid);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: Get.theme.primaryColor)),
          height: 70,
          width: 70,
          child: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
        ),
        Text(name),
        Row(children: [
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            onPressed: () {
              controller.deleteRequest(
                  FirebaseAuth.instance.currentUser.uid, uid);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.check_circle_sharp,
              color: Colors.blue,
            ),
            onPressed: () {
              controller.addFreind(
                FirebaseAuth.instance.currentUser.uid,
                uid,
                name,
                image,
              );
            },
          )
        ])
      ],
    );
  }
}
