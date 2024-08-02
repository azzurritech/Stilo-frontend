import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/Firebase/firebase_methods.dart';
import 'package:flutter_wanna_play_app/utils/enums.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../../controller/account_setting_controller.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/home_page_controller.dart';

import '../../../helper/basehelper.dart';
import '../../../service/geolocator.dart';
import '../../../utils/constant/button_text_style.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/constant/heading_text_style.dart';
import '../../../utils/validators.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/chechk_listTile_widget.dart';
import '../../../widgets/circle_widget.dart';
import '../../../widgets/custom_sized_box_widget.dart';
import '../../../widgets/dialog_box_widget.dart';

import '../../../widgets/list_tile_widget.dart';
import '../../../widgets/popup.dart';
import '../../../widgets/radio_button_widgets.dart';
import '../../../widgets/textfield_widget.dart';

class AccountSettingView extends StatefulWidget {
  const AccountSettingView({super.key, required this.willPopValue});
  final bool willPopValue;

  @override
  State<AccountSettingView> createState() => _AccountSettingViewState();
}

class _AccountSettingViewState extends State<AccountSettingView> {
  ValueNotifier isLoading = ValueNotifier(false);
  late TextEditingController federationLinkAccountController;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController dobController;
  late TextEditingController cityController;
  late TextEditingController addressController;
  late GlobalKey<FormState> formKey;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    isLoading.value = true;
    federationLinkAccountController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    dobController = TextEditingController();
    cityController = TextEditingController();
    addressController = TextEditingController();

