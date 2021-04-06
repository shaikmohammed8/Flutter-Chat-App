import 'dart:io';
import 'package:chat_app/models/UserModel.dart';
import 'package:chat_app/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FireStoreDB {
  final storage = FirebaseStorage.instance;

  Future<void> addUser(
      String uid, String name, String email, String filename) async {
    try {
      return await userRef.doc(uid).set(UserModel()
          .toFirestore(name, await upLoadImage(filename), email, uid, 2));
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Stream<DocumentSnapshot> getUser(String uid) {
    try {
      var _doc = userRef.doc(uid).snapshots();
      return _doc;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> upLoadImage(String fileName) async {
    String filename = fileName;
    var refrence = storage.ref().child("photo/$filename");
    var uploadFile = await refrence.putFile(File(filename));
    var url = uploadFile.ref.getDownloadURL();
    return url;
  }

  Stream<List<QueryDocumentSnapshot>> getUsers() =>
      userRef.snapshots().map((event) => event.docs);

  Stream<List<QueryDocumentSnapshot>> searchUsers(String name) => userRef
      .where("name", isGreaterThanOrEqualTo: name)
      .snapshots()
      .map((event) => event.docs);

  Stream<List<QueryDocumentSnapshot>> getMessages(String sUid, String rUid) =>
      messageRef
          .doc(sUid)
          .collection(rUid)
          .orderBy("date", descending: true)
          .snapshots()
          .map((event) => event.docs);

  Stream<List<QueryDocumentSnapshot>> getRequest() => requestRef
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("rquests")
      .snapshots()
      .map((event) => event.docs);

  Stream<QueryDocumentSnapshot> fetchLastMessageBetween({
    @required String senderId,
    @required String receiverId,
  }) =>
      messageRef
          .doc(senderId)
          .collection(receiverId)
          .orderBy("date")
          .snapshots()
          .map((event) => event.docs.last);

  void updateState(String uid, UserState state) async {
    switch (state) {
      case UserState.ONLINE:
        await userRef.doc(uid).update({"state": 1});
        break;
      case UserState.OFFLINE:
        await userRef.doc(uid).update({"state": 2});
        break;
      case UserState.AWAY:
        await userRef.doc(uid).update({"state": 3});
        break;
      default:
        await userRef.doc(uid).update({"state": 3});
        break;
    }
  }

  void deleteCall(String cUid, String rUid) async {
    await callRef.doc(cUid).delete();
    await callRef.doc(rUid).delete();
  }

  Stream<List<QueryDocumentSnapshot>> getFriends() => friendRef
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("friends")
      .snapshots()
      .map((event) => event.docs);
}
