// import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/services.dart';
import 'package:flutter_wanna_play_app/controller/auth_controller.dart';
import 'package:flutter_wanna_play_app/controller/language_change_controller.dart';

import 'package:flutter_wanna_play_app/utils/constant/colors.dart';
import 'package:flutter_wanna_play_app/view/splash_/splash_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? lang = prefs.getString('language');
  Locale? localDbLang;
  if (lang.toString() != "null") {
    localDbLang = Locale(lang ?? '');
  } else {
    localDbLang = null;
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Stripe.publishableKey =
  //     'pk_test_51O4n3RELirk4t3fxykjMvlVPCTCZaiGDXtKd7GxnWpVQVY9m35f4LVaPGU9BwlaxJhgVYw2WHJRPyOvqd9Adovjc00LOoEdxB6';

  Auth.initDynamicLinks();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(ProviderScope(child: HomePage(appLocale: localDbLang))));
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class HomePage extends StatefulWidget {
  final Locale? appLocale;

  const HomePage({Key? key, this.appLocale}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Consumer(
        builder: (_, ref, child) {
          final langProvider = ref.watch(languageProvider);
          return MaterialApp(
              locale: langProvider.getAppLocal ?? widget.appLocale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              localeResolutionCallback:
                  (Locale? locale, Iterable<Locale> supportedLocales) {
                for (Locale supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              supportedLocales: AppLocalizations.supportedLocales,
              title: "Wanna Play",
              theme: ThemeData(
                  useMaterial3: false,
                  appBarTheme: const AppBarTheme(
                      iconTheme: IconThemeData(color: Colors.black),
                      elevation: 0)),
              builder: EasyLoading.init(
                builder: (context, child) {
                  EasyLoading.instance
                    ..indicatorType = EasyLoadingIndicatorType.ring
                    ..loadingStyle = EasyLoadingStyle.custom
                    ..indicatorSize = 40
                    ..radius = 10
                    ..textColor = AppColor.blackcolor
                    ..backgroundColor = AppColor.maincolor
                    ..indicatorColor = AppColor.textfield_color
                    ..maskColor = AppColor.blackcolor
                    ..userInteractions = false
                    ..dismissOnTap = false;
                  return Container(
                    child: child,
                  );
                },
              ),
              debugShowCheckedModeBanner: false,
              home: const SplashView());
        },
      ),
    );
  }
}