    if (widget.willPopValue == false) {
      getLoc();
    }
    values();
    // TODO: implement initState
    super.initState();
  }

  Future<bool?> getLoc() async {
    await LocPermission.handleLocationPermission(context).then((value) {
      if (value == true) {
        Geolocator.getCurrentPosition().then((event) async {
          await HomePageController.getAddressFromLatLng(context, event)
              .then((value) {
            if (value == true) {
              cityController.text = BaseHelper.user?.city ?? "";
              setState(() {});
            }
          });
        });
      }
    });
    return null;
  }

  @override
  void dispose() {
    federationLinkAccountController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dobController.dispose();
    cityController.dispose();

    addressController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  values() async {
    if (widget.willPopValue == true) {
      await FirebaseMethod.getUserData();
    }
    AccountSettingController.imageFile =
        BaseHelper.currentUser?.photoURL.toString() ?? "";
    AccountSettingController.seviziItemAdded.clear();
    AccountSettingController.campiItemAdded.clear();
    AccountSettingController.seviziItemAdded
        .addAll(BaseHelper.user?.serviz?.toList() ?? []);

    AccountSettingController.campiItemAdded
        .addAll(BaseHelper.user?.campi?.toList() ?? []);
    AccountSettingController.gender = BaseHelper.user?.gender ?? '';
    nameController.text = BaseHelper.user?.name ?? "";
    emailController.text = BaseHelper.currentUser?.email ?? "";
    passwordController.text = BaseHelper.user?.password ?? "";
    dobController.text = BaseHelper.user?.dob ?? "";
    cityController.text = BaseHelper.user?.city ?? "";

    AccountSettingController.rankingRadioAccount =
        BaseHelper.user?.isFederationRanking ?? "";
    AccountSettingController.roleRadioAccount =
        BaseHelper.user?.role == RoleName.none
            ? RoleName.none
            : BaseHelper.user?.role ?? RoleName.none;
    federationLinkAccountController.text =
        BaseHelper.user?.federationLink ?? "";
    isLoading.value = false;
  }

  DateTime initialDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        BaseHelper.hideKeypad(context);

        if (widget.willPopValue == true &&
            AccountSettingController.isEdit == true) {
          var shouldPop = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => customDialogBox(context,
                      title: context.loc.yourChangesWillBeLost, onCancel: () {
                    Navigator.of(context).pop(false);
                  }, onOk: () {
                    AccountSettingController.isEdit = false;

                    Navigator.of(context).pop(true);
                  }));
          return Future.value(shouldPop);
        } else {
          return Future.value(widget.willPopValue);
        }
      },
      child: Scaffold(
        appBar: AppBarWidget(title: context.loc.profileSetting),
        body: ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (_, value, child) {
              return value == true
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                          bottom: 30, left: 30, right: 30, top: 20),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  AccountSettingController.isEdit = true;

                                  setState(() {});
                                  AccountSettingController.isEdit == true
                                      ? BaseHelper.showSnackBar(
                                          context, 'You can now edit  ')
                                      : null;
                                },
                                child: Text(
                                  AccountSettingController.isEdit == false
                                      ? "Edit"
                                      : '',
                                  style: subTitle16BlackStyle,
                                ))
                          ],
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomCircleAvatar(
                                radius: 60,
                                imageUrl: AccountSettingController.imageFile),
                            if (AccountSettingController.isEdit == true)
                              Positioned(
                                right: width * 0.27,
                                top: 80,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                        onPressed: () async {
                                          String? downloadableLink;
                                          File? imageVar =
                                              await BaseHelper.imagePickerSheet(
                                                  context);

                                          if (imageVar != null) {
                                            await Auth.uploadImage(
                                              imageVar,
                                              context,
                                            ).then((value) {
                                              downloadableLink = value;
                                              setState(() {
                                                AccountSettingController
                                                        .imageFile =
                                                    downloadableLink.toString();
                                              });
                                            });
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey,
                                          size: 18,
                                        )),
                                  ),
                                ),
                              )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: TextFields(
                            readOnly: AccountSettingController.isEdit == true
                                ? false
                                : true,
                            controller: nameController,
                            text: 'Matteo Berrettini',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFields(
                            readOnly: AccountSettingController.isEdit == true &&
                                    BaseHelper.currentUser?.providerData.first
                                            .providerId
                                            .toString() !=
                                        'facebook.com' &&
                                    BaseHelper.currentUser?.providerData.first
                                            .providerId
                                            .toString() !=
                                        'google.com' &&
                                    BaseHelper.currentUser?.providerData.first
                                            .providerId
                                            .toString() !=
                                        'apple.com'
                                ? false
                                : true,
                            controller: emailController,
                            text: 'giocatore@wannaplay.it',
                          ),
                        ),
                        if (BaseHelper
                                    .currentUser?.providerData.first.providerId
                                    .toString() !=
                                'google.com' &&
                            BaseHelper
                                    .currentUser?.providerData.first.providerId
                                    .toString() !=
                                'facebook.com' &&
                            BaseHelper
                                    .currentUser?.providerData.first.providerId
                                    .toString() !=
                                'apple.com')
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFields(
                              readOnly: AccountSettingController.isEdit == true
                                  ? false
                                  : true,
                              controller: passwordController,
                              text: '*************',
                            ),
                          ),
                        if (AccountSettingController.roleRadioAccount !=
                            RoleName.club)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Form(
                              key: formKey,
                              child: TextFields(
                                readOnly: AccountSettingController.isEdit ==
                                            true &&
                                        BaseHelper.currentUser?.providerData
                                                .first.providerId
                                                .toString() ==
                                            'apple.com' &&
                                        BaseHelper.user?.dob.toString() == ""
                                    ? false
                                    : true,
                                controller: dobController,
                                validator: (p0) =>
                                    Validators.ageValidateField(p0),
                                onTap: AccountSettingController.isEdit ==
                                            true &&
                                        BaseHelper.currentUser?.providerData
                                                .first.providerId
                                                .toString() ==
                                            'apple.com' &&
                                        BaseHelper.user?.dob.toString() == ""
                                    ? () async {
                                        final date =
                                            await BaseHelper.datePicker(context,
                                                initialDate: initialDate);
                                        if (date == null) return;
                                        dobController.text =
                                            DateFormat('MMM,dd,yyyy')
                                                .format(date);
                                        setState(() {});
                                      }
                                    : null,
                                text: '24/12/1995',
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFields(
                            readOnly: true,
                            controller: cityController,
                            text: 'Milano',
                          ),
                        ),
                        if (AccountSettingController.roleRadioAccount ==
                            RoleName.club)
                          Column(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: Container(
                                        color: AppColor.textfield_color,
                                        child: ExpansionTile(
                                          title: AccountSettingController
                                                  .seviziItemAdded.isNotEmpty
                                              ? Wrap(
                                                  children:
                                                      AccountSettingController
                                                          .seviziItemAdded
                                                          .map((e) {
                                                    return Text(
                                                      "${e.toString()}, ",
                                                      style:
                                                          subTitle16BlackStyle,
                                                    );
                                                  }).toList(),
                                                )
                                              : Text(
                                                  "Sevizi",
                                                  style: hint_text,
                                                ),
                                          children: [
                                            Container(
                                              height: 15,
                                              color: Colors.white,
                                            ),
                                            ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  AccountSettingController
                                                      .seviziList.length,
                                              itemBuilder: (context, index) {
                                                return checkListTile(
                                                    checkValue: AccountSettingController
                                                        .seviziItemAdded
                                                        .contains(
                                                            AccountSettingController
                                                                    .seviziList[
                                                                index]),
                                                    titleText:
                                                        AccountSettingController
                                                            .seviziList[index],
                                                    onChanged:
                                                        AccountSettingController
                                                                    .isEdit ==
                                                                true
                                                            ? (p0) {
                                                                if (p0 ==
                                                                    true) {
                                                                  AccountSettingController
                                                                      .seviziItemAdded
                                                                      .add(AccountSettingController
                                                                              .seviziList[
                                                                          index]);
                                                                } else {
                                                                  AccountSettingController
                                                                      .seviziItemAdded
                                                                      .remove(AccountSettingController
                                                                              .seviziList[
                                                                          index]);
                                                                }

                                                                setState(() {});
                                                              }
                                                            : null);
                                              },
                                            ),
                                          ],
                                        ),
                                      ))),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: Container(
                                        color: AppColor.textfield_color,
                                        child: ExpansionTile(
                                            title: AccountSettingController
                                                    .campiItemAdded.isNotEmpty
                                                ? Wrap(
                                                    children:
                                                        AccountSettingController
                                                            .campiItemAdded
                                                            .map((e) {
                                                      return Text(
                                                        "${e.toString()}, ",
                                                        style:
                                                            subTitle16BlackStyle,
                                                      );
                                                    }).toList(),
                                                  )
                                                : Text(
                                                    "Campi",
                                                    style: hint_text,
                                                  ),
                                            children: [
                                              Container(
                                                height: 15,
                                                color: Colors.white,
                                              ),
                                              ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    AccountSettingController
                                                        .campiList.length,
                                                itemBuilder: (context, index) {
                                                  return checkListTile(
                                                      checkValue: AccountSettingController
                                                          .campiItemAdded
                                                          .contains(
                                                              AccountSettingController
                                                                      .campiList[
                                                                  index]),
                                                      titleText:
                                                          AccountSettingController
                                                              .campiList[index],
                                                      onChanged:
                                                          AccountSettingController
                                                                      .isEdit ==
                                                                  true
                                                              ? (p0) {
                                                                  if (p0 ==
                                                                      true) {
                                                                    AccountSettingController
                                                                        .campiItemAdded
                                                                        .add(AccountSettingController
                                                                            .campiList[index]);
                                                                  } else {
                                                                    AccountSettingController
                                                                        .campiItemAdded
                                                                        .remove(
                                                                            AccountSettingController.campiList[index]);
                                                                  }

                                                                  setState(
                                                                      () {});
                                                                }
                                                              : null);
                                                },
                                              )
                                            ]),
                                      ))),
                            ],
                          ),
                        if (AccountSettingController.roleRadioAccount !=
                            RoleName.club)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  context.loc.gender,
                                  style: hint_text,
                                ),
                                AccountSettingController.gender == "" ||
                                        BaseHelper.user?.gender == ""
                                    ? Row(
                                        children: [
                                          CustomRadioButton(
                                              val: AccountSettingController
                                                  .gender,
                                              value: "M",
                                              text: 'M',
                                              onChanged:
                                                  AccountSettingController
                                                          .isEdit
                                                      ? ((value) async {
                                                          AccountSettingController
                                                              .gender = "M";
                                                          setState(() {});
                                                        })
                                                      : null),
                                          CustomRadioButton(
                                              val: AccountSettingController
                                                  .gender,
                                              value: "F",
                                              text: 'F',
                                              onChanged:
                                                  AccountSettingController
                                                          .isEdit
                                                      ? ((value) async {
                                                          AccountSettingController
                                                              .gender = "F";
                                                          setState(() {});
                                                        })
                                                      : null)
                                        ],
                                      )
                                    : AccountSettingController.gender == 'M' &&
                                            BaseHelper.user?.gender != ""
                                        ? CustomRadioButton(
                                            val:
                                                AccountSettingController.gender,
                                            value: "M",
                                            text: 'M',
                                            onChanged: ((value) async {}))
                                        : CustomRadioButton(
                                            val:
                                                AccountSettingController.gender,
                                            value: "F",
                                            text: 'F',
                                            onChanged: ((value) async {}))
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 30),
                          child: Column(
                            children: [
                              if (AccountSettingController.roleRadioAccount !=
                                  RoleName.club)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Federazione ranking",
                                        style: text_color),
                                    Row(
                                      children: [
                                        CustomRadioButton(
                                            val: AccountSettingController
                                                .rankingRadioAccount,
                                            value: 'Yes',
                                            text: 'Yes',
                                            onChanged: AccountSettingController
                                                        .isEdit ==
                                                    true
                                                ? (value) {
                                                    BaseHelper.hideKeypad(
                                                        context);

                                                    setState(() {
                                                      AccountSettingController
                                                          .federationRankAccount = "";
                                                      AccountSettingController
                                                              .rankingRadioAccount =
                                                          value!;
                                                    });
                                                  }
                                                : null),
                                        CustomRadioButton(
                                            val: AccountSettingController
                                                .rankingRadioAccount,
                                            value: 'No',
                                            text: 'No',
                                            onChanged: AccountSettingController
                                                        .isEdit ==
                                                    true
                                                ? (value) {
                                                    BaseHelper.hideKeypad(
                                                        context);

                                                    setState(() {
                                                      AccountSettingController
                                                              .rankingRadioAccount =
                                                          value!;
                                                    });
                                                    popup(
                                                      context,
                                                    ).then((valu) {
                                                      if (valu.toString() ==
                                                          "") {
                                                        AccountSettingController
                                                            .federationRankAccount = "";
                                                        AccountSettingController
                                                            .rankingRadioAccount = "";
                                                      } else {
                                                        AccountSettingController
                                                                .federationRankAccount =
                                                            valu.toString();
                                                      }

                                                      setState(() {});
                                                    });
                                                  }
                                                : null),
                                      ],
                                    ),
                                  ],
                                ),
                              if (AccountSettingController
                                          .rankingRadioAccount ==
                                      "Yes" &&
                                  AccountSettingController.roleRadioAccount !=
                                      RoleName.club)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, bottom: 2),
                                  child: TextFields(
                                    controller: federationLinkAccountController,
                                    validator: (p0) =>
                                        Validators.urlValidate(p0),
                                    text: 'Link',
                                  ),
                                ),
                              if (AccountSettingController
                                          .federationRankAccount !=
                                      '' &&
                                  AccountSettingController.roleRadioAccount !=
                                      RoleName.club)
                                AccountSettingController.rankingRadioAccount !=
                                        "Yes"
                                    ? Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 15),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: AppColor.hinttext_color
                                                  .withOpacity(0.5)),
                                          child: Text(
                                            AccountSettingController
                                                .federationRankAccount
                                                .toString(),
                                            style: title20BlackStyle,
                                          ),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(context.loc.federationRanking,
                                              style: text_color),
                                          CustomSizedBox(
                                            width: width * 0.05,
                                          ),
                                          Text(
                                            AccountSettingController
                                                .federationRankAccount
                                                .toString(),
                                            style: title20BlackStyle,
                                          )
                                        ],
                                      ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Role", style: text_color),
                                  ButtonWidget(
                                    btnColor: AccountSettingController
                                                .roleRadioAccount ==
                                            BaseHelper.user?.role
                                        ? null
                                        : AppColor.refusecolor,
                                    circularRadius: 20,
                                    style: normal14BlackStyle.copyWith(
                                        color: AppColor.textcolor),
                                    text: AccountSettingController
                                                .roleRadioAccount ==
                                            RoleName.none
                                        ? "Choose your role"
                                        : AccountSettingController
                                            .roleRadioAccount.name,
                                    onPressed: () async {
                                      AccountSettingController.isEdit == true
                                          ? await showModalBottomSheet(
                                              backgroundColor: Colors
                                                  .transparent,
                                              context: context,
                                              builder: (context) =>
                                                  RoleSelectionSheet(
                                                      roleRadioAccount:
                                                          AccountSettingController
                                                              .roleRadioAccount,
                                                      roleRadioAccountList:
                                                          RoleName
                                                              .values)).then(
                                              (value) {
                                              if (value != null) {
                                                setState(() {});
                                                AccountSettingController
                                                    .roleRadioAccount = value;
                                              }
                                            })
                                          : BaseHelper.showSnackBar(
                                              context, "Allow to Edit");
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        CustomListTileButton(
                            // color: AppColor.buttonnewcolor,
                            height: height * 0.05,
                            width: width * 0.8,
                            text: AccountSettingController.isEdit == true
                                ? "Update"
                                : "Back",
                            ontap: () {
                              if (widget.willPopValue == false) {
                                if (BaseHelper.currentUser?.providerData.first
                                        .providerId
                                        .toString() ==
                                    'apple.com') {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  } else {
                                    AccountSettingController.updateUserData(
                                        context,
                                        federationLinkAccountController:
                                            federationLinkAccountController
                                                .text,
                                        federationRankAccount:
                                            AccountSettingController
                                                .federationRankAccount,
                                        gender: AccountSettingController.gender,
                                        imageFile:
                                            AccountSettingController.imageFile,
                                        nameController: nameController.text,
                                        passwordController:
                                            passwordController.text,
                                        rankingRadioAccount:
                                            AccountSettingController
                                                .rankingRadioAccount,
                                        roleRadioAccount: AccountSettingController
                                            .roleRadioAccount,
                                        address: addressController.text,
                                        campList: AccountSettingController
                                            .campiItemAdded,
                                        email: emailController.text
                                            .toLowerCase()
                                            .trim(),
                                        seviziList: AccountSettingController
                                            .seviziItemAdded,
                                        dob: dobController.text);
                                  }
                                }
                                AccountSettingController.updateUserData(context,
                                    federationLinkAccountController:
                                        federationLinkAccountController.text,
                                    federationRankAccount:
                                        AccountSettingController
                                            .federationRankAccount,
                                    gender: AccountSettingController.gender,
                                    imageFile:
                                        AccountSettingController.imageFile,
                                    nameController: nameController.text,
                                    passwordController: passwordController.text,
                                    rankingRadioAccount:
                                        AccountSettingController
                                            .rankingRadioAccount,
                                    roleRadioAccount: AccountSettingController
                                        .roleRadioAccount,
                                    address: addressController.text,
                                    campList:
                                        AccountSettingController.campiItemAdded,
                                    email: emailController.text
                                        .toLowerCase()
                                        .trim(),
                                    seviziList: AccountSettingController
                                        .seviziItemAdded,
                                    dob: dobController.text);
                              } else if (emailController.text !=
                                      BaseHelper.user?.email ||
                                  AccountSettingController.imageFile != '' ||
                                  AccountSettingController.gender !=
                                      BaseHelper.user?.gender ||
                                  !listEquals(
                                      BaseHelper.user?.campi,
                                      AccountSettingController
                                          .campiItemAdded) ||
                                  !listEquals(
                                      BaseHelper.user?.serviz,
                                      AccountSettingController
                                          .seviziItemAdded) ||
                                  nameController.text !=
                                      BaseHelper.user?.name ||
                                  emailController.text !=
                                      BaseHelper.user?.email ||
                                  passwordController.text !=
                                      BaseHelper.user?.password ||
                                  dobController.text != BaseHelper.user?.dob ||
                                  cityController.text !=
                                      BaseHelper.user?.city ||
                                  AccountSettingController
                                          .rankingRadioAccount !=
                                      BaseHelper.user?.isFederationRanking ||
                                  AccountSettingController
                                          .federationRankAccount !=
                                      BaseHelper.user?.federationRanking ||
                                  AccountSettingController.roleRadioAccount !=
                                      BaseHelper.user?.role ||
                                  federationLinkAccountController.text !=
                                      BaseHelper.user?.federationLink) {
                                AccountSettingController.updateUserData(context,
                                    federationLinkAccountController:
                                        federationLinkAccountController.text,
                                    federationRankAccount:
                                        AccountSettingController
                                            .federationRankAccount,
                                    gender: AccountSettingController.gender,
                                    imageFile:
                                        AccountSettingController.imageFile,
                                    nameController: nameController.text,
                                    passwordController: passwordController.text,
                                    rankingRadioAccount:
                                        AccountSettingController
                                            .rankingRadioAccount,
                                    roleRadioAccount: AccountSettingController
                                        .roleRadioAccount,
                                    address: addressController.text,
                                    campList:
                                        AccountSettingController.campiItemAdded,
                                    email: emailController.text
                                        .toLowerCase()
                                        .trim(),
                                    seviziList: AccountSettingController
                                        .seviziItemAdded,
                                    dob: dobController.text);
                              } else {
                                Navigator.maybePop(context);
                              }
                            }),
                      ],
                    );
            }),
      ),
    );
  }
}

