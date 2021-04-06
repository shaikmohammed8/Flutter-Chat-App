import 'package:chat_app/models/usermodel.dart';
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
                "Friends Request",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Get.theme.primaryColor),
              ),
              Container(
                height: 140,
                child: StreamBuilder<List<QueryDocumentSnapshot>>(
                    stream: storage.getRequest(),
                    builder: (context, snapshot) => !snapshot.hasData
                        ? Container()
                        : snapshot.data.length == 0
                            ? Center(
                                child: Text(
                                "You have 0 Friend requests",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[300]),
                              ))
                            : ListView.builder(
                                itemCount: snapshot.data.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) => FirendRequest(
                                    snapshot.data[index]["photo"],
                                    snapshot.data[index]["name"],
                                    snapshot.data[index]["uid"]))),
              ),
              Text(
                "Friends",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Get.theme.primaryColor),
              ),
              StreamBuilder<List<QueryDocumentSnapshot>>(
                  stream: storage.getFriends(),
                  builder: (_, snapshot) => snapshot.hasData
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, index) => Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: firendsListTile(
                                        snapshot.data[index]['uid']),
                                  )))
                      : Container())
            ],
          ),
        ));
  }

  StreamBuilder firendsListTile(String uid) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FireStoreDB().getUser(uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var user = UserModel.fromDatabase(snapshot.data);
            return ListTile(
              title: Text(user.name,
                  style: TextStyle(
                    fontSize: 20,
                  )),
              leading: Container(
                width: 80,
                height: 80,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.profileImage),
                ),
              ),
            );
          } else
            return CircularProgressIndicator();
        });
  }
}
