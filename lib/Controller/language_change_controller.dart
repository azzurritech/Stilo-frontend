import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final languageProvider = ChangeNotifierProvider<LanguageController>((ref) {
  return LanguageController();
});

class LanguageController extends ChangeNotifier {
  Locale? _locale;
  Locale? get getAppLocal => _locale;

  Future<Locale?> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lang = prefs.getString('language');
    if (lang != null) {
      _locale = Locale(lang);
      notifyListeners();
    }
    return _locale;
  }

  void setLocale(Locale locale) async {
    _locale = locale;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', locale.languageCode);
    notifyListeners();
  }

  void clearLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("language");
    _locale = window.locale;
    notifyListeners();
  }

  List<Locale> supportedLocale() => AppLocalizations.supportedLocales;
}
