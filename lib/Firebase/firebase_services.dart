import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_wanna_play_app/Model/match_invitation_model.dart';

import 'package:flutter_wanna_play_app/View/chat_/group_chat_view.dart';
import 'package:flutter_wanna_play_app/View/invitation_/match_detail_view.dart';
import 'package:flutter_wanna_play_app/model/user_model.dart';
import 'package:flutter_wanna_play_app/utils/enums.dart';

import 'package:intl/intl.dart';

import '../View/chat_/chat_view.dart';
import '../View/invitation_/accept_reject_friend_invite_view.dart';
import '../View/invitation_/accept_reject_match_invite_view.dart';
import '../View/profile_/friend_profile_view.dart';
import 'package:permission_handler/permission_handler.dart';
class NotificationServices {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<bool?> requestNotificationPermission(BuildContext context) async {
  


NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);

if (settings.authorizationStatus == AuthorizationStatus.authorized) {
return true;
} else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
return false;
} else {
_showPermissionDialog(context);
}
return false;
 
    // const permission = Permission.notification;
  //   if (await permission.isGranted) return true;

  //   if (await permission.isPermanentlyDenied) {
  //   _showPermissionDialog(context);
  //   }

  //   final granted = await permission.request();
  //   if (granted.isGranted) {
  //     return true;
  //   } else if (granted.isDenied) {
  //     return false;
  //   }else if(granted.isPermanentlyDenied){

  //  _showPermissionDialog(context);
    
  //   }
    // return false;
  }
static _showPermissionDialog(BuildContext context) {
  showAdaptiveDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        title: const Text("Notification Permission Required"),
        content: const Text("Please enable notification permissions to receive updates."),
        actions: <Widget>[
          TextButton(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: const Text("Open Settings")),
            onPressed: ()async {
              // Open app settings
           await  openAppSettings();
            },
          ),
          TextButton(
            child: FittedBox(
                fit: BoxFit.scaleDown,
              child: const Text("Close")),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
  static void initLocalNotification(context, RemoteMessage message) async {
    const androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    final iosInitializationSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      requestCriticalPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) =>
          handleMessage(context, message),
    );
    final initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) =>
          handleMessage(context, message),
    );
  }

  static void firebaseInIt(context) async {
    if (Platform.isIOS) {
      foregroundMessaging();
    }
    FirebaseMessaging.onMessage.listen((message) async {
      initLocalNotification(context, message);
      showNotification(message);
    });
  }

