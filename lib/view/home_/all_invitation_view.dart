import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/Model/match_invitation_model.dart';
import 'package:flutter_wanna_play_app/model/user_model.dart';
import 'package:flutter_wanna_play_app/utils/enums.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';

import 'package:intl/intl.dart';

import '../../Model/notification_invitation_model.dart';
import '../../View/invitation_/accept_reject_match_invite_view.dart';
import '../../firebase/firebase_methods.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/circle_widget.dart';
import '../invitation_/accept_reject_friend_invite_view.dart';

class AllInvitationView extends StatelessWidget {
  const AllInvitationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: context.loc.invitationRecieved,
      ),
      body: StreamBuilder(
        stream: FirebaseMethod.getAllInvitationStram(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.docs.isEmpty ?? false) {
              return Center(
                child: Text(
                  context.loc.norecordfound,
                  style: heading22BlackStyle,
                ),
              );
            } else {
              return inviteListTile(snapshot);
            }
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return Container();
        },
      ),
    );
  }

  ListView inviteListTile(
      AsyncSnapshot<QuerySnapshot<NotificationModel>> snapshot) {
    return ListView.separated(
        itemBuilder: (context, index) {
          NotificationModel data =
              snapshot.data?.docs[index].data() as NotificationModel;
          return ListTile(
            onTap: () async {
              data.type == 'match invitation' ||
                      data.type == 'lesson invitation'
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AcceptRejectMatchInviteView(
                          matchInvitationModel: MatchInvitationModel(
                        matchStatus: data.payLoad?['matchStatus'],
                        opponentRole: reverseRoleName
                                .map[data.payLoad!['opponentRole']] ??
                            RoleName.none,
                        opponentName: data.payLoad?['opponentName'],
                        opponentEmail: data.payLoad?['opponentEmail'],
                        selectedCircoloName:
                            data.payLoad?['selectedCircoloName'],
                        selectedCircoloEmail:
                            data.payLoad?['selectedCircoloEmail'],
                        selectedDatetime: DateFormat().parse(
                          data.payLoad?['selectedDatetime'],
                        ),
                        selectedCircoloProfilePhoto:
                            data.payLoad?['selectedCircoloProfilePhoto'],
                        opponentProfilePhoto:
                            data.payLoad?['opponentProfilePhoto'],
                        selectedCircoloAddress:
                            data.payLoad?['selectedCircoloAddress'],
                      )),
                    ))
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => AcceptRejectFriendInviteView(
                            email: data.email,
                          ))));
            },
            leading:
                CustomCircleAvatar(radius: 30, imageUrl: data.profilePhoto),
            title: Text(
                "${data.name} ${data.type == 'match invitation' || data.type == 'lesson invitation' ? 'Vs You' : ''}"),
            subtitle: Text(data.type == 'match invitation' ||
                    data.type == 'lesson invitation'
                ? 'Click to See match Detail'
                : data.email),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            thickness: 1.2,
            color: AppColor.maincolor,
          );
        },
        itemCount: snapshot.data?.docs.length ?? 0);
  }
}
