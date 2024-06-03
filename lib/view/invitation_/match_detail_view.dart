import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/Model/match_invitation_model.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';
import 'package:flutter_wanna_play_app/view/invitation_/search_user_view.dart';
import 'package:flutter_wanna_play_app/widgets/app_bar_widget.dart';
import 'package:flutter_wanna_play_app/widgets/googlemapwidget.dart';
import 'package:flutter_wanna_play_app/widgets/textfield_widget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../widgets/circle_widget.dart';
import '../../widgets/custom_sized_box_widget.dart';

class MatchDetailView extends StatefulWidget {
  const MatchDetailView({
    super.key,
    required this.matchInvitationData,
  });

  final MatchInvitationModel matchInvitationData;
  @override
  State<MatchDetailView> createState() => _MatchDetailViewState();
}

class _MatchDetailViewState extends State<MatchDetailView> {
  Completer<GoogleMapController> googleMapController = Completer();
  List<Location>? loc;
  location(String address) async {
    await locationFromAddress(address).then((value) async {
      loc = value;
      final c = await googleMapController.future;

      c.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(loc?.first.latitude ?? 0.0, loc?.first.longitude ?? 0.0),
          14.0));
      setState(() {});
    });
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController.complete(controller);
  }

  @override
  void initState() {
    if (widget.matchInvitationData.selectedCircoloAddress != "") {
      location(widget.matchInvitationData.selectedCircoloAddress.toString());
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBarWidget(title: "Match Detail"),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          children: [
            20.height(),
            Center(
              child: SizedBox(
                width: width * 0.35,
                height: height * 0.2,
                child: CustomCircleAvatar(
                  radius: 20,
                  imageUrl: widget.matchInvitationData.opponentProfilePhoto,
                ),
              ),
            ),
            20.height(),
            Center(
              child: Text(
                widget.matchInvitationData.opponentEmail,
                style: heading22BlackStyle,
              ),
            ),
            20.height(),
            Center(
              child: Text(
                widget.matchInvitationData.matchStatus ?? '',
                style: title18BlackStyle,
              ),
            ),
            20.height(),
            Align(
              alignment: Alignment.center,
              child: Container(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${context.loc.selectClub} : ${widget.matchInvitationData.selectedCircoloName}",
                            style: title18WhiteStyle,
                          ),
                        ],
                      ),
                      Text(
                        " Seleted DateTime : ${DateFormat.MEd().format(widget.matchInvitationData.selectedDatetime)}",
                        style: title18WhiteStyle,
                      ),

                      // CustomSizedBox(
                      //   height: height * 0.01,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            if (widget.matchInvitationData.selectedCircoloAddress != "")
              Column(
                children: [
                  TextFields(
                      text: widget.matchInvitationData.selectedCircoloAddress
                          .toString()),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  const Divider(
                    color: AppColor.maincolor,
                    thickness: 2,
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
                  const Divider(
                    color: AppColor.maincolor,
                    thickness: 2,
                  ),
                ],
              )
          ],
        ));
  }
}
