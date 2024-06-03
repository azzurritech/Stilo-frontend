import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';

import 'package:flutter_wanna_play_app/widgets/textfield_widget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../controller/match_controller.dart';
import '../../helper/basehelper.dart';

import '../../model/user_model.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../utils/constant/image_path.dart';
import '../../view/invitation_/search_user_view.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/circle_widget.dart';
import '../../widgets/googlemapwidget.dart';

class MakeMatchLessonView extends StatefulWidget {
  final bool isLesson;
  const MakeMatchLessonView({super.key, required this.isLesson});

  @override
  State<MakeMatchLessonView> createState() => _MakeMatchLessonViewState();
}

class _MakeMatchLessonViewState extends State<MakeMatchLessonView> {
  ValueNotifier<UserModel?> otherUser = ValueNotifier(null);
  ValueNotifier<UserModel?> circolo = ValueNotifier(null);

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

  DateTime dateTime = DateTime(
    2000,
    12,
    12,
  );
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(
        title: widget.isLesson == true ? context.loc.lesson : context.loc.match,
        action: [
          InkWell(
            onTap: () async {
              MatchController.makeAMatch(
                  context, otherUser.value, circolo.value, dateTime);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  color: AppColor.buttonGreencolor,
                  borderRadius: BorderRadius.circular(18)),
              child: Text(
                'Done',
                style: subTitle16BlackStyle,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 27.0, horizontal: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      CustomCircleAvatar(
                          radius: 50,
                          imageUrl: BaseHelper.user?.profilePhoto.toString()),
                      Text(
                        BaseHelper.user?.name.toString() ?? "",
                        style: title18BlackStyle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Vs",
                        style: vscolor,
                      ),
                      Image.asset(AppAssets.lessonball)
                    ],
                  ),
                  otherUser.value == null
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => SelectUsersView(
                                  isCoach: widget.isLesson,
                                  isClub: false,
                                  otherUser: otherUser),
                            ))
                                .then(
                              (value) {
                                if (value != null) {
                                  otherUser.value = value;
                                  setState(() {});
                                }
                              },
                            );
                          },
                          child: Text(widget.isLesson == true
                              ? context.loc.searchCoach
                              : context.loc.searchUser))
                      : Column(
                          children: [
                            CustomCircleAvatar(
                              radius: 50,
                              imageUrl: otherUser.value?.profilePhoto,
                            ),
                            Text(
                              otherUser.value?.name ?? "",
                              style: title18BlackStyle,
                            )
                          ],
                        ),
                ],
              ),
              SizedBox(
                height: height * 0.04,
              ),
              circolo.value != null
                  ? Column(
                      children: [
                        TextFields(text: circolo.value?.city.toString() ?? ""),
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
                  : InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => SelectUsersView(
                              isCoach: false, isClub: true, otherUser: circolo),
                        ))
                            .then(
                          (value) {
                            if (value != null) {
                              circolo.value = value;

                              location(circolo.value?.city.toString() ?? "");
                              setState(() {});
                            }
                          },
                        );
                      },
                      child: Text(context.loc.selectClub)),
              SizedBox(
                height: height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                            height: height * 0.04,
                            width: width * 0.4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        2, 9), // changes position of shadow
                                  ),
                                ],
                                color: AppColor.containercolor,
                                borderRadius: BorderRadius.circular(18)),
                            child: InkWell(
                              onTap: () async {
                                await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(DateTime.now()
                                            .add(const Duration(days: 365))
                                            .year))
                                    .then((value) {
                                  if (value != null) {
                                    dateTime = DateTime(
                                        value.year,
                                        value.month,
                                        value.day,
                                        dateTime.hour,
                                        dateTime.minute);

                                    setState(() {});
                                  }
                                });
                              },
                              child: Text(
                                dateTime.year == 2000
                                    ? context.loc.selectDate
                                    : "Date:${DateFormat("dd.MM.yyyy").format(dateTime)} ",
                                style: subTitle16BlackStyle,
                              ),
                            )),
                      ],
                    ),
                    Container(
                      height: height * 0.04,
                      width: width * 0.3,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  2, 9), // changes position of shadow
                            ),
                          ],
                          color: AppColor.containercolor,
                          borderRadius: BorderRadius.circular(18)),
                      child: InkWell(
                        onTap: () async {
                          await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            if (value != null) {
                              dateTime = DateTime(dateTime.year, dateTime.month,
                                  dateTime.day, value.hour, value.minute);

                              setState(() {});
                            }
                          });
                        },
                        child: Text(
                          dateTime.hour == 0
                              ? context.loc.selectTime
                              : "Time: ${DateFormat('hh mm').format(dateTime)}",
                          style: subTitle16BlackStyle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
