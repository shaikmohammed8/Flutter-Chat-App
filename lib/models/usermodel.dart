import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  int state;
  String name, email, profileImage, id;
  UserModel({this.email, this.name, this.profileImage, this.id, this.state});

  UserModel.fromDatabase(DocumentSnapshot snapshot) {
    state = snapshot['state'];
    name = snapshot['name'];
    profileImage = snapshot['profileImage'];
    email = snapshot['email'];
    id = snapshot['id'];
  }

  Map<String, dynamic> toFirestore(
      String name, String profileImage, String email, String id, int state) {
    return {
      'name': name,
      'profileImage': profileImage,
      'email': email,
      'id': id,
      'state': state,
    };
  }
}
