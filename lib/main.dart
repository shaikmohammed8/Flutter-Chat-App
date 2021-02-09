import 'package:chat_app/controller/authantication_controller.dart';
import 'package:chat_app/screens/LoginScreen/login.dart';
import 'package:chat_app/screens/SignUpScreen/signup.dart';
import 'package:chat_app/screens/afterlog.dart';
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
  // final storage = GetStorage();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color(0xff00362d),
          inputDecorationTheme: InputDecorationTheme(
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(15))),
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff00362d)),
              bodyText1: TextStyle(fontSize: 15, color: Colors.red))),
      initialRoute: "/root",
      getPages: [
        GetPage(
            name: "/root",
            page: () => Root(),
            binding: BindingsBuilder(
                () => Get.lazyPut<AuthController>(() => AuthController()))),
        GetPage(name: '/afterlog', page: () => AfterLog()),
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
