import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth;

  AuthenticationService(this.firebaseAuth);

  Future<bool> login(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("title", e.code);
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    print("sssss" + password);
    bool succes;
    ;
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => succes = true);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("title", e.code);
      succes = false;
    }
    return succes;
  }
}
