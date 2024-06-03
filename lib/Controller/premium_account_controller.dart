import 'package:flutter_wanna_play_app/controller/home_page_controller.dart';

import '../Firebase/firebase_methods.dart';
import '../helper/basehelper.dart';

class PremiumAccountController {
  static purchasePremium(context) async {
    await FirebaseMethod.getUserData();
    if (BaseHelper.user?.isPremiumAcc == false) {
      // HomePageController.makePayment(context);
    } else {
      BaseHelper.showSnackBar(context, 'Already a Premium account');
    }
  }
}
