import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_wanna_play_app/Model/match_invitation_model.dart';
import 'package:flutter_wanna_play_app/Model/notification_invitation_model.dart';
import 'package:flutter_wanna_play_app/utils/enums.dart';
import 'package:intl/intl.dart';

import '../Firebase/firebase_methods.dart';

import '../helper/basehelper.dart';
import '../model/user_model.dart';

class MatchController {
  static void makeAMatch(context, UserModel? otherUser, UserModel? circolo,
      DateTime? dateTime) async {
    try {
      if (otherUser == null) {
        BaseHelper.showSnackBar(context, "Select your firend for a match");
        return;
      } else if (circolo == null) {
        BaseHelper.showSnackBar(context, "Select circolo for a match");
        return;
      } else if (dateTime == null) {
        BaseHelper.showSnackBar(context, "Select datetime for a match");
        return;
      } else if (dateTime.year == 2000) {
        BaseHelper.showSnackBar(context, "Select date for a match");
        return;
      } else if (dateTime.hour == 0) {
        BaseHelper.showSnackBar(context, "Select time for a match");
        return;
      }
      EasyLoading.show();

      NotificationModel notificationData = NotificationModel(
          profilePhoto: BaseHelper.user?.profilePhoto ?? "",
          name: BaseHelper.user?.name ?? "",
          email: BaseHelper.user?.email ?? "",
          type: otherUser.role == RoleName.player
              ? 'match invitation'
              : otherUser.role == RoleName.coach
                  ? "lesson invitation"
                  : '',
          time: Timestamp.now().toDate(),
          payLoad: {
            "selectedCircoloAddress": circolo.city,
            "opponentName": BaseHelper.user?.name.toString(),
            "opponentEmail": BaseHelper.user?.email.toString(),
            "selectedCircoloEmail": circolo.email,
            "selectedDatetime": DateFormat().format(dateTime),
            "matchStatus": 'pending',
            "opponentProfilePhoto": BaseHelper.user?.profilePhoto,
            "selectedCircoloName": circolo.name,
            "selectedCircoloProfilePhoto": circolo.profilePhoto,
            "opponentRole": reverseRoleName.reverseMap[BaseHelper.user?.role]
          });

      await FirebaseMethod.addMatchInvitationCollection(MatchInvitationModel(
          opponentName: otherUser.name,
          opponentEmail: otherUser.email,
          selectedCircoloEmail: circolo.email,
          selectedDatetime: dateTime,
          matchStatus: 'pending',
          opponentProfilePhoto: otherUser.profilePhoto,
          selectedCircoloName: circolo.name,
          selectedCircoloProfilePhoto: circolo.profilePhoto,
          opponentRole: otherUser.role,
          selectedCircoloAddress: circolo.city.toString()));
      await FirebaseMethod.getOtherUserData(circolo.email).then((value) async {
        await FirebaseMethod.setOtherInvitation(
            circolo.email,
            NotificationModel(
                profilePhoto: BaseHelper.user?.profilePhoto ?? "",
                name: BaseHelper.user?.name ?? "",
                email: BaseHelper.user?.email ?? "",
                type: 'circolo invitation',
                time: Timestamp.now().toDate(),
                payLoad: {
                  "selectedCircoloAddress": circolo.city,
                  "opponentName": BaseHelper.user?.name.toString(),
                  "opponentEmail": BaseHelper.user?.email.toString(),
                  "selectedCircoloEmail": circolo.email,
                  "selectedDatetime": DateFormat().format(dateTime),
                  "matchStatus": 'pending',
                  "opponentProfilePhoto": BaseHelper.user?.profilePhoto,
                  "selectedCircoloName": circolo.name,
                  "selectedCircoloProfilePhoto": circolo.profilePhoto,
                  "opponentRole":
                      reverseRoleName.reverseMap[BaseHelper.user?.role]
                }));
        await FirebaseMethod.addNotificationOtherCollection(
            circolo.email,
            NotificationModel(
                profilePhoto: BaseHelper.user?.profilePhoto ?? "",
                name: BaseHelper.user?.name ?? "",
                email: BaseHelper.user?.email ?? "",
                type: 'circolo invitation',
                time: Timestamp.now().toDate()));

        await FirebaseMethod.notificationSendMessage(
            "${BaseHelper.user?.name} has requested for Circolo",
            "Click to see Profile",
            value?.deviceToken.toString() ?? '', {
          "type": "circolo invitation",
          "selectedCircoloAddress": circolo.city,
          "opponentName": BaseHelper.user?.name.toString(),
          "opponentEmail": BaseHelper.user?.email.toString(),
          "selectedCircoloEmail": circolo.email,
          "selectedDatetime": DateFormat().format(dateTime),
          "matchStatus": 'pending',
          "opponentProfilePhoto": BaseHelper.user?.profilePhoto,
          "selectedCircoloName": circolo.name,
          "selectedCircoloProfilePhoto": circolo.profilePhoto,
          "opponentRole": reverseRoleName.reverseMap[BaseHelper.user?.role]
        });
      });
      await FirebaseMethod.getOtherUserData(otherUser.email)
          .then((value) async {
        await FirebaseMethod.setOtherInvitation(
            otherUser.email, notificationData);
        await FirebaseMethod.addNotificationOtherCollection(
            otherUser.email, notificationData);

        await FirebaseMethod.notificationSendMessage(
            "${BaseHelper.user?.name} requested for a match",
            "Click to check now",
            value?.deviceToken.toString() ?? '', {
          "type": otherUser.role == RoleName.player
              ? 'match invitation'
              : otherUser.role == RoleName.coach
                  ? "lesson invitation"
                  : '',
          "selectedCircoloAddress": circolo.city,
          "opponentName": BaseHelper.user?.name.toString(),
          "opponentEmail": BaseHelper.user?.email.toString(),
          "selectedCircoloEmail": circolo.email,
          "selectedDatetime": DateFormat().format(dateTime),
          "matchStatus": 'pending',
          "opponentProfilePhoto": BaseHelper.user?.profilePhoto,
          "selectedCircoloName": circolo.name,
          "selectedCircoloProfilePhoto": circolo.profilePhoto,
          "opponentRole": reverseRoleName.reverseMap[BaseHelper.user?.role]
        });
      });

      BaseHelper.showSnackBar(context,
          'Invitation has been send to ${circolo.name} and ${otherUser.name}');
      EasyLoading.dismiss();
      Navigator.of(context).pop();
    } catch (e) {
      EasyLoading.dismiss();
      print('error something wrong $e');
    }
  }
}
