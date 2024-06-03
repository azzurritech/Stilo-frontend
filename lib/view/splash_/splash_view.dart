import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanna_play_app/controller/auth_controller.dart';
import 'package:flutter_wanna_play_app/controller/language_change_controller.dart';
import 'package:flutter_wanna_play_app/view/splash_/welcome_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase/firebase_methods.dart';
import '../../helper/basehelper.dart';
import '../../utils/constant/image_path.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    checkFirstTime();

    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const WelcomeView(),
              ),
            ));

    // TODO: implement initState
    super.initState();
  }

  checkFirstTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? data = preferences.getBool("isFirst");
    if (data  == null) {
      ref.read(languageProvider).setLocale(const Locale('en'));
      preferences.setBool("isFirst", true);
      if (BaseHelper.auth.currentUser != null) {
        Auth.logOut(context);
      }
    } else {
      if (BaseHelper.user == null && BaseHelper.auth.currentUser != null) {
        initialUserData();
      }
    }
  }

  initialUserData() async {
    await FirebaseMethod.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage(AppAssets.spalsh)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset(AppAssets.spalshicon)],
          ),
        ),
      ),
    );
  }
}