class RoleSelectionSheet extends StatefulWidget {
  RoleSelectionSheet(
      {super.key,
      required this.roleRadioAccount,
      required this.roleRadioAccountList});
  final RoleName roleRadioAccount;
  final List<RoleName> roleRadioAccountList;
  RoleName newRole = RoleName.none;

  @override
  State<RoleSelectionSheet> createState() => _RoleSelectionSheetState();
}

class _RoleSelectionSheetState extends State<RoleSelectionSheet> {
  @override
  void initState() {
    // TODO: implement initSt
    widget.newRole = widget.roleRadioAccount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BottomSheet(
      enableDrag: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      onClosing: () {},
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${widget.roleRadioAccount == RoleName.none ? "Select" : "Change"} your rolo',
                style: heading22BlackStyle,
              ),
              SizedBox(
                width: size.width * 0.15,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: CloseButton(),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Wrap(
                children: widget.roleRadioAccountList.map((e) {
              return decoratedWithContainerWidget(e);
            }).toList()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonWidget(
                    circularRadius: 15,
                    onPressed: () {
                      widget.newRole = RoleName.none;
                      setState(() {});
                    },
                    text: 'Cancel'),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    left: 20,
                  ),
                  child: ButtonWidget(
                      circularRadius: 15,
                      onPressed: () {
                        Navigator.pop(context, widget.newRole);
                      },
                      text: 'Change'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding decoratedWithContainerWidget(RoleName e) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8),
      child: customBorderContainer(
          containerColor: widget.newRole == e
              ? AppColor.notificationcolor
              : Colors.transparent,
          onTap: () {
            setState(() {
              widget.newRole = e;
            });
          },
          text: e.name,
          style: widget.newRole == e
              ? small12BlackStyle.copyWith(color: AppColor.textcolor)
              : small12BlackStyle),
    );
  }

  InkWell customBorderContainer(
      {Function()? onTap,
      required String text,
      Color? containerColor,
      TextStyle? style}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: containerColor,
            border: Border.all(width: 2.5, color: AppColor.notificationcolor),
            borderRadius: BorderRadius.circular(16)),
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}
