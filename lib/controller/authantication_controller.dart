import 'package:chat_app/screens/afterlog.dart';
import 'package:chat_app/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static FirebaseAuth auth = FirebaseAuth.instance;
  var authentication = AuthenticationService(auth);
  var formPage = 0.obs;
  var emailError = false.obs;
  var isSignup = false.obs;

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

  void show() {
    print("sdf" + name.value);
    print("asdf" + email.value);
    print(password.value);
    print(confirmPassword.value);
  }

  void chekNameAndEmail() {
    if (!GetUtils.isEmail(email.value) || name.value.length < 2) {
      emailError.value = true;
    } else
      emailError.value = false;
  }
}

class AuthController {
  // Rx<FirebaseUser> firebaseuser = Rx<FirebaseUser>();
}
