import 'package:chat_app/services/authentication.dart';
import 'package:chat_app/services/firestroresevice.dart';
import 'package:chat_app/utils/custombottomnavigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupController extends GetxController {
  Rx<PickedFile> file = Rx<PickedFile>();
  static FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController passwordController = TextEditingController();
  TextEditingController cnfPasswordController = TextEditingController();
  var authentication = AuthenticationService(_auth);
  var formPage = 0.obs;

  var email = "".obs;
  var name = "".obs;
  var password = "".obs;
  var confirmPassword = "".obs;

  void signup() async {
    var isTrue =
        await authentication.signUp(email.value, passwordController.text);
    if (isTrue == true) {
      await FireStoreDB().addUser(
          _auth.currentUser.uid, name.value, email.value, file.value.path);
      Get.offAllNamed("/chathome");
    }
  }

  @override
  void onClose() {
    passwordController.clear();
    cnfPasswordController.clear();
    super.onClose();
  }
}

class LoginController extends GetxController {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  var authentication = AuthenticationService(_auth);

  void login(String email, String password) async {
    var isSucces = await authentication.login(email, password);
    print(isSucces);
    if (isSucces == true) {
      Get.offAll(() => CustomBottomNavigationBar());
      //  Get.offAll(AfterLog());
    }
  }

  void forgerPassword(String email) {
    authentication.forget(email);
  }
}

class AuthController extends GetxController {
  Rx<User> user = Rx<User>();

  @override
  void onInit() {
    user.bindStream(FirebaseAuth.instance.authStateChanges());
    print("asdf" + user.value.toString());
    super.onInit();
  }
}
