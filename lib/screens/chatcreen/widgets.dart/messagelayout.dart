import 'package:chat_app/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MessageLayout extends StatelessWidget {
  Message message;
  MessageLayout(this.message);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
      constraints: BoxConstraints(maxWidth: Get.mediaQuery.size.width * 0.6),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(3, 3))
          ],
          borderRadius: BorderRadius.circular(10),
          color: Get.theme.primaryColor),
      child: Text(
        message.message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
