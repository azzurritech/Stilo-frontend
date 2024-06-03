import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension SpaceExtension on num {
  height() {
    return SizedBox(
      height: toDouble(),
    );
  }

  width() {
    return SizedBox(
      width: toDouble(),
    );
  }
}

extension NavigationExtensions on BuildContext {
  void popPage({Object? result}) {
    return Navigator.of(this).pop(result);
  }

  Future<bool> maybePopPage() {
    return Navigator.of(this).maybePop();
  }

  void navigateTo(
    Widget screen,
  ) {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  void navigatepushReplacement(Widget screen) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(
      builder: (context) => screen,
    ));
  }

  void navigateToRemovedUntil(Widget screen) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => route.isFirst,
    );
  }
}

extension DynanicSizeExtension on BuildContext {
  double get dynamicHeight => MediaQuery.of(this).size.height;

  double get dynamicWidth => MediaQuery.of(this).size.width;
  Size get dynamicSize => MediaQuery.of(this).size;
}

extension HideKeypad on BuildContext {
  void hideKeypad() => FocusScope.of(this).unfocus();
}

extension OmitSymbolText on String {
  String capitalizeFirst() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  getTextAfterSymbol() {
    int atIndex = indexOf('-');
    int lastAtIndex = lastIndexOf('-');

    if (atIndex != -1 && atIndex == lastAtIndex) {
      return substring(atIndex + 1);
    } else {
      return "";
    }
  }
}

extension HMSextension on int {
  String get mordernDurationTextWidget =>
      "${Duration(seconds: this).inHours.remainder(60).toString()}:${Duration(seconds: this).inMinutes.remainder(60).toString().padLeft(2, '0')}:${Duration(seconds: this).inSeconds.remainder(60).toString().padLeft(2, '0')}";
}

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}
