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
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        isSucces = true;
        //  storage.write('email', email);
      });
    } on FirebaseAuthException catch (e) {
      displayDialog(e.code);
      isSucces = false;
    }
    return isSucces;
  }

  Future<bool> signUp(String email, String password) async {
    print("sssss" + password);
    bool succes;

    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => succes = true);
    } on FirebaseAuthException catch (e) {
      displayDialog(e.code);
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

  void displayDialog(String msg) {
    print(msg);
    Get.dialog(
      CupertinoAlertDialog(
        title: new Text(
          "Error",
          style: TextStyle(color: Colors.red),
        ),
        content: new Text(msg, style: TextStyle(fontSize: 15)),
        actions: [
          CupertinoDialogAction(
              onPressed: () => Get.back(),
              isDefaultAction: true,
              child: Text("Close"))
        ],
      ),
    );
  }
}
