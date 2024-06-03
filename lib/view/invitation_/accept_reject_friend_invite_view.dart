

import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';




import '../../controller/invitation_controller.dart';
import '../../firebase/firebase_methods.dart';


import '../../model/user_model.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/circle_widget.dart';
import '../../widgets/custom_sized_box_widget.dart';



class AcceptRejectFriendInviteView extends StatefulWidget {
  const AcceptRejectFriendInviteView({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<AcceptRejectFriendInviteView> createState() =>
      _AcceptRejectFriendInviteViewState();
}

class _AcceptRejectFriendInviteViewState
    extends State<AcceptRejectFriendInviteView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: FirebaseMethod.getOtherUserDataStream(widget.email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel user = snapshot.data?.data() as UserModel;
            return Scaffold(
              appBar: AppBarWidget(
                title: user.name,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSizedBox(
                      height: height * 0.05,
                    ),
                    SizedBox(
                      width: 182,
                      height: 182,
                      child: CustomCircleAvatar(
                        radius: 50,
                        imageUrl: user.profilePhoto,
                      ),
                    ),
                    CustomSizedBox(
                      height: height * 0.04,
                    ),
                    Text(
                      user.email ?? "",
                      style: heading22BlackStyle,
                    ),
                    CustomSizedBox(
                      height: height * 0.015,
                    ),
                    Text(
                      user.role.name,
                      style: title18BlackStyle,
                    ),
                    CustomSizedBox(
                      height: height * 0.2,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  const Offset(2, 9), // changes position of shadow
                            ),
                          ],
                          color: AppColor.containbackgeround,
                          borderRadius: BorderRadius.circular(18)),
                      height: height * 0.2,
                      width: width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${context.loc.city} : ${user.city}',
                                    style: title18WhiteStyle,
                                  ),
                                ),
                              ],
                            ),
                
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${context.loc.federationRanking}:${user.federationRanking}',
                                    style: title18WhiteStyle,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  context.loc.maintainsRanking,
                                  style: title18WhiteStyle,
                                ),
                              ],
                            ),
                            // CustomSizedBox(
                            //   height: height * 0.01,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top: 9.0),
                              child: Wrap(
                                children: [
                                  Text(
                                    "${context.loc.age}: 28 ",
                                    style: title18WhiteStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                            style: subTitle16DarkGreyStyle,
                            width: width * 0.3,
                            height: height * 0.05,
                            text: context.loc.accept,
                            color: AppColor.buttonnewcolor,
                            onpressed: () {
                              InvitationController.acceptFriendInvitation(
                                  context, user );
                            }),
                        CustomButton(
                            style: subTitle16lightGreenstyle,
                            width: width * 0.3,
                            height: height * 0.05,
                            color: AppColor.maincolor,
                            text: context.loc.reject,
                            onpressed: () {
                              InvitationController.rejectFriendInvitation(
                                  context, user);
                            })
                      ],
                    )
                  ],
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text(context.loc.somethingWentWrong),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return Container();
        });
  }
}
