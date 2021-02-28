import 'package:chat_app/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth;
  // final storage = GetStorage();

  AuthenticationService(this.firebaseAuth);

  Future<bool> login(String email, String password) async {
    var isSucces = false;
    showProgresdialog();
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.back();
        isSucces = true;
        //  storage.write('email', email);
      });
    } on FirebaseAuthException catch (e) {
      Get.back();
      displayDialog(e.code.capitalize.replaceAll("-", " "));
      isSucces = false;
    }
    return isSucces;
  }

  Future<bool> signUp(String email, String password) async {
    bool succes;

    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => succes = true);
    } on FirebaseAuthException catch (e) {
      displayDialog(e.code.replaceAll("-", " "));
    }
    return succes;
  }

  void forget(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      displayDialog(e.message);
    }
  }

  void showProgresdialog() {
    Get.dialog(
        CupertinoAlertDialog(
            title: new Text(
              "Please wait",
              style: TextStyle(color: Colors.black),
            ),
            content: LinearProgressIndicator()),
        barrierDismissible: false);
  }
}
