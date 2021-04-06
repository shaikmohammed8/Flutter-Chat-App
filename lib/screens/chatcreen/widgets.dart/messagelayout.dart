import 'package:chat_app/models/message.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MessageLayout extends StatelessWidget {
  Message message;
  MessageLayout(this.message);
  @override
  Widget build(BuildContext context) {
    return message.senderId == FirebaseAuth.instance.currentUser.uid
        ? cUserContainer()
        : rUserContainer();
  }

  Container cUserContainer() {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
      constraints: BoxConstraints(maxWidth: Get.mediaQuery.size.width * 0.6),
      decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(3, 3))
          // ],
          borderRadius: BorderRadius.circular(10),
          color: Get.theme.primaryColor),
      child: Container(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          alignment: WrapAlignment.start,
          children: [
            Text(
              message.message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              maxLines: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              message.date == null
                  ? DateFormat("h:mma").format(DateTime.now()).toString()
                  : DateFormat("h:mma")
                      .format(DateTime.fromMillisecondsSinceEpoch(
                          message.date.millisecondsSinceEpoch))
                      .toString(),
              style: TextStyle(fontSize: 10, color: Colors.grey[200]),
            ),
          ],
        ),
      ),
    );
  }

  rUserContainer() {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
      constraints: BoxConstraints(maxWidth: Get.mediaQuery.size.width * 0.6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
      child: Wrap(
        verticalDirection: VerticalDirection.up,
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.start,
        children: [
          Text(
            message.date == null
                ? DateFormat("h:mma").format(DateTime.now()).toString()
                : DateFormat("h:mma")
                    .format(DateTime.fromMillisecondsSinceEpoch(
                        message.date.millisecondsSinceEpoch))
                    .toString(),
            style: TextStyle(fontSize: 10),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            message.message,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            maxLines: 20,
          ),
        ],
      ),
    );
  }
}
