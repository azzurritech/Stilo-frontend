import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_wanna_play_app/Model/match_invitation_model.dart';
import 'package:intl/intl.dart';

import '../Firebase/firebase_methods.dart';
import '../Model/notification_invitation_model.dart';

import '../helper/basehelper.dart';
import '../model/user_model.dart';

class InvitationController {
  static sendInvitation(context, UserModel? otherUser) async {
    await FirebaseMethod.getUserData();
    List? sendUserInvitation = BaseHelper.user?.invitationSendTo;
    EasyLoading.show();

    if (sendUserInvitation!.contains(otherUser?.email)) {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, 'Already you have send the invitation');
      return;
    } else {
      try {
        NotificationModel data = NotificationModel(
            profilePhoto: BaseHelper.user?.profilePhoto.toString() ?? "",
            name: BaseHelper.user?.name.toString() ?? "",
            email: BaseHelper.user?.email.toString() ?? "",
            type: 'invitation',
            time: Timestamp.now().toDate());
        await FirebaseMethod.setOtherInvitation(otherUser?.email ?? '', data);
        sendUserInvitation.add(otherUser?.email);
        await FirebaseMethod.updateData(
            {"invitationSendTo": sendUserInvitation});
        await FirebaseMethod.notificationSendMessage(
            "${BaseHelper.user?.name} invited you",
            "Click to visit Profile",
            otherUser?.deviceToken.toString() ?? "",
            {"type": "invitation", "email": BaseHelper.user?.email});
        await FirebaseMethod.addNotificationOtherCollection(
            otherUser?.email, data);
      } on FirebaseException catch (e) {
        EasyLoading.dismiss();
        BaseHelper.showSnackBar(context, e.message);
        return;
      }
      Navigator.of(context).pop();
      BaseHelper.showSnackBar(context, 'Successfully invitation send');

      EasyLoading.dismiss();
      return;
    }
  }

  static acceptFriendInvitation(
    context,
    UserModel otherUser,
  ) async {
    EasyLoading.show();
    try {
      await FirebaseMethod.getUserData();
      List? sendUserInvitation = BaseHelper.user?.invitationSendTo;

      List invitaionOtherUser = otherUser.invitationSendTo ?? [];
      List? currentfriendList = BaseHelper.user?.friends;
      List? otherFriendList = otherUser.friends;

      if (sendUserInvitation!.contains(otherUser.email)) {
        sendUserInvitation.remove(otherUser.email);
        await FirebaseMethod.deleteOtherUserInvitationCollection(
            otherUser.email);
      }
      invitaionOtherUser.remove(BaseHelper.currentUser?.email);
      await FirebaseMethod.deleteUserInvitationCollection(otherUser.email);
      otherFriendList?.add(BaseHelper.currentUser?.email);
      currentfriendList?.add(otherUser.email);
      await FirebaseMethod.updateData({
        'friends': currentfriendList,
        "invitationSendTo": sendUserInvitation
      });
      await FirebaseMethod.updateOtherData(otherUser.email,
          {"friends": otherFriendList, 'invitationSendTo': invitaionOtherUser});
      await FirebaseMethod.notificationSendMessage(
          "${BaseHelper.user?.name} accepted your invitation",
          "Click to chat now",
          otherUser.deviceToken.toString(),
          {"type": "accepted invitation", "email": BaseHelper.user?.email});

      NotificationModel data = NotificationModel(
          profilePhoto: BaseHelper.user?.profilePhoto ?? "",
          name: BaseHelper.user?.name ?? "",
          email: BaseHelper.user?.email ?? "",
          type: 'accepted invitation',
          time: Timestamp.now().toDate());
      await FirebaseMethod.addNotificationOtherCollection(
          otherUser.email, data);
      await FirebaseMethod.notificationInvitationDelete(otherUser.email);
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, e.message);
      return;
    }
    Navigator.of(context).pop();
    EasyLoading.dismiss();
    BaseHelper.showSnackBar(context, "${otherUser.name} added as a friend");
    return;
  }

  static acceptInvitationMatch(
    context, {
    required MatchInvitationModel matchInvitationModelData,
  }) async {
    EasyLoading.show();
    try {
      await FirebaseMethod.getUserData();

      await FirebaseMethod.deleteUserInvitationCollection(
          matchInvitationModelData.opponentEmail);
      await FirebaseMethod.notificationMatchDelete(
          matchInvitationModelData.opponentEmail);
      await FirebaseMethod.deleteUserInvitationCollection(
          matchInvitationModelData.selectedCircoloEmail);
      await FirebaseMethod.notificationMatchDelete(
          matchInvitationModelData.selectedCircoloEmail);
      await FirebaseMethod.addMatchInvitationCollection(MatchInvitationModel(
        matchStatus: 'Confirmed',
        opponentRole: matchInvitationModelData.opponentRole,
        opponentName: matchInvitationModelData.opponentName,
        opponentEmail: matchInvitationModelData.opponentEmail,
        selectedCircoloName: matchInvitationModelData.selectedCircoloName,
        selectedCircoloEmail: matchInvitationModelData.selectedCircoloEmail,
        selectedDatetime: matchInvitationModelData.selectedDatetime,
        selectedCircoloProfilePhoto:
            matchInvitationModelData.selectedCircoloProfilePhoto,
        opponentProfilePhoto: matchInvitationModelData.opponentProfilePhoto,
        selectedCircoloAddress: matchInvitationModelData.selectedCircoloAddress,
      ));
      await FirebaseMethod.otherMatchInvitationCollection(
          onEmailMatchDocFn: (id) {
            BaseHelper.firestore
                .collection('users')
                .doc(matchInvitationModelData.opponentEmail)
                .collection('matchInvitation')
                .doc(id)
                .update({'matchStatus': 'Accepted'});
          },
          email: matchInvitationModelData.opponentEmail);

      await FirebaseMethod.getOtherUserData(
              matchInvitationModelData.opponentEmail)
          .then((value) async {
        await FirebaseMethod.notificationSendMessage(
            "${BaseHelper.user?.name} accepted your match invitation",
            "Click to see match details",
            value!.deviceToken.toString(), {
          "type": "accepted match invitation",
          "opponentName": BaseHelper.user?.name.toString(),
          "opponentEmail": BaseHelper.user?.email.toString(),
          "selectedCircoloEmail": matchInvitationModelData.selectedCircoloEmail,
          "selectedDatetime":
              DateFormat().format(matchInvitationModelData.selectedDatetime),
          "matchStatus": 'Accepted',
          "opponentProfilePhoto": BaseHelper.user?.profilePhoto,
          "selectedCircoloName": matchInvitationModelData.selectedCircoloName,
          "selectedCircoloProfilePhoto":
              matchInvitationModelData.selectedCircoloProfilePhoto,
          "selectedCircoloAddress":
              matchInvitationModelData.selectedCircoloAddress,
          "opponentRole": reverseRoleName.reverseMap[BaseHelper.user?.role]
        });
      });
      await FirebaseMethod.getOtherUserData(
              matchInvitationModelData.selectedCircoloEmail)
          .then((value) async {
        await FirebaseMethod.notificationSendMessage(
            "${BaseHelper.user?.name} confirmed match invitation  of ${matchInvitationModelData.opponentEmail}",
            "Click to match details",
            value!.deviceToken.toString(), {
          "type": "confirmed match invitation",
        });
      });

      Navigator.of(context).pop();

      BaseHelper.showSnackBar(
          context, "You can see now match details in Match List");
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, e.message);
    }
    EasyLoading.dismiss();
    return;
  }

  static rejectInvitationMatch(
    context, {
    required MatchInvitationModel matchInvitationModelData,
  }) async {
    EasyLoading.show();
    try {
      await FirebaseMethod.getUserData();

      await FirebaseMethod.getUserData();

      await FirebaseMethod.deleteUserInvitationCollection(
          matchInvitationModelData.opponentEmail);
      await FirebaseMethod.notificationMatchDelete(
          matchInvitationModelData.opponentEmail);
      await FirebaseMethod.deleteUserInvitationCollection(
          matchInvitationModelData.selectedCircoloEmail);
      await FirebaseMethod.notificationMatchDelete(
          matchInvitationModelData.selectedCircoloEmail);
      //
      await FirebaseMethod.otherMatchInvitationCollection(
        email: matchInvitationModelData.opponentEmail,
        onEmailMatchDocFn: (id) {
          BaseHelper.firestore
              .collection('users')
              .doc(matchInvitationModelData.opponentEmail)
              .collection('matchInvitation')
              .doc(id)
              .update({'matchStatus': 'Declined'});
        },
      );

      await FirebaseMethod.getOtherUserData(
              matchInvitationModelData.opponentEmail)
          .then((value) async {
        await FirebaseMethod.notificationSendMessage(
            "${BaseHelper.user?.name} rejected your match invitation",
            "Click to see details",
            value!.deviceToken.toString(), {
          "type": "rejected match invitation",
          "opponentName": BaseHelper.user?.name.toString(),
          "opponentEmail": BaseHelper.user?.email.toString(),
          "selectedCircoloEmail": matchInvitationModelData.selectedCircoloEmail,
          "selectedDatetime":
              DateFormat().format(matchInvitationModelData.selectedDatetime),
          "matchStatus": 'Declined',
          "selectedCircoloAddress":
              matchInvitationModelData.selectedCircoloAddress,
          "opponentProfilePhoto": BaseHelper.user?.profilePhoto,
          "selectedCircoloName": matchInvitationModelData.selectedCircoloName,
          "selectedCircoloProfilePhoto":
              matchInvitationModelData.selectedCircoloProfilePhoto,
          "opponentRole": reverseRoleName.reverseMap[BaseHelper.user?.role]
        });
      });

      await FirebaseMethod.getOtherUserData(
              matchInvitationModelData.selectedCircoloEmail)
          .then((value) async {
        await FirebaseMethod.notificationSendMessage(
            "${BaseHelper.user?.name} has cancelled the match with ${matchInvitationModelData.opponentName}",
            "Click to see details",
            value!.deviceToken.toString(), {
          "type": "cancelled match invitation",
        });
      });

      Navigator.of(context).pop();

      BaseHelper.showSnackBar(
          context, "You have successfully refuse the match invitation");
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, e.message);
    }
    EasyLoading.dismiss();
    return;
  }

  static rejectFriendInvitation(
    context,
    UserModel otherUser,
  ) async {
    EasyLoading.show();
    try {
      await FirebaseMethod.getUserData();
      List? sendUserInvitation = BaseHelper.user?.invitationSendTo;

      List invitaionOtherUser = otherUser.invitationSendTo ?? [];

      if (sendUserInvitation!.contains(otherUser.email)) {
        sendUserInvitation.remove(otherUser.email);
        await FirebaseMethod.deleteOtherUserInvitationCollection(
            otherUser.email);
      }
      invitaionOtherUser.remove(BaseHelper.currentUser?.email);
      await FirebaseMethod.deleteUserInvitationCollection(otherUser.email);

      await FirebaseMethod.updateData({"invitationSendTo": sendUserInvitation});
      await FirebaseMethod.updateOtherData(
          otherUser.email, {'invitationSendTo': invitaionOtherUser});
      await FirebaseMethod.notificationSendMessage(
          "${BaseHelper.user?.name} rejected your invitation",
          "Click to add again as a friend",
          otherUser.deviceToken.toString(),
          {"type": "rejected invitation", "email": BaseHelper.user?.email});
      NotificationModel data = NotificationModel(
          profilePhoto: BaseHelper.user?.profilePhoto ?? "",
          name: BaseHelper.user?.name ?? "",
          email: BaseHelper.user?.email ?? "",
          type: 'rejected invitation',
          time: Timestamp.now().toDate());
      await FirebaseMethod.addNotificationOtherCollection(
          otherUser.email, data);
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, e.message);
      return;
    }
    Navigator.of(context).pop();
    EasyLoading.dismiss();
    BaseHelper.showSnackBar(
        context, "Invitation decline from ${otherUser.name} ");
    return;
  }
}
