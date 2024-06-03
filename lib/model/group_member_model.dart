import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMemberModel {
  final String name;
  final String email;
  final String profilePhoto;
  final bool isAdmin;
  GroupMemberModel(
      {required this.name,
      required this.email,
      required this.profilePhoto,
      required this.isAdmin});
  Map<String, dynamic> toFireStore() {
    return {
      "name": name,
      "email": email,
      "profilePhoto": profilePhoto,
      "isAdmin": isAdmin,
    };
  }

  factory GroupMemberModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    var data = snapshot.data();

    return GroupMemberModel(
      name: data?['name'] ?? "",
      email: data?["email"] ?? "",
      profilePhoto: data?['profilePhoto'] ?? "",
      isAdmin: data?['isAdmin'] ??false,
    );
  }
}
