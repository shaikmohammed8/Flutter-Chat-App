import 'package:chat_app/controller/authantication_controller.dart';
import 'package:chat_app/controller/firestore.dart';
import 'package:chat_app/screens/LoginScreen/login.dart';
import 'package:chat_app/screens/SignUpScreen/signup.dart';
import 'package:chat_app/screens/chatcreen/chatscreen.dart';
import 'package:chat_app/screens/chathome/chathome.dart';
import 'package:chat_app/screens/friendsScreen/searchscreen.dart';
import 'package:chat_app/screens/homescreen/homescreen.dart';
import 'package:chat_app/utils/root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await GetStorage.init();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: "Cambria",
          // fontFamily: GoogleFonts.camba(fontWeight: FontWeight.w600).fontFamily,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.indigo,
          inputDecorationTheme: InputDecorationTheme(
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(15))),
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff00362d)),
              bodyText1: TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w600))),
      initialRoute: "/root",
      getPages: [
        GetPage(name: "/searchscreen", page: () => SearchScreen()),
        GetPage(
            name: "/chatscreen",
            page: () => ChatScreen(),
            binding: BindingsBuilder(() => Get.lazyPut<ChatScreenController>(
                () => ChatScreenController()))),
        GetPage(
            name: "/root",
            page: () => Root(),
            binding: BindingsBuilder(
                () => Get.lazyPut<AuthController>(() => AuthController()))),
        GetPage(
            name: '/chathome',
            page: () => ChatHomeScreen(),
            binding: BindingsBuilder(() =>
                Get.lazyPut<FireStoreController>(() => FireStoreController()))),
        GetPage(name: "/home", page: () => HomeScreen()),
        GetPage(
            name: "/login",
            page: () => LoginScreen(),
            binding: BindingsBuilder(
                () => Get.lazyPut<LoginController>(() => LoginController()))),
        GetPage(
            name: "/signup",
            page: () => SignupScreen(),
            binding: BindingsBuilder(
                () => Get.lazyPut<SignupController>(() => SignupController())))
      ],
    );
  }
}
