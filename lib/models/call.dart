import 'package:cloud_firestore/cloud_firestore.dart';

class CallModel {
  String recivierId,
      reciviername,
      recivierPic,
      senderId,
      senderName,
      senderPic,
      date;
  bool hasDialed;
  String chanelName;

  CallModel(
      {this.hasDialed,
      this.recivierId,
      this.recivierPic,
      this.reciviername,
      this.date,
      this.chanelName,
      this.senderId,
      this.senderName,
      this.senderPic});

  Map<String, dynamic> toMap(CallModel call) {
    return {
      'date': call.date,
      'hasDialed': call.hasDialed,
      'recivierId': call.recivierId,
      'recivierPic': call.recivierPic,
      'reciviername': call.reciviername,
      'senderId': call.senderId,
      'senderName': call.senderName,
      'senderPic': call.senderPic,
      'chanelName': call.chanelName
    };
  }

  CallModel fromFirestore(DocumentSnapshot doc) {
    return CallModel(
        date: doc['date'],
        hasDialed: doc['hasDialed'],
        recivierId: doc['recivierId'],
        recivierPic: doc['recivierPic'],
        reciviername: doc['reciviername'],
        senderId: doc['senderId'],
        senderName: doc['senderName'],
        senderPic: doc['senderPic'],
        chanelName: doc['chanelName']);
  }
}
