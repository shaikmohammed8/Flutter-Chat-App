import 'package:chat_app/models/UserModel.dart';
import 'package:chat_app/services/firestroresevice.dart';
import 'package:chat_app/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FireStoreController extends GetxController {
  Rx<UserModel> user = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed("/home");
    } catch (e) {
      print(e);
    }
  }
}

class ChatScreenController extends GetxController {
  var textController = TextEditingController();
  var isWerting = false.obs;
  @override
  void onClose() {
    textController.clear();
    super.onClose();
  }

  void uploadMessage(String senderUid, String recieverUid, Map map) async {
    textController.clear();
    isWerting.value = false;
    await messageRef.doc(senderUid).collection(recieverUid).doc().set(map);
    await messageRef.doc(recieverUid).collection(senderUid).doc().set(map);
  }
}

class SearchController extends GetxController {
  RxList<UserModel> list = RxList();
  void getSearch(String search) {
    FireStoreDB().searchUsers(search).listen((event) {
      print("valur$event");
      if (event.isNotEmpty) {
        List<UserModel> mList = [];
        event.forEach((element) {
          mList.add(UserModel.fromDatabase(element));
        });
        list.assignAll(mList);
      }
    });
  }

  void sendRequest({String cUid, name, photo, rUid}) async {
    await requestRef.doc(rUid).collection("rquests").doc(cUid).set({
      "uid": cUid,
      "name": name,
      "photo": photo,
    });
  }
}
