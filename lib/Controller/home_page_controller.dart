import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
  import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../Firebase/firebase_methods.dart';
import '../Firebase/firebase_services.dart';

import '../helper/basehelper.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:http/http.dart' as http;

import '../service/geolocator.dart';

class HomePageController {
  static Future<bool?> getAddressFromLatLng(context, Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      var data = {
        'lat': position.latitude,
        'long': position.longitude,
        "city": "${place.locality},${place.country}"
      };

      await FirebaseMethod.updateData(data);
      await FirebaseMethod.getUserData();
      return true;
    } catch (e) {
      BaseHelper.showSnackBar(context, e.toString());
    }
    return null;
  }

  static String createChatRoomId(String user1, String user2) {
    if (user1.hashCode <= user2.hashCode) {
      return '$user1$user2';
    } else {
      return '$user2$user1';
    } 
  }

  static setStatus(String status) async {
    if (BaseHelper.auth.currentUser?.email == null) {
      return;
    } else {
      await FirebaseMethod.updateData({'status': status});
    }
  }

  static notificationLocation(context) async {
  await  LocPermission.handleLocationPermission(context).then((value) {
      if (value == true) {
        Geolocator.getCurrentPosition().then((event) async {
          await getAddressFromLatLng(context, event);
        });
      }
    });
  await  NotificationServices.requestNotificationPermission(context).then((value) {
      if (value == true) {
        NotificationServices.firebaseInIt(context);
        NotificationServices.foregroundMessaging();
        NotificationServices.setupInteractMessage(context);

        NotificationServices.getDeviceToken().then((value) async {
          FirebaseMethod.updateData({"device_token": value});
          await FirebaseMethod.getUserData();
        });
      }
    });
  }

  // static Map? _paymentIntentData;
  // static const String _amountToPay = '20';
  // static Future<void> makePayment(BuildContext context) async {
  //   try {
  //     _paymentIntentData = await _createPaymentIntent(_amountToPay, 'USD');

  //     await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //             style: ThemeMode.dark,
  //             paymentIntentClientSecret: _paymentIntentData!['client_secret'],
  //             customFlow: true,
  //             intentConfiguration: IntentConfiguration(
  //                 mode: const IntentMode(
  //                   currencyCode: "USD",
  //                   amount: 2000,
  //                 ),
  //                 paymentMethodTypes: List.from(
  //                   _paymentIntentData![
  //                       "https://buy.stripe.com/test_bIY8ysdPdatQcLe9AB"],
  //                 )),
  //             merchantDisplayName: 'Azzuri'));

  //     _displayPaymentSheet(context);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  // static void _displayPaymentSheet(BuildContext context) async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet().then((value) async {
  //       _paymentIntentData = null;
  //       BaseHelper.showSnackBar(context,
  //           "Successfully you have paid \$$_amountToPay and become got a premium account ");
  //       await FirebaseMethod.getUserData();

  //       await FirebaseMethod.updateData({"isPremiumAccount": true});
  //       await FirebaseMethod.getUserData();

  //       print('Done');
  //     });
  //   } on StripeException catch (e) {
  //     BaseHelper.showSnackBar(context, e.error.message);
  //   }
  // }

  // static _createPaymentIntent(String amount, String currency) async {
  //   try {
  //     // Map<String, dynamic> body = {
  //     //   'amount': _calculateAmount(amount),
  //     //   'currency': currency
  //     // };
  //     Map body = {
  //       "id": "plink_1OEEbZELirk4t3fxpckzQuAB",
  //       "object": "payment_link",
  //       "created": "1700414181"
  //     };
  //     var response = await http.post(
  //         Uri.parse('https://api.stripe.com/v1/payment_links'),
  //         body: body,
  //         headers: {
  //           'Authorization':
  //               'Bearer sk_test_51O4n3RELirk4t3fxxZbxSdlQCMhdMSPMsilk2LiPZZji3tak93HRcN5istr2PnrpPHr9C1fZwzEvXXXMQYYZKtXj000ZdOXi6b',
  //           "Idempotency": "Key - b4b8003e-fd79-4a04-9cc1-6676cc6fe520",
  //           'Content-Type': 'application/x-www-form-urlencoded'
  //         });

  //     return jsonDecode(response.body);
  //   } catch (err) {
  //     throw Exception(err);
  //   }
  // }

  // static _calculateAmount(String amount) {
  //   final a = (int.parse(amount)) * 100;
  //   return a.toString();
  // }
}
