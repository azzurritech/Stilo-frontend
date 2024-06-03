import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_wanna_play_app/model/user_model.dart';
import 'package:flutter_wanna_play_app/utils/enums.dart';

class MatchInvitationModel {
  final String opponentName;
  final String opponentEmail;
  final String selectedCircoloEmail;
  final String selectedCircoloName;

  final String selectedCircoloAddress;
  final String opponentProfilePhoto;
  final DateTime selectedDatetime;
  final String selectedCircoloProfilePhoto;
  String? matchStatus;
  RoleName opponentRole;
  MatchInvitationModel(
      {this.matchStatus,
      required this.selectedCircoloAddress,
      required this.opponentRole,
      required this.opponentName,
      required this.opponentEmail,
      required this.selectedCircoloName,
      required this.selectedCircoloEmail,
      required this.selectedDatetime,
      required this.selectedCircoloProfilePhoto,
      required this.opponentProfilePhoto});

  Map<String, dynamic> toFireStore() {
    return {
      "seletedCircoloAddress": selectedCircoloAddress,
      "opponentName": opponentName,
      "opponentEmail": opponentEmail,
      'selectedCircoloEmail': selectedCircoloEmail,
      "selectedDatetime": selectedDatetime,
      "matchStatus": matchStatus,
      "selectedCircoloProfilePhoto": selectedCircoloProfilePhoto,
      "opponentProfilePhoto": opponentProfilePhoto,
      'selectedCircoloName': selectedCircoloName,
      "opponentRole": reverseRoleName.reverseMap[opponentRole],
    };
  }

  factory MatchInvitationModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic>? data = snapshot.data();
    DateTime date = (data?['selectedDatetime'] as Timestamp).toDate();
    return MatchInvitationModel(
        selectedCircoloAddress: data?["selectedCircoloAddress"] ?? "",
        opponentProfilePhoto: data?['opponentProfilePhoto'],
        selectedCircoloProfilePhoto: data?['selectedCircoloProfilePhoto'],
        matchStatus: data?['matchStatus'],
        opponentName: data?['opponentName'],
        opponentEmail: data?['opponentEmail'],
        selectedCircoloEmail: data?['selectedCircoloEmail'],
        selectedCircoloName: data?['selectedCircoloName'],
        opponentRole:
            reverseRoleName.map[data?['opponentRole']] ?? RoleName.none,
        selectedDatetime: date);
  }
}