//  static   final String filePath = '';
//    static final BigPictureStyleInformation bigPictureStyleInformation =
//         BigPictureStyleInformation(FilePathAndroidBitmap(filePath),
//             largeIcon: FilePathAndroidBitmap(filePath));
  // final http.Response response = await http.get(Uri.parse(URL));
  // BigPictureStyleInformation bigPictureStyleInformation =
  //     BigPictureStyleInformation(
  //   ByteArrayAndroidBitmap.fromBase64String(base64Encode(image)),
  //   largeIcon: ByteArrayAndroidBitmap.fromBase64String(base64Encode(image)),
  // );
  static Future<void> showNotification(RemoteMessage message) async {
    List<ActiveNotification> activeNotification =
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()!
            .getActiveNotifications();
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      "high_importance_channel",
      "High Importance Notifications",
      importance: Importance.high,
    );
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (activeNotification.isEmpty || activeNotification.length == 1) {
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
              channel.id.toString(), channel.name.toString(),
              channelDescription: "high_importance_channel",
              importance: Importance.high,
              priority: Priority.high,
              color: const Color(0xffFD2B24),
              ticker: "ticker");
      DarwinNotificationDetails darwinNotificationDetails =
          const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, iOS: darwinNotificationDetails);

      Future.delayed(
          Duration.zero,
          () => flutterLocalNotificationsPlugin.show(
              0,
              message.notification?.title.toString(),
              message.notification?.body.toString(),
              notificationDetails));
    }

    if (activeNotification.length > 1) {
      List<String> lines =
          activeNotification.map((e) => e.title.toString()).toList();
      InboxStyleInformation inboxStyleInformation = InboxStyleInformation(lines,
          contentTitle: "${activeNotification.length - 1} messages",
          summaryText: "${activeNotification.length - 1} messages");
      AndroidNotificationDetails groupAndroidNotificationDetails =
          AndroidNotificationDetails(
              channel.id.toString(), channel.name.toString(),
              channelDescription: "high_importance_channel",
              groupKey: '0',
              setAsGroupSummary: true,
              importance: Importance.high,
              priority: Priority.high,
              color: const Color(0xffFD2B24),
              autoCancel: true,
              styleInformation: inboxStyleInformation,
              ticker: "ticker");

      NotificationDetails groupNotificationDetails = NotificationDetails(
        android: groupAndroidNotificationDetails,
      );

      Future.delayed(
          Duration.zero,
          () => flutterLocalNotificationsPlugin.show(
              0,
              message.notification?.title.toString(),
              message.notification?.body.toString(),
              groupNotificationDetails));
    }
  }

  static Future<String?> getDeviceToken() async {
    return await messaging.getToken();
  }

  // static refreshDeviceToken() {
  //   return messaging.onTokenRefresh.listen((event) async {
  //     return await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser?.email)
  //         .update({"device_token": event});
  //   });
  // }

  // static Future<void> createNotificationChannel(
  //     String id, String name, String description) async {
  //   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   var androidNotificationChannel =
  //       AndroidNotificationChannel(id, name, description: description);
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(androidNotificationChannel);
  // }

  static Future<void> setupInteractMessage(context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  static Future foregroundMessaging() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  static handleMessage(context, RemoteMessage message) async {
    if (message.data['type'] == 'invitation') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AcceptRejectFriendInviteView(
                email: message.data['email'],
              )));
    } else if (message.data['type'] == 'accepted invitation') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FriendProfileView(
                email: message.data['email'],
              )));
    } else if (message.data['type'] == 'rejected invitation') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AcceptRejectFriendInviteView(
                email: message.data['email'],
              )));
    } else if (message.data['type'] == 'msg') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChatView(
            chatRoomId: message.data['chatRoomId'],
            email: message.data['friendMail']),
      ));
    } else if (message.data['type'] == 'match invitation') {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => AcceptRejectMatchInviteView(
                matchInvitationModel: MatchInvitationModel(
                    matchStatus: message.data['matchStatus'],
                    opponentRole:
                        reverseRoleName.map[message.data['opponentRole']] ??
                            RoleName.none,
                    opponentName: message.data['opponentName'],
                    opponentEmail: message.data['opponentEmail'],
                    selectedCircoloName: message.data['selectedCircoloName'],
                    selectedCircoloEmail: message.data['selectedCircoloEmail'],
                    selectedDatetime:
                        DateFormat().parse(message.data['selectedDatetime']),
                    selectedCircoloProfilePhoto:
                        message.data['selectedCircoloProfilePhoto'],
                    opponentProfilePhoto: message.data['opponentProfilePhoto'],
                    selectedCircoloAddress:
                        message.data["selectedCircoloAddress"]))),
      );
    } else if (message.data['type'] == 'lesson invitation') {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => AcceptRejectMatchInviteView(
                matchInvitationModel: MatchInvitationModel(
                    matchStatus: message.data['matchStatus'],
                    opponentRole:
                        reverseRoleName.map[message.data['opponentRole']] ??
                            RoleName.none,
                    opponentName: message.data['opponentName'],
                    opponentEmail: message.data['opponentEmail'],
                    selectedCircoloName: message.data['selectedCircoloName'],
                    selectedCircoloEmail: message.data['selectedCircoloEmail'],
                    selectedDatetime:
                        DateFormat().parse(message.data['selectedDatetime']),
                    selectedCircoloProfilePhoto:
                        message.data['selectedCircoloProfilePhoto'],
                    opponentProfilePhoto: message.data['opponentProfilePhoto'],
                    selectedCircoloAddress:
                        message.data["selectedCircoloAddress"]))),
      );
    } else if (message.data['type'] == 'accepted match invitation') {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => MatchDetailView(
                matchInvitationData: MatchInvitationModel(
                    matchStatus: message.data['matchStatus'],
                    opponentRole:
                        reverseRoleName.map[message.data['opponentRole']] ??
                            RoleName.none,
                    opponentName: message.data['opponentName'],
                    opponentEmail: message.data['opponentEmail'],
                    selectedCircoloName: message.data['selectedCircoloName'],
                    selectedCircoloEmail: message.data['selectedCircoloEmail'],
                    selectedDatetime:
                        DateFormat().parse(message.data['selectedDatetime']),
                    selectedCircoloProfilePhoto:
                        message.data['selectedCircoloProfilePhoto'],
                    opponentProfilePhoto: message.data['opponentProfilePhoto'],
                    selectedCircoloAddress:
                        message.data["selectedCircoloAddress"]))),
      );
    } else if (message.data['type'] == 'rejected match invitation') {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => MatchDetailView(
                matchInvitationData: MatchInvitationModel(
                    matchStatus: message.data['matchStatus'],
                    opponentRole:
                        reverseRoleName.map[message.data['opponentRole']] ??
                            RoleName.none,
                    opponentName: message.data['opponentName'],
                    opponentEmail: message.data['opponentEmail'],
                    selectedCircoloName: message.data['selectedCircoloName'],
                    selectedCircoloEmail: message.data['selectedCircoloEmail'],
                    selectedDatetime:
                        DateFormat().parse(message.data['selectedDatetime']),
                    selectedCircoloProfilePhoto:
                        message.data['selectedCircoloProfilePhoto'],
                    opponentProfilePhoto: message.data['opponentProfilePhoto'],
                    selectedCircoloAddress:
                        message.data["selectedCircoloAddress"]))),
      );
    } else if (message.data['type'] == 'confirmed match invitation') {
    } else if (message.data['type'] == 'cancelled match invitation') {
    } else if (message.data['type'] == 'circolo invitation') {
    } else if (message.data['type'] == 'groupMsg') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => GroupChatView(groupId: message.data['groupId']),
      ));
    }
  }
}
