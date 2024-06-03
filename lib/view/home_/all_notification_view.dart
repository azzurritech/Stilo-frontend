import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/Model/match_invitation_model.dart';

import 'package:flutter_wanna_play_app/View/profile_/friend_profile_view.dart';
import 'package:flutter_wanna_play_app/model/user_model.dart';
import 'package:flutter_wanna_play_app/utils/enums.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';
import 'package:intl/intl.dart';

import '../../firebase/firebase_methods.dart';
import '../../Model/notification_invitation_model.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../utils/constant/image_path.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/circle_widget.dart';
import '../invitation_/accept_reject_friend_invite_view.dart';
import '../invitation_/accept_reject_match_invite_view.dart';
import '../invitation_/send_friend_invite_view.dart';

class AllNotificationsView extends StatelessWidget {
  const AllNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: context.loc.notifications,
      ),
      body: StreamBuilder(
          stream: FirebaseMethod.getNotificationCollectionStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.docs.isEmpty ?? false) {
                return Center(
                  child: Text(
                    context.loc.notifications,
                    style: heading22BlackStyle,
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      NotificationModel data = snapshot.data?.docs[index].data()
                          as NotificationModel;
                      return data.type == 'invitation'
                          ? invitedNotification(context, data)
                          : data.type == "accepted invitation"
                              ? acceptedInvitation(context, data)
                              : data.type == "rejected invitation"
                                  ? rejectInvitedNotification(context, data)
                                  : data.type == 'lesson invitation'
                                      ? lessonNotification(context, data)
                                      : data.type == 'match invitation'
                                          ? finalMatchNotification(
                                              context, data)
                                          : data.type == 'circolo invitation'
                                              ? finalMatchNotification(
                                                  context, data)
                                              : Container();
                    });
              }
            } else if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return Container();
          }),
    );
  }

  ListTile lessonNotification(BuildContext context, NotificationModel data) {
    return ListTile(
      leading: CustomCircleAvatar(radius: 30, imageUrl: data.profilePhoto),
      trailing: TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AcceptRejectMatchInviteView(
                matchInvitationModel: MatchInvitationModel(
                    matchStatus: data.payLoad?['matchStatus'],
                    opponentRole:
                        reverseRoleName.map[data.payLoad?['opponentRole']] ??
                            RoleName.none,
                    opponentName: data.payLoad?['opponentName'],
                    opponentEmail: data.payLoad?['opponentEmail'],
                    selectedCircoloName: data.payLoad?['selectedCircoloName'],
                    selectedCircoloEmail: data.payLoad?['selectedCircoloEmail'],
                    selectedDatetime:
                        DateFormat().parse(data.payLoad?['selectedDatetime']),
                    selectedCircoloProfilePhoto:
                        data.payLoad?['selectedCircoloProfilePhoto'],
                    opponentProfilePhoto: data.payLoad?['opponentProfilePhoto'],
                    selectedCircoloAddress:
                        data.payLoad?["selectedCircoloAddress"]),
              ),
            ));
          },
          child: Text("Details", style: notificationtext)),
      title: Text(
        'Lesson with ${data.name}',
        style: small12BlackStyle,
      ),
      subtitle: Text(
        'Invited for a lesson',
        style: small12LightGreyStyle,
      ),
    );
  }

  ListTile finalMatchNotification(
      BuildContext context, NotificationModel data) {
    return ListTile(
      leading: CustomCircleAvatar(radius: 30, imageUrl: data.profilePhoto),
      trailing: TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AcceptRejectMatchInviteView(
                matchInvitationModel: MatchInvitationModel(
                    matchStatus: data.payLoad?['matchStatus'] ?? '',
                    opponentRole:
                        reverseRoleName.map[data.payLoad?['opponentRole']] ??
                            RoleName.none,
                    opponentName: data.payLoad?['opponentName'] ?? '',
                    opponentEmail: data.payLoad?['opponentEmail'] ?? '',
                    selectedCircoloName:
                        data.payLoad?['selectedCircoloName'] ?? '',
                    selectedCircoloEmail:
                        data.payLoad?['selectedCircoloEmail'] ?? '',
                    selectedDatetime: DateFormat().parse(
                        data.payLoad?['selectedDatetime'] ?? DateTime.now()),
                    selectedCircoloProfilePhoto:
                        data.payLoad?['selectedCircoloProfilePhoto'] ?? '',
                    opponentProfilePhoto:
                        data.payLoad?['opponentProfilePhoto'] ?? '',
                    selectedCircoloAddress:
                        data.payLoad?["selectedCircoloAddress"]),
              ),
            ));
          },
          child: Text("Details", style: notificationtext)),
      title: Text(
        'You  Vs   ${data.name}',
        style: small12BlackStyle,
      ),
      subtitle: Text(
        'Invited you for a match',
        style: small12LightGreyStyle,
      ),
    );
  }

  ListTile draftMatchNotification() {
    return ListTile(
      leading: CustomCircleAvatar(radius: 50, images: AppAssets.loginlogo),
      trailing: TextButton(
          onPressed: () {}, child: Text("", style: notificationtext)),
      title: Text(
        'Draft Match',
        style: small12BlackStyle,
      ),
      subtitle: Text(
        'Add match detail',
        style: small12LightGreyStyle,
      ),
    );
  }

  ListTile invitedNotification(BuildContext context, NotificationModel data) {
    return ListTile(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AcceptRejectFriendInviteView(
            email: data.email,
          ),
        ));
      },
      leading: CustomCircleAvatar(
        radius: 30,
        imageUrl: data.profilePhoto,
      ),
      trailing: Text("Details", style: notificationtext),
      title: Text(
        '${data.name} has invited you',
        style: small12BlackStyle,
      ),
      subtitle: Text(
        'Visit profile and accept to match',
        style: small12LightGreyStyle,
      ),
    );
  }

  ListTile rejectInvitedNotification(
      BuildContext context, NotificationModel data) {
    return ListTile(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SendFriendInvitationView(
            email: data.email,
          ),
        ));
      },
      leading: CustomCircleAvatar(
        radius: 30,
        imageUrl: data.profilePhoto,
      ),
      trailing: Text("Details", style: notificationtext),
      title: Text(
        '${data.name} rejected invirtation',
        style: small12BlackStyle,
      ),
      subtitle: Text(
        context.loc.visitProfileToSendInvitationAgain,
        style: small12LightGreyStyle,
      ),
    );
  }

  ListTile acceptedInvitation(BuildContext context, NotificationModel data) {
    return ListTile(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FriendProfileView(email: data.email)));
      },
      leading: CustomCircleAvatar(
        radius: 30,
        imageUrl: data.profilePhoto,
      ),
      trailing: Text("Chat", style: notificationtext),
      title: Text(
        '${data.name} ${context.loc.acceptedYourInvitation}',
        style: small12BlackStyle,
      ),
      subtitle: Text(
        context.loc.youCanNowChatToPlanAMatch,
        style: small12LightGreyStyle,
      ),
    );
  }
}
