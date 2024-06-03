import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/helper/basehelper.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';
import 'package:flutter_wanna_play_app/widgets/cache_network_widget.dart';



import '../../controller/invitation_controller.dart';
import '../../firebase/firebase_methods.dart';
import '../../model/user_model.dart';
import '../../utils/constant/button_text_style.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/circle_widget.dart';
import '../../widgets/custom_sized_box_widget.dart';
import '../../widgets/rating_star.dart';



class SendFriendInvitationView extends StatelessWidget {
  const SendFriendInvitationView({
    super.key,
    required this.email,
  });
  final String email;
  
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: FirebaseMethod.getOtherUserDataStream(email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? user = snapshot.data?.data();

            return Scaffold(
              appBar: AppBarWidget(
                title: user?.name ?? "",
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: cacheNetworkWidget(context, imageUrl: user?.profilePhoto.toString()??""))
                    ),
                    CustomSizedBox(
                      height: height * 0.04,
                    ),
                    Text(
                      user?.email ?? "",
                      style: heading22BlackStyle,
                    ),
                    CustomSizedBox(
                      height: height * 0.015,
                    ),
                    CustomRating(
                        value: double.tryParse(
                                user?.federationRanking ?? '0.0') ??
                            0.0),
                    CustomSizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      user?.role.name??"",
                      style: title18BlackStyle,
                    ),
                    CustomSizedBox(
                      height: height * 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                      
                              Text(
                                "${context.loc.city} : ${user?.city}",
                                style: title18BlackStyle,
                              ),
                           
                          Padding(
                            padding: const EdgeInsets.only(top: 27.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${context.loc.federationRanking}: ${user?.federationRanking}',
                                  style: title18BlackStyle,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                context.loc.maintainsRanking,
                                style: hint_text,
                              ),
                            ],
                          ),
                          // CustomSizedBox(
                          //   height: height * 0.01,
                          // ),
                           Padding(
                            padding: const EdgeInsets.only(top: 9.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${context.loc.age}: ${BaseHelper.getAge(user?.dob.toString()??"")}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                    CustomButton(
                        color: AppColor.buttonnewcolor,
                        width: width * 0.8,
                        height: height * 0.05,
                        text: context.loc.invite,
                        onpressed: () {
                          InvitationController.sendInvitation(context, user);
                        })
                  ],
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return  Center(
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
