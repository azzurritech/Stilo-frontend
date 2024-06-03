import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanna_play_app/controller/auth_controller.dart';
import 'package:flutter_wanna_play_app/utils/enums.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';

import '../../helper/basehelper.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../utils/constant/image_path.dart';
import '../../view/auth_/signup_club_view.dart';
import '../../view/auth_/signup_coach_view.dart';
import '../../view/auth_/signup_player_view.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/custom_sized_box_widget.dart';
import '../../widgets/radio_button_widgets.dart';

class SelectRoleView extends StatefulWidget {
  const SelectRoleView({super.key});

  @override
  State<SelectRoleView> createState() => _SelectRoleViewState();
}

class _SelectRoleViewState extends State<SelectRoleView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          background: Colors.transparent,
          title: context.loc.selectIdentity,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(AppAssets.spalsh)),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 0),
            width: double.infinity,
            child: Column(
              children: [
                CustomSizedBox(
                  height: height * 0.9,
                ),
                Expanded(flex: 3, child: Image.asset(AppAssets.spalshicon)),
                CustomSizedBox(
                  height: height * 0.06,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 85),
                  child: CustomRadioButton(
                      mainAxisAlignmen: MainAxisAlignment.start,
                      val: Auth.role,
                      value: RoleName.player,
                      text: context.loc.player,
                      onChanged: (value) {
                        setState(() {
                          Auth.role = value;
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 85),
                  child: CustomRadioButton(
                      mainAxisAlignmen: MainAxisAlignment.start,
                      val: Auth.role,
                      value: RoleName.coach,
                      text: context.loc.coach,
                      onChanged: (value) {
                        setState(() {
                          Auth.role = value;
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 85),
                  child: CustomRadioButton(
                      mainAxisAlignmen: MainAxisAlignment.start,
                      val: Auth.role,
                      value: RoleName.club,
                      text: context.loc.club,
                      onChanged: (value) {
                        setState(() {
                          Auth.role = value!;
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 85),
                  child: CustomRadioButton(
                      mainAxisAlignmen: MainAxisAlignment.start,
                      val: Auth.role,
                      value: RoleName.paddle,
                      text: context.loc.paddle,
                      onChanged: (value) {
                        setState(() {
                          Auth.role = value!;
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 85),
                  child: CustomRadioButton(
                      mainAxisAlignmen: MainAxisAlignment.start,
                      val: Auth.role,
                      value: RoleName.physiotherapist,
                      text: context.loc.physiotherapist,
                      onChanged: (value) {
                        setState(() {
                          Auth.role = value!;
                        });
                      }),
                ),
                CustomSizedBox(
                  height: height * 0.05,
                ),
                CustomButton(
                  style: subTitle16lightGreenstyle,
                  height: height * 0.06,
                  width: width * 0.8,
                  text: context.loc.next,
                  onpressed: () async {
                    if (Auth.role != null) {
                      Auth.role == RoleName.player
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SignupPlayerView()),
                            )
                          : Auth.role == RoleName.club
                              ? Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupClubView()),
                                )
                              : Auth.role == RoleName.coach
                                  ? Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpCoachView()))
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupPlayerView()),
                                    );
                    } else {
                      await BaseHelper.showSnackBar(
                        context,
                        context.loc.selectAnyRole,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
