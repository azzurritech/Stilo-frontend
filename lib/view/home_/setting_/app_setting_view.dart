import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanna_play_app/Controller/home_page_controller.dart';
import 'package:flutter_wanna_play_app/Firebase/firebase_methods.dart';
import 'package:flutter_wanna_play_app/controller/language_change_controller.dart';
import 'package:flutter_wanna_play_app/helper/basehelper.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';
import 'package:flutter_wanna_play_app/view/splash_/welcome_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:share_plus/share_plus.dart';

import '../../../controller/auth_controller.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/constant/heading_text_style.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/custom_sized_box_widget.dart';
import '../../../widgets/list_tile_widget.dart';
import 'account_setting_view.dart';

class AppSettingsView extends ConsumerStatefulWidget {
  const AppSettingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppSettingsViewState();
}

class _AppSettingsViewState extends ConsumerState<AppSettingsView> {
  int selectedIndex = 0;
  int newSelectedIndex = 0;
  @override
  void initState() {
    getLocalFn(); // TODO: implement initState
    super.initState();
  }

  getLocalFn() async {
    Locale? l = await ref.read(languageProvider).getLocale();
    if (l?.languageCode == 'en') {
      selectedIndex = 0;
      newSelectedIndex = 0;
    } else if (l?.languageCode == 'it') {
      selectedIndex = 1;
      newSelectedIndex = 1;
    } else {
      selectedIndex = 2;
      newSelectedIndex = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarWidget(
        title: context.loc.appSettings,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomListTileButton(
                height: height * 0.06,
                width: width * 0.8,
                text: context.loc.profileSetting,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AccountSettingView(
                            willPopValue: true,
                          )));
                }),
            // CustomSizedBox(
            //   height: height * 0.03,
            // ),
            // CustomListTileButton(
            //     style: subTitle16lightGreenstyle,
            //     color: AppColor.maincolor,
            //     height: height * 0.06,
            //     width: width * 0.8,
            //     text: 'Privacy e sicurezza',
            //     ontap: () {}),
            // CustomSizedBox(
            //   height: height * 0.03,
            // ),
            // CustomListTileButton(
            //     height: height * 0.06,
            //     width: width * 0.8,
            //     text: 'Aiuto',
            //     ontap: () {}),

