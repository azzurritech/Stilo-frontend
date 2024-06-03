import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/Model/match_invitation_model.dart';
import 'package:flutter_wanna_play_app/View/invitation_/match_detail_view.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';
import 'package:flutter_wanna_play_app/widgets/app_bar_widget.dart';

import '../../Firebase/firebase_methods.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../widgets/circle_widget.dart';


class CoachMatceshRequestsView extends StatelessWidget {
  const CoachMatceshRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: context.loc.lessonMatch,
        background: AppColor.divivdercolor,
      ),
      body: StreamBuilder(
        stream: FirebaseMethod.matchInvitationCoachCollectionStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.docs.isEmpty??false) {
              return Center(
                child: Text(
                 context.loc.norecordfound,
                  style: heading22BlackStyle,
                ),
              );
            } else {
              return matchGiocatoreInvitation(snapshot);
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
}

matchGiocatoreInvitation(
    AsyncSnapshot<QuerySnapshot<MatchInvitationModel>> snapshot) {
  return ListView.separated(
      itemBuilder: (context, index) {
        MatchInvitationModel data =
            snapshot.data?.docs[index].data() as MatchInvitationModel;
        return ListTile(
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => MatchDetailView(
                      matchInvitationData: snapshot.data?.docs[index].data()
                          as MatchInvitationModel,
                    ))));
          },
          leading: CustomCircleAvatar(
              radius: 30, imageUrl: data.opponentProfilePhoto),
          title: Text(
            data.opponentName,
          ),
          subtitle: Text(data.selectedCircoloEmail),
          trailing: Text('${data.matchStatus}'),
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
