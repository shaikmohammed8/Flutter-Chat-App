import 'package:chat_app/utils/const.dart';
import 'package:get/get.dart';

class FriendController extends GetxController {
  void deleteRequest(String cUid, String rUid) async {
    await requestRef.doc(cUid).collection("rquests").doc(rUid).delete();
  }

  void addFreind(cUid, rUid, name, image) async {
    await friendRef
        .doc(cUid)
        .collection("friends")
        .doc(rUid)
        .set({"uid": rUid}).then((value) => deleteRequest(cUid, rUid));
    await friendRef
        .doc(rUid)
        .collection("friends")
        .doc(cUid)
        .set({"uid": cUid}).then((value) => deleteRequest(cUid, rUid));
  }
}
