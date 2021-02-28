import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirendRequest extends StatelessWidget {
  final image, name;
  FirendRequest(this.image, this.name);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: Get.theme.primaryColor)),
          height: 70,
          width: 70,
          child: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
        ),
        Text(name),
        Row(children: [
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.check_circle_sharp,
              color: Colors.blue,
            ),
            onPressed: () {},
          )
        ])
      ],
    );
  }
}
