import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_wanna_play_app/utils/enums.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';

import '../../controller/auth_controller.dart';
import '../../helper/basehelper.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../utils/constant/image_path.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/custom_sized_box_widget.dart';

import '../auth_/login_view.dart';
import '../home_/setting_/account_setting_view.dart';
import '../home_/home_page_view.dart';
import '../auth_/select_role_view.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Scaffold(
                  body: Center(
                    child: Text("Something went wrong"),
                  ),
                );
              } else if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.active) {
                if (BaseHelper.user != null) {
                  if (BaseHelper.user?.role == RoleName.none) {
                    return const AccountSettingView(willPopValue: false);
                  } else if (BaseHelper.user?.role != RoleName.none &&
                      BaseHelper.user?.isPrivacyPolicy == true) {
                    return const HomePageView();
                  }
                }

                return SizedBox.shrink();
              } else if (!snapshot.hasData) {
                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(AppAssets.spalsh)),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomSizedBox(
                          height: height * 0.9,
                        ),
                        Image.asset(AppAssets.spalshicon),
                        CustomSizedBox(
                          height: height * 0.04,
                        ),
                        CustomButton(
                          style: subTitle16lightGreenstyle,
                          height: height * 0.06,
                          width: width * 0.8,
                          text: context.loc.signUp,
                          onpressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const SelectRoleView()),
                            );
                          },
                        ),
                        CustomSizedBox(
                          height: height * 0.05,
                        ),
                        CustomButton(
                          style: subTitle16lightGreenstyle,
                          height: height * 0.06,
                          width: width * 0.8,
                          text: context.loc.logIn,
                          onpressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()),
                            );
                          },
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (Platform.isIOS)
                              Transform.scale(
                                scale: 1.5,
                                child: InkWell(
                                  onTap: () async {
                                    Auth.signInWithApple(context);
                                  },
                                  child: SizedBox(
                                      // color: Colors.red,
                                      // height: 60,
                                      width: 70,
                                      // margin: const EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                        AppAssets.appleLogo,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                            InkWell(
                              onTap: () async {
                                await Auth.signInFacebbok(context);
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Image.asset(AppAssets.facebookIcon)),
                            ),
                            // Container(
                            //     margin: const EdgeInsets.only(right: 10),
                            //     child: Image.asset('assetss/insta.png')),
                            InkWell(
                              onTap: () {
                                Auth.signInGoogle(context);
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Image.asset(AppAssets.googleIcon)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return const Scaffold(
                  body: Center(
                    child: Text("No Internet"),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator.adaptive()),
                );
              } else {
                return const Scaffold(
                  body: Center(
                    child: Text("Something went wrong"),
                  ),
                );
              }
            }),
      ),
    );
  }
}
