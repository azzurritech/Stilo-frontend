import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/Model/match_invitation_model.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';
import 'package:intl/intl.dart';

import '../../controller/invitation_controller.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/circle_widget.dart';
import '../../widgets/custom_sized_box_widget.dart';

class AcceptRejectMatchInviteView extends StatefulWidget {
  const AcceptRejectMatchInviteView({
    super.key,
    required this.matchInvitationModel,
  });
  final MatchInvitationModel matchInvitationModel;

  @override
  State<AcceptRejectMatchInviteView> createState() =>
      _AcceptRejectFriendInviteViewState();
}

class _AcceptRejectFriendInviteViewState
    extends State<AcceptRejectMatchInviteView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.matchInvitationModel.opponentName,
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
                imageUrl: widget.matchInvitationModel.opponentProfilePhoto,
              ),
            ),
            CustomSizedBox(
              height: height * 0.04,
            ),
            CustomSizedBox(
              height: height * 0.015,
            ),
            Text(
              widget.matchInvitationModel.opponentRole.name,
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
                      offset: const Offset(2, 9), // changes position of shadow
                    ),
                  ],
                  color: AppColor.containbackgeround,
                  borderRadius: BorderRadius.circular(18)),
              height: height * 0.2,
              width: width * 0.8,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Selected Cirolo: ${widget.matchInvitationModel.selectedCircoloName}',
                          style: title18WhiteStyle,
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 27.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: title18WhiteStyle,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '',
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
                            "${context.loc.selectedTime}: ${DateFormat.yMMMMEEEEd().format(widget.matchInvitationModel.selectedDatetime)} at ${DateFormat('hh:mm aa').format(widget.matchInvitationModel.selectedDatetime)} ",
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
                      InvitationController.acceptInvitationMatch(
                        context,
                        matchInvitationModelData: widget.matchInvitationModel,
                      );
                    }),
                CustomButton(
                    style: subTitle16lightGreenstyle,
                    width: width * 0.3,
                    height: height * 0.05,
                    color: AppColor.maincolor,
                    text: context.loc.reject,
                    onpressed: () {
                      InvitationController.rejectInvitationMatch(context,
                          matchInvitationModelData:
                              widget.matchInvitationModel);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
