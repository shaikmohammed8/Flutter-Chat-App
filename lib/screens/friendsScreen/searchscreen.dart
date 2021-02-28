import 'package:chat_app/controller/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  var controller = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (val) {
            if (val.trim().isNotEmpty) {
              controller.getSearch(val);
            }
          },
          autofocus: true,
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  color: Colors.white38,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              hintText: "Search User"),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: controller.list.length,
                  itemBuilder: (ctx, index) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(controller.list[index].profileImage),
                        ),
                        title: Text(controller.list[index].name),
                        trailing: IconButton(
                            icon: Icon(
                              Icons.person_add_sharp,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              Get.snackbar("Sent", "Friend request sent",
                                  margin: EdgeInsets.only(
                                      left: 8, right: 8, bottom: 15),
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.black);

                              controller.sendRequest(
                                  rUid: controller.list[index].id,
                                  cUid: FirebaseAuth.instance.currentUser.uid,
                                  name: controller.list[index].name,
                                  photo: controller.list[index].profileImage);
                            }),
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
