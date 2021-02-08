import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          splashColor: Colors.white,
          onTap: () {
            Get.snackbar("title", "message");
          },
          child: Container(
            height: 50,
            width: 150,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8, right: 35, left: 35),
              child: Center(
                child: Text(
                  "Login",
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
        )
      ],
    );
  }
}
