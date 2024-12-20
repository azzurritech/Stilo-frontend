import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_wanna_play_app/model/user_model.dart';

import '../firebase/firebase_methods.dart';
import '../helper/basehelper.dart';
import '../utils/enums.dart';
import '../view/home_/home_page_view.dart';

class AccountSettingController {
  static List seviziItemAdded = [];

  static List seviziList = [
    'Bar',
    "Spogliatoi",
    "Vendita Palline",
    "Negozio Interno",
    "Servizio Incordatura",
    "Ristorante"
  ];
  static List campiList = [
    "PlayIt",
    "Cemento",
    "Terra",
    "Erba",
    "Luci",
    "Riscldamento",
    "Coperto",
    "Scoperto"
  ];
  static List campiItemAdded = [];
  static String federationRankAccount = '';
  static String rankingRadioAccount = "Si";

  static String bottomRole = '';
  static RoleName roleRadioAccount = RoleName.none;

  static bool isEdit = false;
  static String gender = '';

  static String imageFile = '';

  static updateUserData(context,
      {required List campList,
      required List seviziList,
      required String address,
      required String imageFile,
      required String passwordController,
      required String nameController,
      required RoleName roleRadioAccount,
      required String dob,
      required String gender,
      required String email,
      required String federationRankAccount,
      required String federationLinkAccountController,
      required String rankingRadioAccount}) async {
    if (roleRadioAccount == RoleName.none) {
      BaseHelper.showSnackBar(context, 'Update your Role');
      return;
    }
    if (rankingRadioAccount == ""&&roleRadioAccount != RoleName.club) {
      BaseHelper.showSnackBar(context, 'Update your Ranking');
      return;
    }
    if (gender == "" &&
        BaseHelper.currentUser?.providerData.first.providerId.toString() ==
            'apple.com'&&roleRadioAccount != RoleName.club) {
      BaseHelper.showSnackBar(context, 'Select your gender');
      return;
    }
    if (imageFile == "null" || imageFile == "") {
      BaseHelper.showSnackBar(context, 'Upload your photo');
      return;
    }
    if (dob == "" &&
        BaseHelper.currentUser?.providerData.first.providerId.toString() ==
            'apple.com' &&
        roleRadioAccount != RoleName.club) {
      BaseHelper.showSnackBar(context, 'Upload your DOB');
      return;
    }
    if (roleRadioAccount == RoleName.club) {
      if (address.isEmpty) {
        BaseHelper.showSnackBar(context, 'Address field can not be empty');
        return;
      } else if (seviziList.isEmpty) {
        BaseHelper.showSnackBar(context, 'Serviz can not be Empty');
        return;
      } else if (campList.isEmpty) {
        BaseHelper.showSnackBar(context, 'Campi can not be Empety');
        return;
      }
    }

    EasyLoading.show();
    if (BaseHelper.currentUser?.displayName.toString() != nameController) {
      await BaseHelper.auth.currentUser?.updateDisplayName(nameController);
    }

    if (imageFile != "null" && imageFile != '') {
      try {
        await BaseHelper.auth.currentUser?.updatePhotoURL(imageFile);
      } on FirebaseException catch (e) {
        BaseHelper.showSnackBar(context, e.message);
        EasyLoading.dismiss();
        return;
      }
    }

    if (BaseHelper.user?.password != passwordController) {
      try {
        await BaseHelper.auth.currentUser?.updatePassword(passwordController);
      } on FirebaseException catch (e) {
        BaseHelper.showSnackBar(context, e.message);
        EasyLoading.dismiss();
        return;
      }
    }

    if (BaseHelper.user?.email != email) {
      try {
        await BaseHelper.auth.currentUser?.updateEmail(email);
        await FirebaseMethod.deleteUserData();
        await FirebaseMethod.setUserData(BaseHelper.user!);
      } on FirebaseException catch (e) {
        BaseHelper.showSnackBar(context, e.message);
        EasyLoading.dismiss();
        return;
      }
    }
    var data = {
      "address": address,
      "campList": campList,
      "seviziList": seviziList,
      "profilePhoto":
          imageFile != "" ? imageFile : BaseHelper.auth.currentUser?.photoURL,
      "role": reverseRoleName.reverseMap[roleRadioAccount],
      "name": nameController,
      "gender": gender,
      "dob": dob,
      "password": passwordController,
      "federationRanking": federationRankAccount,
      "federationLink": federationLinkAccountController,
      "isFederationRanking": rankingRadioAccount,
      "email": email
    };

    await FirebaseMethod.updateData(data);
    await FirebaseMethod.getUserData();
    isEdit = false;

    EasyLoading.dismiss();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomePageView()),
      (route) => false,
    );
    return;
  }
}

// dkfdhfk