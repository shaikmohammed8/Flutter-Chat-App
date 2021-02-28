import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/controller/authantication_controller.dart';

class ForgetPassword extends StatelessWidget {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              }),
          SizedBox(
            height: 30,
          ),
          Text(
            "Forget Password",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 44,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Please make sure that you have Entered conrrect email",
              style: Theme.of(context).textTheme.bodyText1),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "Email",
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.disabledBorder,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(15)))),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: onClick,
              child: Text(
                "Send",
                style: TextStyle(fontSize: 24),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                  minimumSize: Size.copy(Size(150, 50)),
                  shadowColor: Theme.of(context).primaryColor,
                  elevation: 10,
                  primary: Theme.of(context).primaryColor),
            ),
          )
        ]),
      ),
    );
  }

  void onClick() {
    Get.find<LoginController>().forgerPassword(controller.text);
  }
}
