import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final date, senderId, reciverId, message, type;

  String image;

  Message({this.senderId, this.reciverId, this.date, this.message, this.type});
  Message.image(
      {this.senderId,
      this.reciverId,
      this.date,
      this.message,
      this.image,
      this.type});

  Map<String, dynamic> toMap() {
    return {
      "senderId": this.senderId,
      "reciverId": this.reciverId,
      "message": this.message,
      "type": this.type,
      "date": this.date
    };
  }

  Message fromMap(DocumentSnapshot doc) {
    return Message(
        senderId: doc['senderId'],
        reciverId: doc['reciverId'],
        message: doc['message'],
        type: doc['type'],
        date: doc['date']);
  }
  // Map<String, dynamic> toMapImgae() {
  //   return {
  //     "senderId": this.senderId,
  //     "reciverId": this.reciverId,
  //     "message": this.message,
  //     "type": this.type,
  //     "date": this.date,
  //     "image": this.image
  //   };
}
