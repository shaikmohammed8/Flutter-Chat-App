import 'package:chat_app/controller/firestore.dart';
import 'package:chat_app/models/usermodel.dart';
import 'package:chat_app/screens/chathome/widgets/appbar.dart';
import 'package:chat_app/services/firestroresevice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ChatHomeScreen extends StatelessWidget {
  var firestore = FireStoreDB();
  var controller = Get.put(FireStoreController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      backgroundColor: Get.theme.primaryColor,
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.white),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              child: StreamBuilder<List<QueryDocumentSnapshot>>(
                  stream: firestore.getUsers(),
                  builder: (ctx, snapshot) => snapshot.hasData
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                onTap: () =>
                                    Get.toNamed("/chatscreen", arguments: {
                                  "name": UserModel.fromDatabase(
                                          snapshot.data[index])
                                      .name,
                                  "uid": UserModel.fromDatabase(
                                          snapshot.data[index])
                                      .id,
                                  "photo": UserModel.fromDatabase(
                                          snapshot.data[index])
                                      .profileImage,
                                  "state": UserModel.fromDatabase(
                                          snapshot.data[index])
                                      .state
                                }),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      UserModel.fromDatabase(
                                              snapshot.data[index])
                                          .profileImage),
                                ),
                                subtitle: subtitleBuilder(snapshot, index),
                                title: Text(
                                  UserModel.fromDatabase(snapshot.data[index])
                                      .name,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                          child: CircularProgressIndicator(),
                        ))),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<QueryDocumentSnapshot> subtitleBuilder(
      AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot, int indexx) {
    return StreamBuilder(
        stream: firestore.fetchLastMessageBetween(
            senderId: FirebaseAuth.instance.currentUser.uid,
            receiverId: UserModel.fromDatabase(snapshot.data[indexx]).id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshots) =>
            snapshots.hasData
                ? Text(
                    snapshots.data['message'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : Text(""));
  }
}
