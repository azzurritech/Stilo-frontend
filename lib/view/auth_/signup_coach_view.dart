import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';

import 'package:intl/intl.dart';

import '../../controller/auth_controller.dart';
import '../../helper/basehelper.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../utils/constant/image_path.dart';
import '../../utils/validators.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/circle_widget.dart';
import '../../widgets/custom_sized_box_widget.dart';
import '../../widgets/dialog_box_widget.dart';
import '../../widgets/google_places_location_widget.dart';
import '../../widgets/popup.dart';
import '../../widgets/radio_button_widgets.dart';
import '../../widgets/textfield_widget.dart';

class SignUpCoachView extends StatefulWidget {
  const SignUpCoachView({super.key});

  @override
  State<SignUpCoachView> createState() => _SignUpCoachViewState();
}

class _SignUpCoachViewState extends State<SignUpCoachView> {
  bool updated = false;
  String leaderBoardRadio = "";
  bool privacyCheck = false;
  DateTime initialDate = DateTime.now();
  String? imageUrl;
  String? genderRadio;
  bool obsecureVar = true;
  String rankingRadio = "Yes";
  String federationRank = '';
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController dobController;

  late TextEditingController cityController;
  late TextEditingController federationLinkController;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    dobController = TextEditingController();

    cityController = TextEditingController();
    federationLinkController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.reset();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dobController.dispose();
    cityController.dispose();
    federationLinkController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        BaseHelper.hideKeypad(context);
        bool? shouldPop;
        if (updated == true) {
          shouldPop = await showDialog(
              context: context,
              builder: (context) => customDialogBox(context, onCancel: () {
                    Navigator.of(context).pop(false);
                  }, onOk: () {
                    Navigator.of(context).pop(true);
                  }));
        } else {
          shouldPop = true;
        }
        return Future.value(shouldPop);
      },
      child: Scaffold(
        appBar: AppBarWidget(
          background: Colors.transparent,
          title: "${context.loc.signUp} ${context.loc.coach}",
        ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 80, bottom: 20),
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomCircleAvatar(
                        radius: 60,
                        images: AppAssets.loginlogo,
                        imageUrl: imageUrl,
                      ),
                      Positioned(
                        top: 80,
                        left: 85,
                        child: Container(
                          width: 35,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              shape: BoxShape.circle),
                          child: IconButton(
                              onPressed: () async {
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
                                  imageUrl = downloadableLink;
                                  updated = true;
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
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 10),
                    child: TextFields(
                      text: context.loc.firstNameLastName,
                      controller: nameController,
                      onChanged: (va) {
                        if (va.toString().isNotEmpty) {
                          updated = true;
                        } else {
                          updated = false;
                        }
                      },
                      validator: (p0) => Validators.validateField(p0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFields(
                      text: context.loc.email,
                      controller: emailController,
                      onChanged: (va) {
                        if (va.toString().isNotEmpty) {
                          updated = true;
                        } else {
                          updated = false;
                        }
                      },
                      validator: (p0) => Validators.validateEmail(p0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFields(
                      text: context.loc.password,
                      controller: passwordController,
                      obsecureText: obsecureVar,
                      onChanged: (va) {
                        if (va.toString().isNotEmpty) {
                          updated = true;
                        } else {
                          updated = false;
                        }
                      },
                      validator: (p0) => Validators.validatePassword(p0),
                      suffixicon: IconButton(
                        onPressed: () {
                          setState(() {
                            obsecureVar = !obsecureVar;
                          });
                        },
                        icon: Icon(
                            obsecureVar
                                ? Icons.visibility_off_rounded
                                : Icons.remove_red_eye,
                            size: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFields(
                      controller: dobController,
                      text: context.loc.selectDob,
                      readOnly: true,
                      validator: (p0) => Validators.ageValidateField(p0),
                      onTap: () async {
                        final date = await BaseHelper.datePicker(context,
                            initialDate: initialDate);
                        if (date == null) return;
                        dobController.text =
                            DateFormat("MMM,dd,yyyy").format(date);

                        updated = true;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: TextFields(
                      controller: cityController,
                      validator: (p0) => Validators.validateField(p0),
                      text: context.loc.city,
                      readOnly: true,
                      onTap: () async {
                        await GooglePlaces.googlePlaccesLoc(context)
                            .then((value) {
                          if (value != "null") {
                            cityController.text = value.toString();
                            updated = true;
                            return;
                          }
                          updated = false;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.loc.gender, style: text_color),
                      Row(
                        children: [
                          CustomRadioButton(
                              val: genderRadio.toString(),
                              value: 'M',
                              text: 'M',
                              onChanged: (value) {
                                updated = true;
                                setState(() {
                                  genderRadio = value!;
                                });
                              }),
                          CustomRadioButton(
                              val: genderRadio.toString(),
                              value: 'F',
                              text: 'F',
                              onChanged: (value) {
                                updated = true;
                                setState(() {
                                  genderRadio = value!;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.loc.federationRanking, style: text_color),
                      Row(
                        children: [
                          CustomRadioButton(
                              val: rankingRadio,
                              value: "Yes",
                              text: context.loc.yes,
                              onChanged: (value) {
                                updated = true;
                                BaseHelper.hideKeypad(context);
                                setState(() {
                                  federationRank = "";
                                  rankingRadio = value!;
                                });
                              }),
                          CustomRadioButton(
                              val: rankingRadio,
                              value: 'No',
                              text: context.loc.no,
                              onChanged: (value) {
                                updated = true;
                                setState(() {
                                  rankingRadio = value!;

                                  popup(
                                    context,
                                  ).then((valu) {
                                    if (valu.toString() == "") {
                                      federationRank = "";
                                      rankingRadio = "";
                                    } else {
                                      federationRank = valu.toString();
                                    }

                                    setState(() {});
                                  });
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                  if (rankingRadio == "Yes")
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 2),
                      child: TextFields(
                        controller: federationLinkController,
                        validator: (p0) => Validators.urlValidate(p0),
                        onChanged: (va) {
                          if (va.toString().isNotEmpty) {
                            updated = true;
                          } else {
                            updated = false;
                          }
                        },
                        text: context.loc.link,
                      ),
                    ),
                  if (federationRank != '')
                    rankingRadio != "Yes"
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      AppColor.hinttext_color.withOpacity(0.5)),
                              child: Text(
                                federationRank.toString(),
                                style: title20BlackStyle,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(context.loc.federationRanking,
                                  style: text_color),
                              CustomSizedBox(
                                width: width * 0.05,
                              ),
                              Text(
                                federationRank.toString(),
                                style: title20BlackStyle,
                              )
                            ],
                          ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Mantieni la classifica", style: text_color),
                      Row(
                        children: [
                          CustomRadioButton(
                              val: leaderBoardRadio,
                              value: 'Yes',
                              text: context.loc.yes,
                              onChanged: (value) {
                                updated = true;
                                BaseHelper.hideKeypad(context);
                                setState(() {
                                  leaderBoardRadio = value!;
                                });
                              }),
                          CustomRadioButton(
                              val: leaderBoardRadio,
                              value: 'No',
                              text: context.loc.no,
                              onChanged: (value) {
                                updated = true;
                                setState(() {
                                  leaderBoardRadio = value!;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 39,
                  ),
                  Text(
                    context.loc.privacyPolicyHeading,
                    style: newtextcolour,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: privacyCheck,
                          activeColor: Colors.green,
                          onChanged: ((value) {
                            updated = true;
                            setState(() {
                              privacyCheck = value!;
                            });
                          })),
                      Text(
                        context.loc.privacyPolicy,
                        style: title18BlackStyle,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 53,
                  ),
                  CustomButton(
                      color: AppColor.divivdercolor,
                      height: height * 0.06,
                      width: width * 0.8,
                      text: context.loc.register,
                      onpressed: () {
                        if (formKey.currentState!.validate()) {
                          Auth.signUp(context,
                              city: cityController.text,
                              dob: dobController.text,
                              email: emailController.text.toLowerCase().trim(),
                              federationLink: federationLinkController.text,
                              federationRank: federationRank.toString(),
                              genderRadio: genderRadio.toString(),
                              imageUrl: imageUrl.toString(),
                              name: nameController.text,
                              password: passwordController.text.trim(),
                  
                              rankingRadio: rankingRadio,
                              leaderBoardRadio: leaderBoardRadio);
                        } else {
                          return;
                        }
                      }),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
