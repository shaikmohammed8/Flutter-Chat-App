import 'package:chat_app/models/UserModel.dart';
import 'package:chat_app/models/call.dart';
import 'package:chat_app/screens/callscreens.dart/pickupscreen.dart';
import 'package:chat_app/services/firestroresevice.dart';
import 'package:chat_app/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FireStoreController extends GetxController {
  Rx<UserModel> currentUser = UserModel().obs;

  @override
  void onInit() {
    observeCall();
    getCurrentUser();
    super.onInit();
  }

  void observeCall() {
    var call = callRef.doc(FirebaseAuth.instance.currentUser.uid).snapshots();
    call.listen((event) {
      if (event.exists) {
        if (!event['hasDialed']) {
          Get.to(() => PickUpScreen(), arguments: {
            'chanelName': CallModel().fromFirestore(event).chanelName,
            'photo': CallModel().fromFirestore(event).senderPic,
            'name': CallModel().fromFirestore(event).senderName,
            'uid': CallModel().fromFirestore(event).senderId
          });
        }
      }
    });
  }

  void getCurrentUser() {
    FireStoreDB()
        .getUser(FirebaseAuth.instance.currentUser.uid)
        .listen((event) {
      currentUser.value = UserModel.fromDatabase(event);
    });
  }

  void logout() async {
    try {
      FireStoreDB().updateState(
          FirebaseAuth.instance.currentUser.uid, UserState.OFFLINE);

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

  void makeCall(CallModel call) async {
    try {
      call.hasDialed = true;
      Map<String, dynamic> hasDialed = call.toMap(call);
      call.hasDialed = false;
      Map<String, dynamic> hasNotDialed = call.toMap(call);

      await callRef.doc(call.senderId).set(hasDialed);
      await callRef.doc(call.recivierId).set(hasNotDialed);
    } catch (e) {
      print(e);
    }
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
