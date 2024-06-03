import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';



import 'package:flutter_wanna_play_app/View/chat_/create_group.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';
import 'package:flutter_wanna_play_app/widgets/dialog_box_widget.dart';
import 'package:geolocator/geolocator.dart';



import '../../controller/friend_view_controller.dart';
import '../../helper/basehelper.dart';
import '../../model/user_model.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/custom_container.dart';

import '../profile_/friend_profile_view.dart';

class FriendListView extends StatefulWidget {
  const FriendListView({super.key, required this.role});
  final String role;

  @override
  State<FriendListView> createState() => _FriendListViewState();
}

class _FriendListViewState extends State<FriendListView> {
  List<DocumentSnapshot<UserModel>>? doc;

  UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          title: widget.role == "Coach" ? context.loc.coachFriend :context.loc.player,
          // action: [
          //   ValueListenableBuilder(
          //     valueListenable: FriendViewController.isGroup,
          //     builder: (context, value, child) {
          //       if (FriendViewController.isGroup.value == false) {
          //         return PopupMenuButton(
          //           icon: const Icon(Icons.more_vert),
          //           itemBuilder: (context) => [
          //             PopupMenuItem(
          //               child:  Text(context.loc.createGroup),
          //               onTap: () {
          //                 FriendViewController.isGroup.value = true;
          //                 BaseHelper.showSnackBar(
          //                     context, context.loc.nowtapaddMember);
          //               },
          //             )
          //           ],
          //         );
          //       }
          //       return Padding(
          //         padding: const EdgeInsets.all(8),
          //         child: CustomElevatedButton(
          //             onPressed: () {
          //               FriendViewController.memberList.removeRange(
          //                   1, FriendViewController.memberList.length);
          //               FriendViewController.isGroup.value = false;
          //               BaseHelper.showSnackBar(context, context.loc.cancelled);
          //               setState(() {});
          //             },
          //             circularRadius: 16,
          //             text: context.loc.cancel),
          //       );
          //     },
          //   )
          // ],
        ),
        body: StreamBuilder(
            stream: BaseHelper.firestore
                .collection('users')
                .withConverter(
                    fromFirestore: UserModel.fromFireStore,
                    toFirestore: (UserModel user, options) =>
                        user.toFireStore())
                .where('role', isEqualTo: widget.role)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                doc = snapshot.data?.docs
                    .where((element) =>
                        element
                            .data()
                            .friends
                            ?.contains(BaseHelper.user?.email) ??
                        false)
                    .toList();

                if (doc?.isEmpty??false) {
                  return Center(
                    child: Text(
                      context.loc.norecordfound,
                      style: heading22BlackStyle,
                    ),
                  );
                } else {
                  return ValueListenableBuilder(
                      valueListenable: FriendViewController.isGroup,
                      builder: (context, value, child) {
                        return ListView.separated(
                            itemCount: doc?.length ?? 0,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: ((context, index) {
                              user = doc?[index].data();
                              double distance = Geolocator.distanceBetween(
                                          BaseHelper.user?.lat?.toDouble() ??
                                              -0.0,
                                          BaseHelper.user?.long?.toDouble() ??
                                              -0.0,
                                          user?.lat?.toDouble() ?? -0.0,
                                          user?.long?.toDouble() ?? -0.0)
                                      .round() /
                                  1000;
                              return Container(
                                color: FriendViewController.memberList.any(
                                  (element) =>
                                      element['email'] ==
                                      doc?[index].data()?.email.toString(),
                                )
                                    ? Colors.green
                                    : null,
                                child: ContainerListTile(
                                  isPremiumAcc: user?.isPremiumAcc ?? false,
                                  ontap: () async {
                                    if (FriendViewController.isGroup.value ==
                                        true) {
                                      if (FriendViewController
                                              .memberList.isEmpty) {
                                        FriendViewController.memberList.add({
                                          "name": doc?[index]
                                                  .data()
                                                  ?.name
                                                  .toString() ??
                                              "",
                                          "email": doc?[index]
                                                  .data()
                                                  ?.email
                                                  .toString() ??
                                              "",
                                          "profilePhoto": doc?[index]
                                                  .data()
                                                  ?.profilePhoto
                                                  .toString() ??
                                              "",
                                          "isAdmin": false,
                                        });
                                        setState(() {});
                                      } else {
                                        if (FriendViewController.memberList.any(
                                          (element) =>
                                              element['email'] ==
                                              doc?[index]
                                                  .data()
                                                  ?.email
                                                  .toString(),
                                        )) {
                                          FriendViewController.memberList
                                              .removeWhere((element) =>
                                                  element['email'] ==
                                                  doc?[index]
                                                      .data()
                                                      ?.email
                                                      .toString());
                                          setState(() {});
                                        } else {
                                          FriendViewController.memberList.add({
                                            "name": doc?[index]
                                                    .data()
                                                    ?.name
                                                    .toString() ??
                                                "",
                                            "email": doc?[index]
                                                    .data()
                                                    ?.email
                                                    .toString() ??
                                                "",
                                            "profilePhoto": doc?[index]
                                                    .data()
                                                    ?.profilePhoto
                                                    .toString() ??
                                                "",
                                            "isAdmin": false,
                                          });
                                          setState(() {});
                                        }
                                      }
                                    } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FriendProfileView(
                                                      email: doc?[index]
                                                              .data()
                                                              ?.email
                                                              .toString() ??
                                                          "")));
                                    }
                                  },
                                  imagee: user?.profilePhoto ?? "",
                                  titletext: user?.name ?? "",
                                  subtitle: user?.city ?? "",
                                  friend: BaseHelper.user!.friends!
                                      .contains(doc?[index].data()?.email),
                                  distance: user?.lat == null || user?.lat == 0
                                      ? ""
                                      : "${distance.toStringAsFixed(1)} km ",
                                  ratingValue: double.tryParse(
                                          user?.federationRanking ?? '0.0') ??
                                      0.0,
                                ),
                              );
                            }),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                                      height: 1,
                                      thickness: 1.2,
                                      color: AppColor.maincolor,
                                    ));
                      });
                }
              } else if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return Container();
            }),
        floatingActionButton: FriendViewController.memberList.length >= 2
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateGroupView(
                      memberList: FriendViewController.memberList,
                    ),
                  ));
                },
                child: const Icon(
                  Icons.navigate_next_sharp,
                  size: 40,
                ),
              )
            : null);
  }
}
