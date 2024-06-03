import 'package:cloud_firestore/cloud_firestore.dart';

class GroupDetailModel {
  final String groupName;
  final String groupDesciption;
  final String imageUrl;
  final String groupId;
  final List memberList;
  GroupDetailModel(
      {required this.groupName,
      required this.memberList,
      required this.groupDesciption,
      required this.imageUrl,
      required this.groupId});
  Map<String, dynamic> toFireStore() {
    return {
      "memberList": memberList,
      "groupName": groupName,
      "groupDesciption": groupDesciption,
      "imageUrl": imageUrl,
      "groupId": groupId,
    };
  }

  factory GroupDetailModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    var data = snapshot.data();

    return GroupDetailModel(
      groupName: data?['groupName'] ?? "",
      groupDesciption: data?["groupDesciption"] ?? "",
      imageUrl: data?['imageUrl'] ?? "",
      groupId: data?['groupId'] ?? false,
      memberList: data?["memberList"] ?? [],
    );
  }
}
