import 'package:chat_app/screens/friendsScreen/fireindrequest.dart';
import 'package:chat_app/services/firestroresevice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirendsScreen extends StatelessWidget {
  var storage = FireStoreDB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.theme.primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Friends"),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Get.toNamed("/searchscreen");
                })
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                "Firends Request",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Get.theme.primaryColor),
              ),
              Container(
                height: 140,
                child: StreamBuilder<List<QueryDocumentSnapshot>>(
                    stream: storage.getRequest(),
                    builder: (context, snapshot) => snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index) => FirendRequest(
                                snapshot.data[index]["photo"],
                                snapshot.data[index]["name"]),
                          )
                        : Container()),
              ),
              Text(
                "Friends",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Get.theme.primaryColor),
              )
            ],
          ),
        ));
  }
}
