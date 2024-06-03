import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_wanna_play_app/utils/enums.dart';

class UserModel {
  final RoleName role;
  final String name;
  final String email;
  final String password;
  final String? phoneNumber;
  final String? dob;
  final String city;

  final String? gender;
  final String? isFederationRanking;
  final String? federationRanking;
  final String? federationLink;
  final String profilePhoto;
  final String? isKeepLeaderboard;
  final List? invitationSendTo;
  final List? friends;
  final String? deviceToken;
  final String? status;
  final List? serviz;
  final List? campi;
  bool? isPremiumAcc = false;
  final bool isPrivacyPolicy;
  double? lat;
  double? long;
  UserModel(
      {required this.profilePhoto,
      required this.isPrivacyPolicy,
      required this.role,
      this.dob,
      required this.city,
      this.gender,
      this.isFederationRanking,
      this.federationRanking,
      required this.name,
      required this.password,
      required this.email,
      this.campi,
      this.phoneNumber,
      this.serviz,
      this.isKeepLeaderboard,
      this.deviceToken,
      this.invitationSendTo,
      this.friends,
      this.lat,
      this.long,
      this.status,
      this.isPremiumAcc,
      this.federationLink});

  Map<String, dynamic> toFireStore() {
    return {
      "role": reverseRoleName.reverseMap[role],
      "name": name,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
      "seviziList": serviz,
      "campList": campi,
      "dob": dob,
      "city": city,
      "gender": gender,
      "isFederationRanking": isFederationRanking,
      "federationRanking": federationRanking,
      "federationLink": federationLink,
      "lat": lat,
      "long": long,
      "isKeepLeaderboard": isFederationRanking,
      "profilePhoto": profilePhoto,
      "invitationSendTo": invitationSendTo,
      "friends": friends,
      "device_token": deviceToken,
      "status": status,
      "isPremiumAccount": isPremiumAcc,
      "isPrivacyPolicy": isPrivacyPolicy
    };
  }

  factory UserModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    var data = snapshot.data();
    return UserModel(
        invitationSendTo: data?["invitationSendTo"] ??= [],
        friends: data?['friends'] ??= [],
        name: data?["name"] ??= "",
        role: reverseRoleName.map[data?["role"]] ?? RoleName.none,
        city: data?["city"] ??= "",
        gender: data?["gender"] ??= "",
        isFederationRanking: data?["isFederationRanking"] ??= "",
        dob: data?["dob"] ??= "",
        email: data?["email"] ??= "",
        federationRanking: data?["federationRanking"] ??= "",
        lat: data?["lat"] ??= 0.0,
        long: data?["long"] ??= 0.0,
        federationLink: data?["federationLink"] ??= "",
        profilePhoto: data?["profilePhoto"] ??= "",
        isKeepLeaderboard: data?["isKeepLeaderboard"] ??= '',
        deviceToken: data?['device_token'] ??= "",
        status: data?['status'] ??= "",
        password: data?["password"] ??= "",
        campi: data?["campList"] ??= [],
        serviz: data?["seviziList"] ??= [],
        phoneNumber: data?["phoneNumber"] ??= '',
        isPremiumAcc: data?['isPremiumAccount'] ??= false,
        isPrivacyPolicy: data?['isPrivacyPolicy'] ??= false);
  }
}

final reverseRoleName = EnumValues({
  'player': RoleName.player,
  "coach": RoleName.coach,
  "club": RoleName.club,
  "paddle": RoleName.paddle,
  "physiotherapist": RoleName.physiotherapist,
  "none": RoleName.none
});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map) : reverseMap = map.map((k, v) => MapEntry(v, k));
}
