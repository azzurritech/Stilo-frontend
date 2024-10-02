import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanna_play_app/View/invitation_/coach_match_requests_view.dart';
import 'package:flutter_wanna_play_app/utils/enums.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';
import 'package:flutter_wanna_play_app/view/chat_/group_view.dart';
import 'package:flutter_wanna_play_app/view/privacy_policy_view.dart';
import 'package:flutter_wanna_play_app/widgets/cache_network_widget.dart';

import 'package:geolocator/geolocator.dart';

import '../../controller/home_page_controller.dart';
import '../../service/geolocator.dart';
import '../../helper/basehelper.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../view/home_/all_invitation_view.dart';
import '../../view/home_/all_notification_view.dart';
import '../../view/home_/premium_acc.dart';
import '../../view/home_/search/search_view.dart';
import '../../view/invitation_/make_match_lesson_view.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/circle_widget.dart';
import '../../widgets/dialog_box_widget.dart';
import '../../widgets/list_tile_widget.dart';
import '../../widgets/textformfield.dart';

import '../chat_/recent_chat_view.dart';
import '../invitation_/player_matches_request_view.dart';
import 'friend_list_view.dart';

import 'setting_/app_setting_view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    HomePageController.setStatus("Online");
    HomePageController.notificationLocation(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      HomePageController.setStatus('Online');
    } else if (state == AppLifecycleState.inactive) {
      HomePageController.setStatus('Offline');
    } else {
      BaseHelper.currentUser?.email != null
          ? HomePageController.setStatus('Offline')
          : null;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        BaseHelper.hideKeypad(context);
        bool? shouldPop;

        shouldPop = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => customDialogBox(context,
                    title: context.loc.areYouSureWantToExit, onCancel: () {
                  Navigator.of(context).pop(false);
                }, onOk: () {
                  Navigator.of(context).pop(true);
                }));

        return Future.value(shouldPop);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(
          title: context.loc.home,
          background: AppColor.divivdercolor,
          // action: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //           builder: (context) => const PremiumAccount(),
          //         ));
          //       },
          //       icon: const Icon(
          //         Icons.arrow_circle_up_outlined,
          //         size: 29,
          //       ))
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: cacheNetworkWidget(context,
                              imageUrl: BaseHelper.user?.profilePhoto ?? "")),
                    ),
                    SizedBox(width: width * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: width * 0.6,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              BaseHelper.user?.name.toString() ??
                                  context.loc.noName,
                              style: heading22BlackStyle,
                            ),
                          ),
                        ),
                        // RatingStars(
                        //   value: value,
                        //   starColor: Appcolor.starcolor,
                        //   onValueChanged: (valu) {
                        //     setState(() {
                        //       value = valu;
                        //     });
                        //   },
                        // ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (BaseHelper.user?.role != RoleName.club)
                          Text(
                            "Role: ${BaseHelper.user?.role.name.capitalizeFirst()}",
                            style: subTitle16BlackStyle,
                          )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              if (BaseHelper.user?.role != RoleName.club)
                Textformfield(
                  height: height * 0.06,
                  width: width * 0.8,
                  text: context.loc.search,
                  suffixicon: const Icon(
                    Icons.search,
                    color: AppColor.hinttext_color,
                  ),
                  ontap: () {
                    LocPermission.handleLocationPermission(context)
                        .then((value) {
                      if (value == true) {
                        Geolocator.getCurrentPosition().then((event) async {
                          HomePageController.getAddressFromLatLng(
                              context, event);
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SearchView()));
                      } else {
                        Future.delayed(const Duration(milliseconds: 3500), () {
                          Geolocator.openLocationSettings();
                        });
                      }
                    });
                  },
                ),
              if (BaseHelper.user?.role != RoleName.club)
                Column(
                  children: [
                    SizedBox(
                      height: height * 0.04,
                    ),
                    CustomListTileButton(
                      height: height * 0.06,
                      width: width * 0.8,
                      text: context.loc.playerMatchRequest,
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const PlayerMatchesRequestView(),
                        ));
                      },
                    ),
                  ],
                ),
              if (BaseHelper.user?.role != RoleName.club)
                Column(
                  children: [
                    SizedBox(
                      height: height * 0.04,
                    ),
                    CustomListTileButton(
                      style: subTitle16lightGreenstyle,
                      height: height * 0.06,
                      width: width * 0.8,
                      text: context.loc.coachMatchRequest,
                      color: AppColor.maincolor,
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const CoachMatceshRequestsView(),
                        ));
                      },
                    ),
                  ],
                ),
              if (BaseHelper.user?.role != RoleName.club)
                Column(
                  children: [
                    SizedBox(
                      height: height * 0.04,
                    ),
                    CustomListTileButton(
                      height: height * 0.06,
                      width: width * 0.8,
                      text: context.loc.makeMatchWithPlayer,
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const MakeMatchLessonView(
                                  isLesson: false,
                                ))));
                      },
                    ),
                  ],
                ),
              if (BaseHelper.user?.role != RoleName.club)
                Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    CustomListTileButton(
                      style: subTitle16lightGreenstyle,
                      height: height * 0.06,
                      width: width * 0.8,
                      text: context.loc.showPlayerFriend,
                      color: AppColor.maincolor,
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const FriendListView(
                                  role: 'player',
                                ))));
                      },
                    ),
                  ],
                ),
              if (BaseHelper.user?.role != RoleName.club)
                Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    CustomListTileButton(
                      height: height * 0.06,
                      width: width * 0.8,
                      text: context.loc.showCoachFriend,
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const FriendListView(
                                  role: "coach",
                                ))));
                      },
                    ),
                  ],
                ),
              if (BaseHelper.user?.role != RoleName.club)
                Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    CustomListTileButton(
                      style: subTitle16lightGreenstyle,
                      height: height * 0.06,
                      width: width * 0.8,
                      text: context.loc.makeALessonWithCoach,
                      color: AppColor.maincolor,
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const MakeMatchLessonView(
                                  isLesson: true,
                                ))));
                      },
                    ),
                  ],
                ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomListTileButton(
                height: height * 0.06,
                width: width * 0.8,
                text: context.loc.invitationsRecieved,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const AllInvitationView())));
                },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomListTileButton(
                style: subTitle16lightGreenstyle,
                height: height * 0.06,
                width: width * 0.8,
                text: context.loc.notifications,
                color: AppColor.maincolor,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const AllNotificationsView())));
                },
              ),
              SizedBox(
                height: height * 0.03,
              ),

              CustomListTileButton(
                height: height * 0.06,
                width: width * 0.8,
                text: "Create Group",
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const GroupView())));
                },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomListTileButton(
                style: subTitle16lightGreenstyle,
                height: height * 0.06,
                width: width * 0.8,
                text: context.loc.recentChats,
                color: AppColor.maincolor,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const RecentChatView())));
                },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              // CustomListTileButton(
              //   style: subTitle16lightGreenstyle,
              //   height: height * 0.06,
              //   width: width * 0.8,
              //   text: 'Le ultime news ',
              //   color: AppColor.maincolor,
              //   ontap: () {
              //     Navigator.of(context).push(
              //         MaterialPageRoute(builder: ((context) => const News())));
              //   },
              // ),
              // SizedBox(
              //   height: height * 0.03,
              // ),
              CustomListTileButton(
                height: height * 0.06,
                width: width * 0.8,
                text: context.loc.showPrivacyPolicy,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const PrivacyPolicyView(
                            isReadOnly: true,
                          ))));
                },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomListTileButton(
                style: subTitle16lightGreenstyle,
                height: height * 0.06,
                width: width * 0.8,
                text: context.loc.appSettings,
                color: AppColor.maincolor,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const AppSettingsView())));
                },
              ),
              SizedBox(
                height: height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
