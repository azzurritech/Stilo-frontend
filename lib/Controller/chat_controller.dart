
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../Firebase/firebase_methods.dart';



import '../helper/basehelper.dart';

import '../model/chat_model.dart';
import '../model/recentChat_model.dart';
import '../model/user_model.dart';

class ChatController {
  static int? getCounterValue;
  static bool? isUserOnScreen;
  static void onSendBtn(
      {required String chatRoomId,
      required String messageController,
      required UserModel user}) async {
    if (messageController.isNotEmpty) {
      await getUserIsOnScreen(user.email);
      int counter = getCounterValue?.toInt() ?? 0;

      var data = ChatModel(
          message: messageController,
          sendByEmail: BaseHelper.user?.email ?? "",
          timeStamp: Timestamp.now().toDate(),
          type: 'text');

      await FirebaseMethod.chatRoom(chatRoomId, data);

      await FirebaseMethod.recentChatCollection(
          user.email,
          RecentChatModel(
              counter: 0,
              onChatScreen: true,
              profilePhoto: user.profilePhoto,
              lastMessage: messageController,
              friendMail: user.email.toString(),
              timeStamp: Timestamp.now().toDate(),
              name: user.name));
      await FirebaseMethod.recentChatOtherCollection(
          user.email,
          RecentChatModel(
              counter: isUserOnScreen == true ? 0 : counter += 1,
              name: BaseHelper.user?.name ?? "",
              onChatScreen: isUserOnScreen == true ? true : false,
              profilePhoto: BaseHelper.user?.profilePhoto ?? "",
              lastMessage: messageController,
              friendMail: BaseHelper.user?.email ?? '',
              timeStamp: Timestamp.now().toDate()));

      if (isUserOnScreen == false || isUserOnScreen == null) {
        await FirebaseMethod.getOtherUserData(user.email).then((value) {
          FirebaseMethod.notificationSendMessage(BaseHelper.user?.name ?? "",
              messageController, value?.deviceToken.toString() ?? "", {
            'type': 'msg',
            'chatRoomId': chatRoomId,
            'friendMail': BaseHelper.currentUser?.email
          });
        });
      }

      await getCounterValueFn(user.email);
    } else {
      return;
    }
  }

  static getCounterValueFn(String email) async {
    await FirebaseMethod.recentChatOtherGet(email).then((value) {
      getCounterValue = value?.counter ?? 0;
    });
  }

  static getUserIsOnScreen(String email) async {
    await FirebaseMethod.recentChatOtherGet(email).then((value) {
      if (value?.onChatScreen == true) {
        isUserOnScreen = true;
      } else {
        isUserOnScreen = false;
      }
    });
    return null;
  }

  static onChatScreen(bool onChatScreen, String email) async {
    return await FirebaseMethod.recentChatCollectionUpdate(
        email, {"onChatScreen": onChatScreen, "counter": 0});
  }

  static DateTime returnDateTimeFormatted(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static String groupMessageDateTime(DateTime dateTime) {
    final todayDate = DateTime.now();
    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    String difference = '';
    final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (aDate == today) {
      difference = 'Today';
    } else if (aDate == yesterday) {
      difference = 'yesterday';
    } else if (aDate.year == today.year) {
      difference = DateFormat.MMMMEEEEd().format(dateTime);
    } else {
      difference = DateFormat.yMMMMd().format(dateTime);
    }
    return difference;
  }
}
