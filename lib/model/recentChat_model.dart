import 'package:cloud_firestore/cloud_firestore.dart';

class RecentChatModel {
  final String lastMessage;
  final String? friendMail;
  final String name;
  final DateTime timeStamp;
  final String profilePhoto;
  final int? counter;
  final bool? onChatScreen;
  final String? groupId;
  RecentChatModel({
    this.counter,
    this.onChatScreen,
    required this.profilePhoto,
    this.groupId,
    required this.lastMessage,
    this.friendMail,
    required this.timeStamp,
    required this.name,
  });
  Map<String, dynamic> toFireStore() {
    return {
      "lastMessage": lastMessage,
      "sendBy": friendMail,
      "timeStamp": timeStamp,
      "profilePhoto": profilePhoto,
      "name": name,
      "counter": counter,
      "onChatScreen": onChatScreen,
      "groupId": groupId
    };
  }

  factory RecentChatModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    var data = snapshot.data();
    DateTime date = (data?['timeStamp'] as Timestamp).toDate();
    return RecentChatModel(
      groupId: data?['groupId'] ?? '',
      lastMessage: data?['lastMessage'] ?? "",
      friendMail: data?["sendBy"] ?? "",
      counter: data?["counter"] ?? -1,
      timeStamp: date,
      profilePhoto: data?['profilePhoto'] ?? '',
      name: data?['name'] ?? "",
      onChatScreen: data?['onChatScreen'] ?? false,
    );
  }
}
