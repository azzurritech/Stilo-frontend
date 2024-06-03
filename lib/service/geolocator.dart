import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import '../helper/basehelper.dart';

abstract class LocPermission {
  static Future<bool> handleLocationPermission(context) async {
    try {
      bool isEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();
      if (isEnabled == true) {
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();

          if (permission == LocationPermission.denied) {
            BaseHelper.showSnackBar(context, "Location permissions are denied");
            return false;
          }
        }
        if (permission == LocationPermission.deniedForever) {
          permission = await Geolocator.requestPermission();

          BaseHelper.showSnackBar(context,
              'Location permissions are permanently denied, gives location permisson to explore your sorrounding peoples .');

          return false;
        }
        return true;
      } else {
        BaseHelper.showSnackBar(context,
            "Turn on Your Location To explore your sorrounding peoples");

        return false;
      }
    } on PlatformException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
      return false;
    }
  }
}
