import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';

import '../../controller/premium_account_controller.dart';
import '../../utils/constant/colors.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/list_tile_widget.dart';

class PremiumAccount extends StatelessWidget {
  const PremiumAccount({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarWidget(
        title: context.loc.rankUpYourAccount,
        background: AppColor.divivdercolor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomListTileButton(
            height: height * 0.06,
            width: width * 0.8,
            text:context.loc.getPremiumAccount,
            ontap: () {
              // BaseHelper.showSnackBar(context, "Upcoming feature");
              PremiumAccountController.purchasePremium(context);
            },
          ),
        ],
      ),
    );
  }
}
