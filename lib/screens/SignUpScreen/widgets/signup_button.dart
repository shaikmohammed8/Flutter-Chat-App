import 'package:chat_app/controller/authantication_controller.dart';
import 'package:chat_app/screens/SignUpScreen/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupButton extends StatelessWidget {
  final Function onClick;
  final String text;

  SignupButton(this.onClick, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          goBack(context),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: onClick,
            child: Center(
              child: Container(
                height: 50,
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 35, left: 35),
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.teal[100],
                          spreadRadius: 1,
                          offset: Offset(5, 5),
                          blurRadius: 4)
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget goBack(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          Get.find<SignupController>().formPage.value = 0;
          TextFields.name = Get.find<SignupController>().name.value;
          TextFields.email = Get.find<SignupController>().email.value;
        },
        child: Get.find<SignupController>().formPage.value == 0
            ? Container()
            : Row(children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.red,
                ),
                Text(
                  "Go back",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
      ),
    );
  }
}
