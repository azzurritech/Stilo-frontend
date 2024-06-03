import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_wanna_play_app/controller/auth_controller.dart';
import 'package:flutter_wanna_play_app/Firebase/firebase_methods.dart';
import 'package:flutter_wanna_play_app/helper/basehelper.dart';
import 'package:flutter_wanna_play_app/utils/constant/colors.dart';
import 'package:flutter_wanna_play_app/utils/constant/heading_text_style.dart';
import 'package:flutter_wanna_play_app/view/splash_/welcome_view.dart';
import 'package:flutter_wanna_play_app/widgets/app_bar_widget.dart';
import 'package:flutter_wanna_play_app/widgets/button_widgets.dart';
import 'package:flutter_wanna_play_app/widgets/dialog_box_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyPolicyView extends StatefulWidget {
  final bool isReadOnly;
  const PrivacyPolicyView({super.key, required this.isReadOnly});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      Auth.logOut(context);
    }
  }

  final ValueNotifier<bool> isTerms = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        titleSpacing: 20,
        centerTitle: true,
        backgroundColor: AppColor.divivdercolor,
        title: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
          child: FittedBox(
            child: Text("Termini e condizioni d’uso di WANNA PLAYS",
                style: heading22BlackStyle),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: 16, right: 16, bottom: widget.isReadOnly ? 20 : 90),
        child: Column(
          children: [
            const Divider(),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: Colors.red)),
                child: ClipRRect(
                  child: Card(
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26))),
                    child: SingleChildScrollView(
                      child: Text(
                        BaseHelper.termsAndConditions,
                        style: subTitle16DarkGreyStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.isReadOnly == false)
              Row(
                children: [
                  ValueListenableBuilder<bool>(
                      valueListenable: isTerms,
                      builder: (_, value, child) {
                        return Checkbox(
                          activeColor: Colors.black,
                          value: value,
                          onChanged: (value) {
                            isTerms.value = value!;
                          },
                        );
                      }),
                  Text(
                    "Agree terms and conditions",
                    style: subTitle16BlackStyle,
                  )
                ],
              )
          ],
        ),
      ),
      floatingActionButton: widget.isReadOnly == false
          ? Container(
              color: Colors.white,

              width: double.infinity,
              padding: const EdgeInsets.only(left: 20, right: 20),
              // color: Colors.red,
              child: ValueListenableBuilder<bool>(
                  valueListenable: isTerms,
                  builder: (_, value, child) {
                    return CustomElevatedButton(
                        onPressed: value == true
                            ? () async {
                                EasyLoading.show();
                                await FirebaseMethod.updateData(
                                    {"isPrivacyPolicy": true});
                                await FirebaseMethod.getUserData();
                                EasyLoading.dismiss();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WelcomeView()),
                                  (route) => false,
                                );
                              }
                            : null,
                        child: Text(
                          "Agree and Continue",
                          style: subTitle16WhiteStyle,
                        ));
                  }),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
