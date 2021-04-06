import 'dart:math';

import 'package:chat_app/models/call.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/usermodel.dart';
import 'package:chat_app/screens/callscreens.dart/VideoCall.dart';
import 'package:chat_app/screens/chatcreen/widgets.dart/messagelayout.dart';
import 'package:chat_app/services/firestroresevice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/controller/firestore.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  var userController = Get.find<FireStoreController>();
  var firestor = FireStoreDB();
  var controller = Get.find<ChatScreenController>();

  @override
  Widget build(BuildContext context) {
    var chanelName = Random().nextInt(5000);
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    print(args);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              args['name'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FireStoreDB().getUser(args['uid']),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? buildText(UserModel.fromDatabase(snapshot.data).state)
                      : Text("");
                })
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.videocam),
              onPressed: () {
                handelepermission();
                Get.to(() => VideoCall(
                      uid: args['uid'],
                      channelName: chanelName.toString(),
                      incomming: false,
                    ));
                buildMakeCall(args, chanelName.toString());
              })
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assest/images/indigo.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            StreamBuilder<List<QueryDocumentSnapshot>>(
                stream: firestor.getMessages(
                    FirebaseAuth.instance.currentUser.uid, args["uid"]),
                builder: (ctx, snapshot) => snapshot.hasData
                    ? Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            return Wrap(
                                alignment: Message()
                                            .fromMap(snapshot.data[index])
                                            .senderId ==
                                        FirebaseAuth.instance.currentUser.uid
                                    ? WrapAlignment.end
                                    : WrapAlignment.start,
                                children: [
                                  MessageLayout(
                                    Message().fromMap(snapshot.data[index]),
                                  ),
                                ]);
                          },
                        ),
                      )
                    : Expanded(child: Container())),
            Container(
                color: Colors.black.withOpacity(0.4),
                padding: EdgeInsets.all(5),
                child: Row(children: [
                  IconButton(
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                  Container(
                    width: Get.size.width * 0.7,
                    child: CupertinoTextField(
                      onChanged: (val) {
                        if (val.trim() == "" || val.isEmpty)
                          controller.isWerting.value = false;
                        else
                          controller.isWerting.value = true;
                      },
                      controller: controller.textController,
                      cursorColor: Colors.black,
                      placeholder: "Type a message",
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[300].withOpacity(0.5)),
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      suffix: IconButton(
                        icon: Icon(
                          Icons.attach_file_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 50,
                    width: 50,
                    child: Obx(() => controller.isWerting.value
                        ? buildFloatingActionButton(Icons.send, () {
                            controller.uploadMessage(
                                FirebaseAuth.instance.currentUser.uid,
                                args["uid"],
                                Message(
                                        senderId: FirebaseAuth
                                            .instance.currentUser.uid,
                                        reciverId: args['uid'],
                                        date: FieldValue.serverTimestamp(),
                                        message: controller.textController.text,
                                        type: "text")
                                    .toMap());
                          })
                        : buildFloatingActionButton(Icons.camera_alt, () {})),
                  )
                ]))
          ],
        ),
      ),
    );
  }

  void buildMakeCall(Map<String, dynamic> args, String channelname) {
    return controller.makeCall(CallModel(
        senderId: FirebaseAuth.instance.currentUser.uid,
        senderName: userController.currentUser.value.name,
        senderPic: userController.currentUser.value.profileImage,
        reciviername: args['name'],
        recivierId: args['uid'],
        recivierPic: args['photo'],
        chanelName: channelname,
        date: DateTime.now().toString()));
  }

  Text buildText(int state) {
    switch (state) {
      case 1:
        return Text(
          "Online",
          style: TextStyle(color: Colors.green, fontSize: 13),
        );
        break;
      case 2:
        return Text(
          "Offline",
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),
        );
        break;
      case 3:
        return Text(
          "Away",
          style: TextStyle(color: Colors.orange, fontSize: 13),
        );
        break;
      default:
        return Text("");
    }
  }

  FloatingActionButton buildFloatingActionButton(
      IconData icoc, Function onClick) {
    return FloatingActionButton(
        backgroundColor: Get.theme.primaryColor,
        child: Icon(icoc),
        onPressed: onClick);
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  void handelepermission() async {
    await _handleCameraAndMic(Permission.microphone);
    await _handleCameraAndMic(Permission.camera);
  }
}
