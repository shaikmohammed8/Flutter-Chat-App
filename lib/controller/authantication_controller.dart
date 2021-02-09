import 'package:chat_app/screens/afterlog.dart';
import 'package:chat_app/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  var authentication = AuthenticationService(_auth);
  var formPage = 0.obs;

  var email = "".obs;
  var name = "".obs;
  var password = "".obs;
  var confirmPassword = "".obs;

  void signup() async {
    var isTrue = await authentication.signUp(email.value, password.value);
    print("ssss$isTrue");
    if (isTrue == true) {
      Get.offAll(AfterLog());
    }
  }
}

class LoginController extends GetxController {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  var authentication = AuthenticationService(_auth);

  void login(String email, String password) async {
    var isSucces = await authentication.login(email, password);
    print(isSucces);
    if (isSucces == true) {
      Get.offAll(AfterLog());
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
    super.onInit();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
