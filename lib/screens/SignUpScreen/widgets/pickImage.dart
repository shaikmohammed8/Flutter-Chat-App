import 'dart:io';

import 'package:chat_app/controller/authantication_controller.dart';
import 'package:chat_app/screens/SignUpScreen/widgets/signup_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class PickImage extends StatelessWidget {
  var controller = Get.find<SignupController>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Please pick a Profile image ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                shape: BoxShape.circle),
            width: 120,
            height: 120,
            margin: const EdgeInsets.only(top: 10),
            child: Obx(() => controller.file.value == null
                ? CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 110,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: cameraButton(),
                        )
                      ],
                    ),
                  )
                : CircleAvatar(
                    backgroundImage:
                        FileImage(File(controller.file.value.path)),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: cameraButton()),
                  )),
          ),
          Obx(
            () => controller.file.value == null
                ? SignupButton(null, "Sign Up")
                : SignupButton(() {
                    controller.signup();
                  }, "Sign Up"),
          )
        ],
      ),
    );
  }

  Container cameraButton() {
    return Container(
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: IconButton(
          onPressed: () => displayDialog(),
          icon: Icon(
            Icons.camera_alt,
            size: 30,
            color: Colors.black,
          ),
        ));
  }

  void displayDialog() {
    Get.dialog(CupertinoAlertDialog(
      title: Text("Select"),
      content: Column(
        children: [
          TextButton.icon(
              onPressed: () {
                fromCamera();
                if (Get.isDialogOpen) {
                  Get.back();
                }
              },
              icon: Icon(Icons.camera_alt),
              label: Text("Camera")),
          TextButton.icon(
              onPressed: () {
                fromGallary();
                if (Get.isDialogOpen) {
                  Get.back();
                }
              },
              icon: Icon(Icons.image),
              label: Text("Gallery"))
        ],
      ),
    ));
  }

  void fromGallary() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      controller.file.value = image;
    }
  }

  void fromCamera() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      controller.file.value = image;
    }
  }
}
