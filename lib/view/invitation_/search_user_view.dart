import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';
import 'package:geolocator/geolocator.dart';


import '../../helper/basehelper.dart';
import '../../model/user_model.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/custom_container.dart';

class SelectUsersView extends StatelessWidget {
  final bool isClub, isCoach;
  final ValueNotifier<UserModel?> otherUser;
  SelectUsersView({
    super.key,
    required this.otherUser,
    required this.isClub,
    required this.isCoach,
  });

  List<DocumentSnapshot<UserModel>>? doc = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: isCoach == true
              ? context.loc.coach
              : isClub
                  ? context.loc.club
                  : context.loc.player,
          action: [
            ValueListenableBuilder<UserModel?>(
              valueListenable: otherUser,
              builder: (context, value, child) => otherUser.value != null
                  ? TextButton(
                      onPressed: () {
                        Navigator.pop(context, otherUser.value);
                      },
                      child: Text(
                        'Ok',
                        style: normal14BlackStyle,
                      ))
                  : Container(),
            )
          ]),
      body: StreamBuilder(
          stream: BaseHelper.firestore
              .collection('users')
              .withConverter(
                  fromFirestore: UserModel.fromFireStore,
                  toFirestore: (UserModel user, options) => user.toFireStore())
              .where('role',
                  isEqualTo: isCoach == true
                      ?'coach'
                      : isClub
                          ? 'club'
                          : 'player')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
     
              doc = isClub
                  ? snapshot.data?.docs
                  : snapshot.data?.docs
                      .where((element) =>
                          element
                              .data()
                              .friends
                              ?.contains(BaseHelper.user?.email) ??
                          false)
                      .toList();
              if (doc!.isEmpty) {
                return Center(
                  child: Text(
                    context.loc.norecordfound,
                    style: heading22BlackStyle,
                  ),
                );
              } else {
                return lisview(
                  otherUser,
                  doc,
                );
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
}

ListView lisview(
  ValueNotifier<UserModel?> otherUser,
  List<DocumentSnapshot<UserModel>>? doc,
) {
  return ListView.separated(
      itemCount: doc?.length ?? 0,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: ((context, index) {
        UserModel users = doc?[index].data() as UserModel;
        double distance = Geolocator.distanceBetween(
                    BaseHelper.user?.lat?.toDouble() ?? 0.0,
                    BaseHelper.user?.long?.toDouble() ?? 0.0,
                    users.lat?.toDouble() ?? 0.0,
                    users.long?.toDouble() ?? 0.0)
                .round() /
            1000;
        return ValueListenableBuilder(
            valueListenable: otherUser,
            builder: (context, value, child) {
              return Container(
                color: otherUser.value?.email == doc?[index].data()?.email
                    ? Colors.green.shade100
                    : Colors.transparent,
                child: ContainerListTile(
                  isPremiumAcc: users.isPremiumAcc ?? false,
                  ontap: () async {
                    otherUser.value = doc?[index].data();
                  },
                  imagee: users.profilePhoto,
                  titletext: users.name,
                  subtitle: users.city,
                  friend: BaseHelper.user!.friends!
                      .contains(doc?[index].data()?.email),
                  distance: users.lat == null || users.lat == 0
                      ? ""
                      : "${distance.toStringAsFixed(1)} km ",
                  ratingValue:
                      double.tryParse(users.federationRanking ?? '0.0') ?? 0.0,
                ),
              );
            });
      }),
      separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 1,
            thickness: 1.2,
            color: AppColor.maincolor,
          ));
}
