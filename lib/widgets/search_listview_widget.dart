  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/controller/search_controller.dart';
import 'package:geolocator/geolocator.dart';



import '../helper/basehelper.dart';
import '../model/user_model.dart';
import '../utils/constant/colors.dart';
import 'custom_container.dart';

ListView searchListViewWidget(List<DocumentSnapshot<UserModel>>? doc,UserModel? users,bool friend) {
    return ListView.separated(
        itemCount: doc?.length ?? 0,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: ((context, index) {
          users = doc?[index].data();
          double distance = Geolocator.distanceBetween(
                      BaseHelper.user?.lat?.toDouble() ?? -0.0,
                      BaseHelper.user?.long?.toDouble() ?? -0.0,
                      users?.lat?.toDouble() ?? -0.0,
                      users?.long?.toDouble() ?? -0.0)
                  .round() /
              1000;
          return ContainerListTile(
            isPremiumAcc: users?.isPremiumAcc ?? false,
            ontap: () async {
           friend==true?   await GeneralSearchController.chechkFriend(
                  context, doc?[index].data()?.email ?? ''): await GeneralSearchController.selectedClub(
                  context, doc?[index].data()?.email ?? '');
            },
            imagee: users?.profilePhoto ?? "",
            titletext: users?.name ?? "",
            subtitle: users?.city ?? "",
            friend:
                BaseHelper.user!.friends!.contains(doc?[index].data()?.email),
            distance: users?.lat == null || users?.lat == 0
                ? ""
                : "${distance.toStringAsFixed(1)} km ",
            ratingValue:
                double.tryParse(users?.federationRanking ?? '0.0') ?? 0.0,
          );
        }),
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 1,
              thickness: 1.2,
              color: AppColor.maincolor,
            ));
  }