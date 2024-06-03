import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/controller/recent_chat_controller.dart';

import 'package:intl/intl.dart';

import '../../Firebase/firebase_methods.dart';

import '../../helper/basehelper.dart';
import '../../model/recentChat_model.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';

import '../../widgets/app_bar_widget.dart';

import '../../widgets/circle_widget.dart';


class RecentChatView extends StatelessWidget {
  const RecentChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Chats',
      ),
      body: StreamBuilder(
          stream: FirebaseMethod.recentChatSnapShot(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.docs.isEmpty ?? false) {
                return Center(
                  child: Text(
                    "No record found",
                    style: heading22BlackStyle,
                  ),
                );
              } else {
                return ListView.separated(
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: (context, index) {
                    RecentChatModel recentChatModel =
                        snapshot.data?.docs[index].data() as RecentChatModel;
                    return Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: ListTile(
                        onTap: () {
                          RecentChatController.onChatTap(
                            context,
                            recentChatModel: snapshot.data?.docs[index].data() as RecentChatModel
                               
                          );
                        },
                        leading: CustomCircleAvatar(
                          radius: 30,
                          imageUrl: recentChatModel.profilePhoto,
                        ),
                        title: Text(recentChatModel.name.toString()),
                        subtitle: snapshot.data?.docs[index]
                                    .data()
                                    .groupId
                                    .toString() !=
                                ""
                            ? Text(recentChatModel.friendMail ==
                                    BaseHelper.user?.name
                                ? "You : ${recentChatModel.lastMessage}"
                                : "${recentChatModel.friendMail} : ${recentChatModel.lastMessage} ")
                            : Text(recentChatModel.lastMessage),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (recentChatModel.counter.toString() != "0")
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: AppColor.privacy_color,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(recentChatModel.counter.toString()),
                              ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(DateFormat('h:mm a')
                                .format(recentChatModel.timeStamp)),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 1.2,
                    color: AppColor.maincolor,
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return Container();
          }),
    );
  }
}
