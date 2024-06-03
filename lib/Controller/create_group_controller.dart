import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_wanna_play_app/Firebase/firebase_methods.dart';

import 'package:flutter_wanna_play_app/helper/basehelper.dart';

import 'package:uuid/uuid.dart';

import '../model/chat_model.dart';
import '../model/create_group_model.dart';
import '../model/recentChat_model.dart';
import '../view/chat_/group_chat_view.dart';

class CreateGroupCOntroller {
  static createGroup(context,
      {required String groupName,
      String? groupDescription,
      String? imageUrl,
      required List memberLIst}) async {
    BaseHelper.hideKeypad(context);
    EasyLoading.show();
    List members = memberLIst
        .where((element) => element['email'] != BaseHelper.user?.email)
        .toList();
    if (members.isEmpty) {
      BaseHelper.showSnackBar(context, 'Add participants please');
      EasyLoading.dismiss();
      return;
    }
    String groupId = const Uuid().v1();
    await FirebaseMethod.groupCollectionSet(
        groupId,
        GroupDetailModel(
            groupName: groupName,
            memberList: memberLIst,
            groupDesciption: groupDescription?.toString() ?? "",
            imageUrl: imageUrl.toString(),
            groupId: groupId));
    BaseHelper.showSnackBar(context, 'Group created Successfully');
    await FirebaseMethod.recentChatCollection(
        groupId,
        RecentChatModel(
            groupId: groupId,
            profilePhoto: imageUrl.toString(),
            lastMessage: 'You Created Group',
            // friendMail: BaseHelper.user?.email.toString() ?? "",
            timeStamp: Timestamp.now().toDate(),
            name: groupName));
    for (var element in members) {
      await FirebaseMethod.recentChatOtherCollection(
          element['email'],
          RecentChatModel(
              groupId: groupId,
              profilePhoto: imageUrl.toString(),
              lastMessage: 'Group Create by ${BaseHelper.user?.name}',
              // friendMail: BaseHelper.user?.email.toString() ?? "",
              timeStamp: Timestamp.now().toDate(),
              name: groupName),
          groupId: groupId);
      FirebaseMethod.getOtherUserData(element['email']).then((value) {
        FirebaseMethod.notificationSendMessage(
            groupName,
            'You were added in GroupBy ${BaseHelper.user?.name.toString()}',
            value?.deviceToken.toString() ?? "", {
          'type': 'groupMsg',
          'groupId': groupId,
        });
      });
    }

    FirebaseMethod.groupChat(
        groupId,
        ChatModel(
            message: 'Group Created by ${BaseHelper.user?.name}',
            sendByEmail: BaseHelper.user?.email ?? "",
            timeStamp: Timestamp.now().toDate(),
            type: 'notify'));
    EasyLoading.dismiss();
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => GroupChatView(
        groupId: groupId,
      ),
    ));
    return;
  }
}
