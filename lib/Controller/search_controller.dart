import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/helper/basehelper.dart';
import 'package:flutter_wanna_play_app/view/invitation_/send_friend_invite_view.dart';
import 'package:flutter_wanna_play_app/view/profile_/club_profile_view.dart';
import 'package:flutter_wanna_play_app/view/profile_/friend_profile_view.dart';




class GeneralSearchController {
  static chechkFriend(context, String email) async {
    if (BaseHelper.user!.friends!.contains(email)) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FriendProfileView(
                email: email,
              )));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SendFriendInvitationView(
          email: email,
        ),
      ));
    }
  }

  static selectedClub(context, String email) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ClubProfileView(
              email: email,
            )));
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => TennisClubRecension()));

    // if (BaseHelper.user!.friends!
    //             .contains(email)) {
    //           await FirebaseMethod.getOtherUserData(
    //             email);
    //           Navigator.of(context).push(
    //               MaterialPageRoute(builder: (context) => GiocatoreInvite()));
    //         } else {
    //             await FirebaseMethod.getOtherUserData(
    //             email);
    //           Navigator.of(context).push(MaterialPageRoute(
    //             builder: (context) =>
    //                 SendInviteView(),
    //           ));
    //         }
  }
}
