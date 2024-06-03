
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

import '../Firebase/firebase_methods.dart';

import '../helper/basehelper.dart';
import '../model/chat_model.dart';
import '../model/create_group_model.dart';
import '../model/recentChat_model.dart';

class GroupChatController {
  static String friendDT = '';
  static GroupDetailModel? groupData;
  static Map<String, int>? getCounterValue;
  static bool? userOnChatScreen;
  static int counterValue = 0;
  static void onSendBtn({
    required GroupDetailModel createGroupModel,
    required String messageController,
  }) async {
    if (messageController.isNotEmpty) {
      var data = ChatModel(
          message: messageController,
          sendByEmail: BaseHelper.user?.email ?? "",
          timeStamp: Timestamp.now().toDate(),
          type: 'text');

      await FirebaseMethod.groupChat(createGroupModel.groupId, data);

      for (var element in createGroupModel.memberList) {
        await getGroupCounterValueFn(
          element['email'],
          createGroupModel.groupId,
        );
        await getUserIsOnScreen(
          element['email'],
          createGroupModel.groupId,
        );
        if (userOnChatScreen == false || userOnChatScreen == null) {
          FirebaseMethod.getOtherUserData(element['email']!).then((value) {
            if (value?.email != BaseHelper.user?.email) {
              FirebaseMethod.notificationSendMessage(createGroupModel.groupName,
                  messageController, value?.deviceToken.toString() ?? "", {
                'type': 'groupMsg',
                'groupId': createGroupModel.groupId,
              });
            }
          });
        }
        if (element["email"] != BaseHelper.user?.email) {
          await FirebaseMethod.recentChatOtherCollection(
            element['email'],
            RecentChatModel(
                onChatScreen: userOnChatScreen == true ? true : false,
                name: createGroupModel.groupName,
                counter: userOnChatScreen == true ? 0 : counterValue += 1,
                lastMessage: messageController,
                timeStamp: Timestamp.now().toDate(),
                friendMail: BaseHelper.user?.name,
                groupId: createGroupModel.groupId,
                profilePhoto: createGroupModel.imageUrl.toString()),
            groupId: createGroupModel.groupId,
          );
        }
      }

      await FirebaseMethod.recentChatCollection(
          createGroupModel.groupId,
          RecentChatModel(
              counter: 0,
              onChatScreen: true,
              lastMessage: messageController,
              timeStamp: Timestamp.now().toDate(),
              groupId: createGroupModel.groupId,
              profilePhoto: createGroupModel.imageUrl.toString(),
              friendMail: BaseHelper.user?.name,
              name: createGroupModel.groupName));
    } else {
      return;
    }
  }

  static getGroupData(String groupId) async {
    groupData = await FirebaseMethod.getGroupCollectionData(groupId);
  }

  static Future<int?> getGroupCounterValueFn(
      String email, String groupId) async {
    await FirebaseMethod.groupRecentChatOtherGet(email, groupId).then((value) {
      counterValue = value?.counter ?? 0;
    });
    return null;
  }

  static onChatScreen(bool onChatScreen, String docName) async {
    return await FirebaseMethod.recentChatCollectionUpdate(
        docName, {"onChatScreen": onChatScreen, "counter": 0});
  }

  static getUserIsOnScreen(String email, String groupId) async {
    await FirebaseMethod.recentChatOtherGetGroup(email, groupId).then((value) {
      if (value?.onChatScreen == true) {
        userOnChatScreen = true;
      } else {
        userOnChatScreen = false;
      }
    });
    return null;
  }

  static DateTime returnDateTimeFormatted(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static String groupMessageDateTime(DateTime dateTime) {
    var orignalDate = DateFormat('yyyyMMdd').format(dateTime);
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
    } else {
      difference = orignalDate;
    }
    return difference;
  }
}
