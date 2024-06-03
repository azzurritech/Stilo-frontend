// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_wanna_play_app/utils/enums.dart';

import '../utils/constant/colors.dart';
import '../utils/constant/heading_text_style.dart';
import 'circle_widget.dart';
import 'rating_star.dart';

class ContainerListTile extends StatelessWidget {
  String titletext;
  String subtitle;

  String imagee;
  double ratingValue;
  void Function()? ontap;
  RoleName? role;
  String? distance;
  bool friend;
  bool isPremiumAcc;
  ContainerListTile({
    Key? key,
    required this.titletext,
    required this.subtitle,
    required this.ratingValue,
    required this.friend,
    required this.isPremiumAcc,
    this.distance,
    required this.imagee,
    required this.ontap,
    this.role,
  }) : super(key: key);

  late double value = ratingValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: Column(
        children: [
          isPremiumAcc == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(right: 20, left: 20, bottom: 5),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.starcolor),
                      child: Text(
                        "Top Ranked Player",
                        style: small12BlackStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.textcolor),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: AppColor.starcolor),
                      child: Text(
                        "Premium",
                        style: small12BlackStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.textcolor),
                      ),
                    ),
                  ],
                )
              : Container(),
          ListTile(
            onTap: ontap,
            leading: SizedBox(
              height: 55,
              width: 55,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(130),
                child: CachedNetworkImage(
                       errorWidget: (context, url, error) {
                         return const Icon(Icons.error);
                       },
                           progressIndicatorBuilder: (context, url, progress) {
                 return Center(child: CircularProgressIndicator.adaptive(
                  value:progress.progress,
                
                 ),);
                           },
                  imageUrl: imagee,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              titletext,
              style: isPremiumAcc == true
                  ? subTitle16WhiteStyle.copyWith(color: AppColor.starcolor)
                  : normal14BlackStyle,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: isPremiumAcc == true
                      ? subTitle16WhiteStyle.copyWith(color: AppColor.starcolor)
                      : normal14LightGreyStyle,
                ),
                FittedBox(
                  child: CustomRating(
                    valueLabelColor:
                        isPremiumAcc == true ? AppColor.starcolor : null,
                    value: value,
                  ),
                )
              ],
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: friend == true
                  ? MainAxisAlignment.spaceBetween
                  : distance == null
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.center,
              children: [
                if (friend == true)
                  Icon(Icons.group,
                      color: isPremiumAcc == true
                          ? AppColor.starcolor
                          : AppColor.privacy_color),
                distance == null
                    ? Text(
                        role?.name ?? RoleName.none.name,
                        style: isPremiumAcc == true
                            ? subTitle16WhiteStyle.copyWith(
                                color: AppColor.starcolor)
                            : normal14BlackStyle,
                      )
                    : Text(
                        distance ?? "",
                        style: isPremiumAcc == true
                            ? subTitle16WhiteStyle.copyWith(
                                color: AppColor.starcolor)
                            : normal14BlackStyle.copyWith(
                                color: AppColor.maincolor),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
