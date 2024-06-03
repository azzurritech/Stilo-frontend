import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';
import 'package:flutter_wanna_play_app/widgets/cache_network_widget.dart';

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../helper/basehelper.dart';
import '../../model/user_model.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';

import '../../widgets/app_bar_widget.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/circle_widget.dart';
import '../../widgets/googlemapwidget.dart';

import 'package:maps_launcher/maps_launcher.dart';

class ClubProfileView extends StatefulWidget {
  const ClubProfileView({super.key, required this.email});
  final String email;

  @override
  State<ClubProfileView> createState() => _ClubProfileViewState();
}

class _ClubProfileViewState extends State<ClubProfileView> {
  Completer<GoogleMapController> googleMapController = Completer();

  List<Location>? loc;
  location(String address) async { 
    loc = await locationFromAddress(address);
    final c = await googleMapController.future;
    c.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc?.first.latitude ?? 0.0, loc?.first.longitude ?? 0.0),
        zoom: 14)));
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: BaseHelper.firestore
            .collection("users")
            .doc(widget.email)
            .withConverter(
              fromFirestore: UserModel.fromFireStore,
              toFirestore: (value, options) => value.toFireStore(),
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel user = snapshot.data?.data() as UserModel;
            location(user.city.toString());

            return Scaffold(
              appBar: AppBarWidget(
                title: user.name,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    SizedBox(
                      width: 182,
                      height: 182,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: cacheNetworkWidget(context, imageUrl: user.profilePhoto))
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Text(
                      user.email,
                      style: heading22BlackStyle,
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    // CustomRating(value: ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                            child: Text(
                         context.loc.wellKept,
                          style: normal14LightGreyStyle.copyWith(
                              fontWeight: FontWeight.w500),
                        )),
                        // Flexible(child: CustomRating())
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          context.loc.organizesManyTournaments,
                          style: normal14LightGreyStyle.copyWith(
                              fontWeight: FontWeight.w500),
                        ),
                        // CustomRating()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          context.loc.valueForMoney,
                          style: normal14LightGreyStyle.copyWith(
                              fontWeight: FontWeight.w500),
                        ),
                        // CustomRating()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                         context.loc.courtesyAndAvailability,
                          style: normal14LightGreyStyle.copyWith(
                              fontWeight: FontWeight.w500),
                        ),
                        // CustomRating()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          context.loc.professionalism,
                          style: normal14LightGreyStyle.copyWith(
                              fontWeight: FontWeight.w500),
                        ),
                        // CustomRating()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${context.loc.services}:",
                                  style: subTitle16LightGreyStyle,
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: user.serviz?.length,
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  itemBuilder: (context, index) => Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            user.serviz?[index],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Column(
                              children: [
                                Text(
                                  context.loc.fields,
                                  style: subTitle16LightGreyStyle,
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  itemCount: user.campi?.length,
                                  itemBuilder: (context, index) => Container(
                                      alignment: Alignment.topCenter,
                                      child: Text(user.campi?[index])),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    if (user.city != "")
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 45),
                        child: Row(
                          children: [
                            Text(
                              "${context.loc.address}:",
                              style: subTitle16LightGreyStyle,
                            ),
                            const SizedBox(
                              width: 45,
                            ),
                            Expanded(
                              child: Text(
                                user.city.toString(),
                                style: subTitle16BlackStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    if (user.phoneNumber != "")
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 45),
                        child: Row(
                          children: [
                            Text(
                              context.loc.telefono,
                              style: subTitle16LightGreyStyle,
                            ),
                            const SizedBox(
                              width: 45,
                            ),
                            Expanded(
                              child: Text(
                                user.phoneNumber.toString(),
                                style: subTitle16BlackStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                    SizedBox(
                      height: height * 0.01,
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 45),
                      child: Row(
                        children: [
                          Text(
                            "Email:",
                            style: subTitle16LightGreyStyle,
                          ),
                          const SizedBox(
                            width: 75,
                          ),
                          Expanded(
                            child: Text(
                              user.email,
                              style: subTitle16BlackStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                            color: AppColor.buttonnewcolor,
                            width: width * 0.35,
                            height: height * 0.05,
                            text: context.loc.call,
                            onpressed: () {
                              user.phoneNumber != ''
                                  ? _launchURL(
                                      Uri.parse('tel:${user.phoneNumber}'))
                                  : BaseHelper.showSnackBar(
                                      context, 'No Number found');
                              // popupaccpet(
                              //   context,
                              // );
                            }),
                        CustomButton(
                            width: width * 0.48,
                            color: AppColor.buttonnewcolor,
                            height: height * 0.05,
                            text: context.loc.showDirections,
                            onpressed: () {
                              MapsLauncher.launchCoordinates(
                                  loc?.first.latitude ?? 0.0,
                                  loc?.first.longitude ?? 0.0);
                              // String a =
                              //     'https://www.google.com/maps/search/?api=1&query=' +
                              //         user.lat.toString() +
                              //         ',' +
                              //         user.long.toString() +
                              //         ' &destination=' +
                              //         loc.first.latitude.toString() +
                              //         ',' +
                              //         loc.first.longitude.toString();
                              // Uri url = Uri.parse(a);
                              // _launchURL(url);
                            }),
                        SizedBox(
                          height: height * 0.1,
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: GoogleMapWidget(
                          lat: loc?.first.latitude ?? 0.0,
                          long: loc?.first.longitude ?? 0.0,
                          onMapCreated: onMapCreated,
                          markers: {
                            Marker(
                              markerId: const MarkerId('1'),
                              position: LatLng(loc?.first.latitude ?? 0.0,
                                  loc?.first.longitude ?? 0.0),
                            )
                          },
                        )),
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

  void _launchURL(Uri url) async {
    if (await launchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