            CustomSizedBox(
              height: height * 0.03,
            ),
            CustomListTileButton(
                style: subTitle16lightGreenstyle,
                height: height * 0.07,
                width: width * 0.8,
                text: context.loc.shareApp,
                color: AppColor.maincolor,
                ontap: () {
                  _shareApp();
                }),
            CustomSizedBox(
              height: height * 0.03,
            ),
            Consumer(
              builder: (_, ref, child) {
                var langProvder = ref.watch(languageProvider);
                return CustomListTileButton(
                    style: subTitle16lightGreenstyle,
                    height: height * 0.07,
                    width: width * 0.8,
                    text: context.loc.selectLanguage,
                    color: AppColor.maincolor,
                    ontap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => Container(
                          height: 130,
                          padding: const EdgeInsets.only(top: 6.0),
                          color: CupertinoColors.white,
                          child: GestureDetector(
                            // Blocks taps from propagating to the modal sheet and popping.
                            onTap: () {
                              context.popPage();
                              if (newSelectedIndex != selectedIndex) {
                                if (newSelectedIndex == 0) {
                                  selectedIndex = 0;
                                  ref
                                      .read(languageProvider)
                                      .setLocale(const Locale('en'));
                                } else if (newSelectedIndex == 1) {
                                  selectedIndex = 1;
                                  ref
                                      .read(languageProvider)
                                      .setLocale(const Locale('it'));
                                } else if (newSelectedIndex == 2) {
                                  selectedIndex = 2;
                                  ref.read(languageProvider).clearLocale();
                                }
                              }
                            },
                            child: SafeArea(
                              top: false,
                              child: CupertinoPicker(
                                magnification: 1.1,
                                useMagnifier: true,
                                itemExtent:
                                    50.0, // Adjust the item height as needed
                                scrollController: FixedExtentScrollController(
                                  initialItem: selectedIndex,
                                ),

                                onSelectedItemChanged: (int index) {
                                  newSelectedIndex = index;
                                },
                                children: [
                                  for (var i = 0;
                                      i < langProvder.supportedLocale().length;
                                      i++)
                                    Center(
                                      child: Text(langProvder
                                          .supportedLocale()[i]
                                          .languageCode),
                                    ),
                                  Center(
                                    child: Text(context.loc.systemLanguage),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        // CupertinoActionSheet(
                        //   actions: [
                        //     SizedBox(
                        //       height: 100,
                        //       child: CupertinoPicker(
                        //         useMagnifier: true,
                        //         itemExtent:
                        //             50.0, // Adjust the item height as needed
                        //         scrollController:
                        //             FixedExtentScrollController(
                        //           initialItem: 0,
                        //         ),

                        //         onSelectedItemChanged: (int index) {
                        //           print(index);
                        //         },
                        //         children: [
                        //           for (var i = 0;
                        //               i <
                        //                   langProvder
                        //                       .supportedLocale()
                        //                       .length;
                        //               i++)
                        //             Center(
                        //               child: Text(langProvder
                        //                   .supportedLocale()[i]
                        //                   .languageCode),
                        //             ),
                        //           Center(
                        //             child: Text('Select System language'),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ],

                        //   //   CupertinoActionSheetAction(
                        //   //   onPressed: () {
                        //   //     // Do something with the selected value
                        //   //     print('Selected value: $selectedValue');
                        //   //     Navigator.pop(context);
                        //   //   },
                        //   //   child: Text('Done'),
                        //   // ),
                        // )
                      ).then((value) {
                        print(value);
                      });
                    });
              },
            ),
            // Consumer(
            //   builder: (_, ref, child) {
            //     var langProvder = ref.watch(languageProvider);
            //     return PopupMenuButton(

            //       icon: CustomListTileButton(
            //         style: subTitle16lightGreenstyle,
            //         // height: height * 0.07,
            //         // width: width * 0.8,
            //         text: 'Share App',
            //         color: AppColor.maincolor,
            //         ontap: () {},
            //       ),
            //       itemBuilder: (context) => [
            //         for (var i = 0;
            //             i < langProvder.supportedLocale().length;
            //             i++)
            //           PopupMenuItem(
            //               child: Text(langProvder
            //                   .supportedLocale()[i]
            //                   .languageCode
            //                   .toString()))
            //       ],
            //     );
            //   },
            // ),
            CustomSizedBox(
              height: height * 0.03,
            ),
            CustomListTileButton(
                style: subTitle16lightGreenstyle,
                height: height * 0.06,
                width: width * 0.8,
                color: AppColor.maincolor,
                text: 'Delete Account',
                ontap: () async{
                  EasyLoading.show();

    if (BaseHelper.currentUser?.providerData.first.providerId.toString() ==
        'google.com') {
      await GoogleSignIn().signOut();
    } else if (BaseHelper.currentUser?.providerData.first.providerId
            .toString() ==
        'facebook.com') {
      await FacebookAuth.instance.logOut();
    }
    await FirebaseMethod.updateData({"device_token": ""});
    await HomePageController.setStatus('Offline');
    await FirebaseAuth.instance.signOut();

    BaseHelper.user = null;
    BaseHelper.currentUser = BaseHelper.auth.currentUser;
    EasyLoading.dismiss();
    BaseHelper.showSnackBar(context, "Delete Successfully");
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const WelcomeView()),
      (route) => false,
    );
                }),
            CustomListTileButton(
                style: subTitle16lightGreenstyle,
                height: height * 0.06,
                width: width * 0.8,
                color: AppColor.maincolor,
                text: context.loc.logOut,
                ontap: () {
                  Auth.logOut(context);
                }),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     GestureDetector(
            //       child: Container(
            //           margin: EdgeInsets.only(right: 10),
            //           child: Image.asset('assetss/facebook.png')),
            //     ),
            //     Container(
            //         margin: EdgeInsets.only(right: 10),
            //         child: Image.asset('assetss/insta.png')),
            //     Container(
            //         margin: EdgeInsets.only(right: 10),
            //         child: Image.asset('assetss/google.png'))
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

_shareApp() async {
  Share.share(await Auth.createDynamicLink());
}
