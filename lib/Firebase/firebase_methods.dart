import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_wanna_play_app/Model/match_invitation_model.dart';

import '../Model/notification_invitation_model.dart';

import 'package:http/http.dart' as http;

import '../helper/basehelper.dart';
import '../model/chat_model.dart';
import '../model/create_group_model.dart';
import '../model/recentChat_model.dart';
import '../model/user_model.dart';

class FirebaseMethod {
  static Future setUserData(UserModel data) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.auth.currentUser?.email)
        .withConverter(
            fromFirestore: UserModel.fromFireStore,
            toFirestore: (UserModel user, options) => user.toFireStore())
        .set(data);
  }

  static Future getUserData() async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .withConverter(
            fromFirestore: UserModel.fromFireStore,
            toFirestore: (UserModel user, options) => user.toFireStore())
        .get()
        .then((value) async {
      BaseHelper.currentUser = BaseHelper.auth.currentUser;
      if (value.data() == null) {
        return BaseHelper.user = null;
      } else {
        return BaseHelper.user = value.data();
      }
    });
  }

  static Future deleteUserData() async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.user?.email)
        .delete();
  }

  static Future updateData(data) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.auth.currentUser?.email)
        .withConverter(
            fromFirestore: UserModel.fromFireStore,
            toFirestore: (UserModel user, options) => user.toFireStore())
        .update(data);
  }

  static Future setOtherInvitation(String email, NotificationModel data) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(email)
        .collection('invitation')
        .doc(BaseHelper.currentUser?.email)
        .withConverter(
            fromFirestore: NotificationModel.fromFireStore,
            toFirestore: (NotificationModel e, options) => e.toFireStore())
        .set(data);
  }

  static Stream<QuerySnapshot<NotificationModel>> getAllInvitationStram() {
    return BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.currentUser?.email)
        .collection('invitation')
        .withConverter(
            fromFirestore: NotificationModel.fromFireStore,
            toFirestore: (NotificationModel e, options) => e.toFireStore())
        .orderBy('timeStamp', descending: true)
        .snapshots();
  }

  static Future updateOtherData(String email, Map<Object, Object?> data) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(email)
        .withConverter(
            fromFirestore: UserModel.fromFireStore,
            toFirestore: (UserModel user, options) => user.toFireStore())
        .update(data);
  }

  static Stream<DocumentSnapshot<UserModel>> getOtherUserDataStream(
      String email) {
    return BaseHelper.firestore
        .collection('users')
        .doc(email)
        .withConverter(
            fromFirestore: UserModel.fromFireStore,
            toFirestore: (UserModel user, options) => user.toFireStore())
        .snapshots();
  }

  static Future<UserModel?> getOtherUserData(String email) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(email)
        .withConverter(
            fromFirestore: UserModel.fromFireStore,
            toFirestore: (UserModel user, options) => user.toFireStore())
        .get()
        .then((value) {
      if (value.data() == null) {
        return null;
      } else {
        return value.data();
      }
    });
  }

  static deleteUserInvitationCollection(String email) {
    BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.currentUser?.email)
        .collection('invitation')
        .doc(email)
        .delete();
  }

  static deleteOtherUserInvitationCollection(String email) {
    BaseHelper.firestore
        .collection('users')
        .doc(email)
        .collection('invitation')
        .doc(BaseHelper.currentUser?.email)
        .delete();
  }

  static Future addMatchInvitationCollection(MatchInvitationModel data) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.currentUser?.email)
        .collection('matchInvitation')
        .withConverter(
            fromFirestore: MatchInvitationModel.fromFireStore,
            toFirestore: (MatchInvitationModel e, options) => e.toFireStore())
        .add(data);
  }

  static Future otherMatchInvitationCollection(
      {required String email,
      required void Function(String id) onEmailMatchDocFn}) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(email)
        .collection('matchInvitation')
        .withConverter(
            fromFirestore: MatchInvitationModel.fromFireStore,
            toFirestore: (MatchInvitationModel e, options) => e.toFireStore())
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data().opponentEmail == BaseHelper.user?.email) {
          onEmailMatchDocFn(element.id);
          return;
        } else {}
      }
    });
  }

  static Stream<QuerySnapshot<MatchInvitationModel>>
      matchInvitationGiocatoreCollectionStream() {
    return BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.currentUser?.email)
        .collection('matchInvitation')
        .withConverter(
            fromFirestore: MatchInvitationModel.fromFireStore,
            toFirestore: (MatchInvitationModel e, options) => e.toFireStore())
        .where('opponentRole', isEqualTo: 'player')
        .snapshots();
  }

  static Stream<QuerySnapshot<MatchInvitationModel>>
      matchInvitationCoachCollectionStream() {
    return BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.currentUser?.email)
        .collection('matchInvitation')
        .withConverter(
            fromFirestore: MatchInvitationModel.fromFireStore,
            toFirestore: (MatchInvitationModel e, options) => e.toFireStore())
        .where('opponentRole', isEqualTo: 'coach')
        .snapshots();
  }
  // static Future addMatchInvitationOtherCollection(
  //     email, MatchInvitationModel data) async {
  //   return await BaseHelper.firestore
  //       .collection('users')
  //       .doc(email)
  //       .collection('matchInvitation')
  //       .withConverter(
  //           fromFirestore: MatchInvitationModel.fromFireStore,
  //           toFirestore: (MatchInvitationModel e, options) => e.toFireStore())
  //       .add(data);
  // }

  static Future addNotificationOtherCollection(
      email, NotificationModel data) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(email)
        .collection('notification')
        .withConverter(
            fromFirestore: NotificationModel.fromFireStore,
            toFirestore: (NotificationModel e, options) => e.toFireStore())
        .add(data);
  }

  static Stream<QuerySnapshot<NotificationModel>>
      getNotificationCollectionStream() {
    return BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.user?.email)
        .collection('notification')
        .withConverter(
            fromFirestore: NotificationModel.fromFireStore,
            toFirestore: (NotificationModel e, options) => e.toFireStore())
        .orderBy('timeStamp', descending: true)
        .snapshots();
  }

  static notificationInvitationDelete(String email) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.user?.email)
        .collection('notification')
        .get()
        .then((value) async {
      for (var element in value.docs) {
        final batch = BaseHelper.firestore.batch();
        if (element.data()["type"] == 'invitation' &&
            element.data()['email'] == email) {
          batch.delete(element.reference);
        }
        await batch.commit();
      }
    });
  }

  static notificationMatchDelete(String email) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.user?.email)
        .collection('notification')
        .get()
        .then((value) async {
      for (var element in value.docs) {
        final batch = BaseHelper.firestore.batch();
        if (element.data()["type"] == 'match invitation' ||
            element.data()["type"] == 'lesson invitation' ||
            element.data()["type"] == 'circolo invitation' &&
                element.data()['email'] == email) {
          batch.delete(element.reference);
        }
        await batch.commit();
      }
    });
  }

  static Stream<QuerySnapshot<ChatModel>> chatCollection(String chatRoomId) {
    return BaseHelper.firestore
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('timeStamp', descending: true)
        .withConverter(
          fromFirestore: ChatModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .snapshots();
  }

  static chatRoom(String chatRoomId, ChatModel data) async {
    return await BaseHelper.firestore
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .withConverter(
          fromFirestore: ChatModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .add(data);
  }

  static recentChatCollection(String email, RecentChatModel data) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.user?.email)
        .collection('recentChats')
        .doc(email)
        .withConverter(
          fromFirestore: RecentChatModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .set(data);
  }

  static recentChatOtherCollection(String? email, RecentChatModel data,
      {String? groupId}) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(email)
        .collection('recentChats')
        .doc(groupId ?? BaseHelper.user?.email)
        .withConverter(
          fromFirestore: RecentChatModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .set(data);
  }

  static recentChatCollectionUpdate(
      String docName, Map<Object, Object?> data) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.user?.email)
        .collection('recentChats')
        .doc(docName)
        .withConverter(
          fromFirestore: RecentChatModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .update(data);
  }

  static recentChatCollectionGet(
      String email, Map<Object, Object?> data) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.user?.email)
        .collection('recentChats')
        .doc(email)
        .withConverter(
          fromFirestore: RecentChatModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .get()
        .then((value) => null);
  }

  static Stream<QuerySnapshot<RecentChatModel>> recentChatSnapShot() {
    return BaseHelper.firestore
        .collection('users')
        .doc(BaseHelper.user?.email)
        .collection('recentChats')
        .withConverter(
          fromFirestore: RecentChatModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .snapshots();
  }

  static Future<RecentChatModel?> recentChatOtherGet(String email) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(email)
        .collection('recentChats')
        .doc(BaseHelper.user?.email)
        .withConverter(
          fromFirestore: RecentChatModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .get()
        .then((value) {
      return value.data();
    });
  }

  static Future<RecentChatModel?> recentChatOtherGetGroup(
      String email, String groupId) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(email)
        .collection('recentChats')
        .doc(groupId)
        .withConverter(
          fromFirestore: RecentChatModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .get()
        .then((value) {
      return value.data();
    });
  }

  static Future<RecentChatModel?> groupRecentChatOtherGet(
      String email, String groupId) async {
    return await BaseHelper.firestore
        .collection('users')
        .doc(email)
        .collection('recentChats')
        .doc(groupId)
        .withConverter(
          fromFirestore: RecentChatModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .get()
        .then((value) {
      return value.data();
    });
  }

  static groupCollectionSet(String groupId, GroupDetailModel data) async {
    return await BaseHelper.firestore
        .collection('groupChats')
        .doc(groupId)
        .withConverter(
          fromFirestore: GroupDetailModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .set(data);
  }

  static Future<GroupDetailModel?> getGroupCollectionData(
      String groupId) async {
    return await BaseHelper.firestore
        .collection('groupChats')
        .doc(groupId)
        .withConverter(
          fromFirestore: GroupDetailModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .get()
        .then((value) {
      if (value.data() != null) {
        return value.data();
      }
      return null;
    });
  }

  static groupChat(String grooupId, ChatModel data) async {
    return await BaseHelper.firestore
        .collection('groupChats')
        .doc(grooupId)
        .collection('chats')
        .withConverter(
          fromFirestore: ChatModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .add(data);
  }

  static Stream<QuerySnapshot<ChatModel>> groupChatCollection(String groupId) {
    return BaseHelper.firestore
        .collection('groupChats')
        .doc(groupId)
        .collection('chats')
        .orderBy('timeStamp', descending: true)
        .withConverter(
          fromFirestore: ChatModel.fromFireStore,
          toFirestore: (value, options) => value.toFireStore(),
        )
        .snapshots();
  }

  static notificationSendMessage(
      String title, String body, String friendDT, Map payLoad) async {
    var data = {
      'to': friendDT,
      'priority': 'high',
      'notification': {
        "priority": "high",
        "sound": "default",
        'title': title,
        'body': body,
      },
      'data': payLoad
    };
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAABSS9C78:APA91bGD3kVfapUe1jIfDtbh5zqx9cHi7Wa5LXQSDdE9MxuFwI1ox3HvJVxSKUp9I_siM5srXQsJZnbi03RH3HZEY_R5ZtPJ8Nn7qtO6t6V5IzLj5HRpcvvL3m1XKYEYXf7OjE4QvKaG'
        });
  }
}
