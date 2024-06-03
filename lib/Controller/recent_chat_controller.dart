import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/controller/group_chat_controller.dart';


import '../helper/basehelper.dart';
import '../View/chat_/chat_view.dart';
import '../View/chat_/group_chat_view.dart';
import '../model/recentChat_model.dart';
import 'home_page_controller.dart';

class RecentChatController {
  static onChatTap(
    context, {
    required RecentChatModel recentChatModel,
  }) async {
    if (recentChatModel.groupId.toString() == '') {
      String roomId = HomePageController.createChatRoomId(
          BaseHelper.user?.email.toString() ?? "",
          recentChatModel.friendMail.toString());
      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => ChatView(
                chatRoomId: roomId,
                email: recentChatModel.friendMail ?? "",
              ))));
    } else {
      await GroupChatController.getGroupData(
          recentChatModel.groupId.toString());
      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) =>
              GroupChatView(groupId: recentChatModel.groupId.toString()))));
    }
  }
}
