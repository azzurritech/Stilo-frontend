
import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/helper/basehelper.dart';

class FriendViewController {
  static ValueNotifier<bool> isGroup = ValueNotifier(false);
  static List memberList = [
    {
      "name": BaseHelper.user?.name.toString() ?? "",
      "email": BaseHelper.user?.email.toString() ?? "",
      "profilePhoto": BaseHelper.user?.profilePhoto.toString() ?? "",
      "isAdmin": true,
    }
  ];
}
