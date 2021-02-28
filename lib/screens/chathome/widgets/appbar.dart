import 'package:chat_app/models/usermodel.dart';
import 'package:chat_app/services/firestroresevice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

AppBar customAppBar() {
  return AppBar(
    title: Text("Flutter chat", style: TextStyle(fontWeight: FontWeight.bold)),
    elevation: 0,
    actions: [
      Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: StreamBuilder<DocumentSnapshot>(
            stream:
                FireStoreDB().getUser(FirebaseAuth.instance.currentUser.uid),
            builder: (ctx, snapshot) {
              return snapshot.hasData
                  ? CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          UserModel.fromDatabase(snapshot.data).profileImage),
                    )
                  : Container();
            },
          )),
    ],
  );
}
