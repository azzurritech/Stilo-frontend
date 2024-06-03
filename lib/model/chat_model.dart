import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String message;
  final String sendByEmail;

  final DateTime timeStamp;
  final String type;
  ChatModel(
      {required this.message,
      required this.sendByEmail,
      required this.timeStamp,
      required this.type});
  Map<String, dynamic> toFireStore() {
    return {
      "message": message,
      "sendBy": sendByEmail,
      "timeStamp": timeStamp,
      "type": type,
    };
  }

  factory ChatModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    var data = snapshot.data();
    DateTime date = (data?['timeStamp'] as Timestamp).toDate();
    return ChatModel(
      message: data?['message'] ?? "",
      sendByEmail: data?["sendBy"] ?? "",
      timeStamp: date,
      type: data?['type'] ?? "",
    );
  }
}
