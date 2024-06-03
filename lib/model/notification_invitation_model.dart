import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String type;
  final String name;
  final String email;

  final String profilePhoto;
  final DateTime time;
  final Map<String,dynamic>?payLoad;
  NotificationModel( {
    required this.profilePhoto,
    required this.name,
    required this.email,
    required this.type,
    required this.time,
    this.payLoad,
  });

  Map<String, dynamic> toFireStore() {
    return {
      "name": name,
      "email": email,
      "timeStamp": time,
      "type": type,
      "profilePhoto": profilePhoto,
      'payLoad':payLoad
    };
  }

  factory NotificationModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    var data = snapshot.data();
    DateTime date = (data?['timeStamp'] as Timestamp).toDate();
    return NotificationModel(
      email: data?['email'] ?? "",
      name: data?["name"] ?? "",
      profilePhoto: data?['profilePhoto'] ?? "",
      type: data?['type'] ?? "",
      time: date,
      payLoad: data?['payLoad']??{}
    );
  }
}
