import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_wanna_play_app/controller/create_group_controller.dart';

import 'package:flutter_wanna_play_app/utils/constant/heading_text_style.dart';
import 'package:flutter_wanna_play_app/utils/validators.dart';
import 'package:flutter_wanna_play_app/widgets/app_bar_widget.dart';
import 'package:flutter_wanna_play_app/widgets/button_widgets.dart';
import 'package:flutter_wanna_play_app/widgets/list_tile_widget.dart';
import 'package:flutter_wanna_play_app/widgets/textfield_widget.dart';

import '../../controller/auth_controller.dart';
import '../../helper/basehelper.dart';
import '../../utils/constant/image_path.dart';
import '../../widgets/circle_widget.dart';
import '../../widgets/dialog_box_widget.dart';

class CreateGroupView extends StatefulWidget {
  final List memberList;
  const CreateGroupView({super.key, required this.memberList});

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  late GlobalKey<FormState> formKey;
  String? imageUrl;
  late TextEditingController groupName;
  late TextEditingController groupDescription;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    groupName = TextEditingController();
    groupDescription = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'New Group', action: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: ButtonWidget(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  CreateGroupCOntroller.createGroup(context,
                      groupName: groupName.text,
                      memberLIst: widget.memberList,
                      groupDescription: groupDescription.text,
                      imageUrl: imageUrl);
                } else {
                  return;
                }
              },
              circularRadius: 16,
              text: 'Create'),
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      CustomCircleAvatar(
                        radius: 40,
                        images: AppAssets.loginlogo,
                        imageUrl: imageUrl.toString(),
                      ),
                      Positioned(
                        bottom: -15,
                        right: 0,
                        child: Container(
                          width: 35,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              shape: BoxShape.circle),
                          child: IconButton(
                              onPressed: () async {
                                BaseHelper.hideKeypad(context);
                                String? downloadableLink;
                                File? imageVar =
                                    await BaseHelper.imagePickerSheet(context);

                                if (imageVar != null) {
                                  await Auth.uploadImage(
                                    imageVar,
                                    context,
                                  ).then((value) => downloadableLink = value);
                                }
                                setState(() {
                                  imageUrl = downloadableLink.toString();
                                });
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                                size: 18,
                              )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: TextFields(
                    controller: groupName,
                    text: 'Enter Group Name',
                    validator: (p0) => Validators.validateField(p0),
                  ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFields(
                  controller: groupDescription,
                  height: null,
                  text: 'Enter group Description',
                  minLines: 1,
                  maxLines: 4,
                ),
              ),
              Text(
                'Particpants  -  ${widget.memberList.length - 1}',
                style: heading22BlackStyle,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.memberList.length - 1,
                  itemBuilder: (context, index) {
                    List listData = widget.memberList
                        .where((element) =>
                            element['email'] !=
                            BaseHelper.user?.email.toString())
                        .toList();
                    Map<String, dynamic> data = listData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CustomListTile(
                          subTitleText: data['email'],
                          leadingWidget: CustomCircleAvatar(
                              radius: 30, imageUrl: data['profilePhoto']),
                          titleText: data['name'],
                          trailingWidget: InkWell(
                              onTap: () {
                                widget.memberList.removeWhere((element) =>
                                    element['email'] ==
                                    listData[index]["email"]);
                                setState(() {});
                              },
                              child: const Icon(Icons.close))),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
