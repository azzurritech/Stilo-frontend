import 'dart:convert';

import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_wanna_play_app/controller/home_page_controller.dart';
import 'package:flutter_wanna_play_app/view/privacy_policy_view.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:uuid/uuid.dart';

import '../Firebase/firebase_methods.dart';

import '../helper/basehelper.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/user_model.dart';
import '../utils/enums.dart';
import '../view/splash_/welcome_view.dart';

class Auth {
  static RoleName? role;
  static TextEditingController phoneNumberController = TextEditingController();
  static Future<String?> uploadImage(
    File imageVar,
    context,
  ) async {
    EasyLoading.show();
    String? downloadableLink;
    String uniqueFilename = const Uuid().v1();

    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceRootDir = reference.child('images');
    Reference referenceRootDirToUpload = referenceRootDir.child(uniqueFilename);
    try {
      await referenceRootDirToUpload.putFile(File(imageVar.path));
      await referenceRootDirToUpload.getDownloadURL().then((value) {
        return downloadableLink = value;
      });
    } catch (e) {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, 'Some thing Went Wrong');
      return downloadableLink = '';
    }
    EasyLoading.dismiss();
    return downloadableLink;
  }

  static Future signUp(
    context, {
    required String federationLink,
    required String? federationRank,
    required String dob,
    String? leaderBoardRadio,
    required String genderRadio,
    required String rankingRadio,
    required String city,
    required String email,
    required String password,
    required String name,
    required String imageUrl,
  }) async {
    if (imageUrl == "null") {
      BaseHelper.showSnackBar(context, "Please select your Profile Photo");
      return;
    } else if (genderRadio == '') {
      BaseHelper.showSnackBar(context, "Please select sesso");
      return;
    } else if (rankingRadio == '') {
      BaseHelper.showSnackBar(context, "Please select your any ranking");
      return;
    } else if (leaderBoardRadio == '' && role == RoleName.coach) {
      BaseHelper.showSnackBar(
          context, "Please select your Mantieni la classifica");
      return;
    }

    BaseHelper.hideKeypad(context);
    EasyLoading.show();

    try {
      User? user = (await BaseHelper.auth.createUserWithEmailAndPassword(
              email: email.trim().toLowerCase(), password: password.trim()))
          .user;
      if (user != null) {
        print("created");
        await BaseHelper.auth.currentUser?.updateDisplayName(name);
        await BaseHelper.auth.currentUser?.updatePhotoURL(imageUrl.toString());

        var data = UserModel(
            role: role!,
            dob: dob,
            city: city,
            gender: genderRadio,
            isFederationRanking: rankingRadio,
            federationRanking: federationRank,
            name: name,
            email: email,
            federationLink: federationLink,
            profilePhoto: imageUrl.toString(),
            isKeepLeaderboard: leaderBoardRadio,
            password: password,
            isPrivacyPolicy: false);
        await FirebaseMethod.setUserData(data);

        await FirebaseMethod.getUserData();
        EasyLoading.dismiss();
        BaseHelper.showSnackBar(context, "Login Successfully");
        if (BaseHelper.user?.isPrivacyPolicy ?? false) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const WelcomeView()),
            (route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const PrivacyPolicyView(
                      isReadOnly: false,
                    )),
            (route) => false,
          );
        }

        return user;
      } else {
        print('no data store');
      }
    } on FirebaseAuthException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    EasyLoading.dismiss();
    return;
  }

  static Future signUpCircolo(
    context, {
    required String city,
    required String email,
    required String password,
    required String name,
    required String imageUrl,
    required String phoneNumber,
    required List campiList,
    required List servizList,
  }) async {
    if (imageUrl == "null") {
      BaseHelper.showSnackBar(context, "Please select your Profile Photo");
      return;
    } else if (servizList.isEmpty) {
      BaseHelper.showSnackBar(context, "Please select any sevizi");
      return;
    } else if (campiList.isEmpty) {
      BaseHelper.showSnackBar(context, "Please select any campi");
      return;
    }

    BaseHelper.hideKeypad(context);
    EasyLoading.show();

    try {
      User? user = (await BaseHelper.auth.createUserWithEmailAndPassword(
              email: email.trim().toLowerCase(), password: password.trim()))
          .user;
      if (user != null) {
        print("created");
        await BaseHelper.auth.currentUser?.updateDisplayName(name);
        await BaseHelper.auth.currentUser?.updatePhotoURL(imageUrl.toString());

        var data = UserModel(
            role: role!,
            city: city,
            name: name,
            email: email,
            profilePhoto: imageUrl.toString(),
            campi: campiList,
            serviz: servizList,
            phoneNumber: phoneNumber,
            password: password,
            isPrivacyPolicy: false);
        await FirebaseMethod.setUserData(data);

        await FirebaseMethod.getUserData();
        EasyLoading.dismiss();
        BaseHelper.showSnackBar(context, "Login Successfully");
        if (BaseHelper.user?.isPrivacyPolicy ?? false) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const WelcomeView()),
            (route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const PrivacyPolicyView(
                      isReadOnly: false,
                    )),
            (route) => false,
          );
        }

        return user;
      } else {
        print('no data store');
      }
    } on FirebaseAuthException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    EasyLoading.dismiss();
    return;
  }

  static logInAuth(context,
      {required String email, required String password}) async {
    BaseHelper.hideKeypad(context);
    EasyLoading.show();
    try {
      await BaseHelper.auth.signInWithEmailAndPassword(
          email: email.trim()..toLowerCase(), password: password.trim());

      await FirebaseMethod.getUserData();
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, "Login Successfully");
      if (BaseHelper.user?.isPrivacyPolicy ?? false) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const WelcomeView()),
          (route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const PrivacyPolicyView(
                    isReadOnly: false,
                  )),
          (route) => false,
        );
      }
      return;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, e.message);
    }

    EasyLoading.dismiss();
    return;
  }

  static String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static signInWithApple(BuildContext context) async {
    User? user;
    EasyLoading.show();

    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    AuthorizationCredentialAppleID? appleCredential;
    try {
      appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
    } catch (e) {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, e.toString());
    }

    if (appleCredential != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (appleCredential.email != null) {
        pref.setStringList("${appleCredential.identityToken}", [
          "${appleCredential.givenName} ${appleCredential.familyName}",
          "${appleCredential.email}"
        ]);
      }
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      try {
        user =
            (await BaseHelper.auth.signInWithCredential(oauthCredential)).user;

        await FirebaseMethod.getUserData();

        if (BaseHelper.user == null) {
          List<String>? localData =
              pref.getStringList(appleCredential.identityToken!);
          print("created");
          await BaseHelper.auth.currentUser?.updateDisplayName(
              "${appleCredential.givenName} ${appleCredential.familyName}");

          var data = UserModel(
              role: RoleName.none,
              dob: '',
              city: '',
              gender: '',
              isFederationRanking: "",
              federationRanking: "",
              name: localData != null
                  ? localData[0]
                  : "${appleCredential.givenName} ${appleCredential.familyName}",
              email: localData != null
                  ? localData[1]
                  : user?.email.toString() ?? "",
              federationLink: '',
              profilePhoto: "",
              isKeepLeaderboard: "",
              password: '',
              isPrivacyPolicy: false);
          await FirebaseMethod.setUserData(data);

          await FirebaseMethod.getUserData();
        } else if (FirebaseAuth
                .instance.currentUser?.providerData.first.providerId !=
            'apple.com') {
          await FirebaseAuth.instance.currentUser?.unlink("apple.com");
          await FirebaseAuth.instance.signOut();
          BaseHelper.user = null;
          BaseHelper.currentUser = BaseHelper.auth.currentUser;
          EasyLoading.dismiss();
          BaseHelper.showSnackBar(context,
              "Use different account already user exist with same email");
          return null;
        }

        EasyLoading.dismiss();
        BaseHelper.showSnackBar(context, "Login Successfully");
        if (BaseHelper.user?.isPrivacyPolicy ?? false) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeView()),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const PrivacyPolicyView(
                      isReadOnly: false,
                    )),
            (route) => false,
          );
        }

        return user;
      } on FirebaseAuthException catch (e) {
        BaseHelper.showSnackBar(context, e.message);
      }

      EasyLoading.dismiss();
      return null;
    }
  }

  static signInFacebbok(context) async {
    var facebookAuth = FacebookAuth.instance;
    User? user;
    BaseHelper.hideKeypad(context);

    EasyLoading.show();
    final LoginResult loginResult =
        await FacebookAuth.instance.login(permissions: [
      "email",
      "public_profile",
      "user_birthday",
      "user_gender",
    ]);

    if (loginResult.accessToken?.token == null) {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, loginResult.message);

      return null;
    } else {
      final data = facebookAuth.getUserData(
          fields: "name,email,picture,birthday,gender");
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      try {
        user =
            (await BaseHelper.auth.signInWithCredential(facebookAuthCredential))
                .user;

        await FirebaseMethod.getUserData();
        if (BaseHelper.user == null) {
          print("created");

          var data = UserModel(
              role: RoleName.none,
              dob: '',
              city: '',
              gender: '',
              isFederationRanking: "",
              federationRanking: "",
              name: user?.displayName.toString() ?? "",
              email: user?.email.toString() ?? "",
              federationLink: '',
              profilePhoto: user?.photoURL.toString() ?? "",
              isKeepLeaderboard: "",
              password: '',
              isPrivacyPolicy: false);
          await FirebaseMethod.setUserData(data);

          final http.Response response = await http.get(Uri.parse(
              "https://graph.facebook.com/${loginResult.accessToken?.userId}?fields=birthday,gender,location&access_token=${loginResult.accessToken?.token}"));

          if (response.statusCode == 200) {
            final Map data = jsonDecode(response.body);
            if (data.containsKey("gender") || data.containsKey("birthday")) {
              final gender = data['gender'];
              final birth = data['birthday'];
              Map<String, dynamic> loc = data['location'];

              if (birth != null) {
                DateTime date =
                    DateFormat("MM/dd/yyyy").parse(birth.toString());
                FirebaseMethod.updateData(
                    {"dob": DateFormat('MMM,dd,yyyy').format(date)});
                int days = DateTime.now().difference(date).inDays;
                if (days <= 2922) {
                  EasyLoading.dismiss();
                  BaseHelper.showSnackBar(
                      context, 'your age is less than 8 years');

                  return null;
                }
              } else {
                EasyLoading.dismiss();
                BaseHelper.showSnackBar(context, "failed to retrieve dob");
                return null;
              }

              if (gender != null) {
                FirebaseMethod.updateData({
                  "gender": gender == "male"
                      ? 'M'
                      : gender == "female"
                          ? "F"
                          : ''
                });
              } else {
                EasyLoading.dismiss();
                BaseHelper.showSnackBar(context, "failed to retrieve gender");
                return null;
              }
              FirebaseMethod.updateData({"city": loc['name']});
            } else {
              EasyLoading.dismiss();
              BaseHelper.showSnackBar(context, "Choose your orignal account");

              return null;
            }
            Map<String, dynamic> map = await facebookAuth.getUserData();
            await user?.updatePhotoURL(map['picture']['data']['url']);
            print(user?.photoURL);
            await FirebaseMethod.getUserData();
          }
        }

        EasyLoading.dismiss();
        BaseHelper.showSnackBar(context, "Login Successfully");
        if (BaseHelper.user?.isPrivacyPolicy ?? false) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeView()),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const PrivacyPolicyView(
                      isReadOnly: false,
                    )),
            (route) => false,
          );
        }

        return user;
      } on FirebaseAuthException catch (e) {
        BaseHelper.showSnackBar(context, e.message);
      }
    }

    EasyLoading.dismiss();
    return null;
  }

  static signInGoogle(context) async {
    User? user;
    BaseHelper.hideKeypad(context);
    EasyLoading.show();

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.profile",
      'https://www.googleapis.com/auth/user.birthday.read',
      "https://www.googleapis.com/auth/user.gender.read",
      "https://www.googleapis.com/auth/user.addresses.read"
    ];
    GoogleSignInAccount? googleSignInAccount;
    try {
      final GoogleSignIn googleUser = GoogleSignIn(
        // signInOption: SignInOption.games,
        scopes: scopes,
      );
      googleSignInAccount = await googleUser.signIn();
    } catch (e) {
      BaseHelper.showSnackBar(context, e.toString());
      EasyLoading.dismiss();
      return;
    }

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await BaseHelper.auth.signInWithCredential(credential);
        user = userCredential.user;
        await FirebaseMethod.getUserData();
        if (BaseHelper.user == null) {
          var userData = UserModel(
              role: RoleName.none,
              dob: '',
              city: '',
              gender: '',
              isFederationRanking: "",
              federationRanking: "",
              name: user?.displayName.toString() ?? "",
              email: user?.email.toString() ?? "",
              federationLink: '',
              profilePhoto: user?.photoURL.toString() ?? "",
              isKeepLeaderboard: "",
              password: '',
              isPrivacyPolicy: false);

          final http.Response response = await http.get(
            Uri.parse('https://people.googleapis.com/v1/people/me'
                '?personFields=locations,birthdays,genders,addresses,sipAddresses'),
            headers: await googleSignInAccount.authHeaders,
          );

          if (response.statusCode == 200) {
            final Map data = jsonDecode(response.body);
            if (data.containsKey("genders") || data.containsKey("birthdays")) {
              await FirebaseMethod.setUserData(userData);

              final List birth = data['birthdays'];

              var birthdays = {};
              if (birth.length > 1) {
                birthdays = birth[1]["date"];
              } else {
                birthdays = birth[0]["date"];
              }

              DateTime date = DateFormat("yyyy MM dd").parse(
                  "${birthdays['year']} ${birthdays['month']} ${birthdays['day']}}");

              int days = DateTime.now().difference(date).inDays;
              if (days <= 2922) {
                EasyLoading.dismiss();
                BaseHelper.showSnackBar(
                    context, 'your age is less than 8 years');
                BaseHelper.auth.currentUser?.delete();
                GoogleSignIn().signOut();
                return null;
              }
              FirebaseMethod.updateData(
                  {"dob": DateFormat('MMM,dd,yyyy').format(date)});

              final gender = data['genders'][0]["formattedValue"];
              if (gender != null) {
                FirebaseMethod.updateData({
                  "gender": gender == "Male"
                      ? 'M'
                      : gender == "Female"
                          ? "F"
                          : ''
                });
              } else {
                EasyLoading.dismiss();
                BaseHelper.showSnackBar(context, "failed to retrieve gender");
                return null;
              }
            } else {
              EasyLoading.dismiss();
              BaseHelper.showSnackBar(context,
                  "Your Selected email: ${BaseHelper.auth.currentUser?.email} does not have gender and dob details");

              BaseHelper.auth.currentUser?.delete();
              GoogleSignIn().signOut();
              return null;
            }
          } else {
            EasyLoading.dismiss();

            BaseHelper.showSnackBar(
                context, "Something went wrong geting data from google");
            BaseHelper.auth.currentUser?.delete();
            GoogleSignIn().signOut();

            return null;
          }

          await FirebaseMethod.getUserData();
        }

        EasyLoading.dismiss();
        BaseHelper.showSnackBar(context, "Login Successfully");
        if (BaseHelper.user?.isPrivacyPolicy ?? false) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeView()),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const PrivacyPolicyView(
                      isReadOnly: false,
                    )),
            (route) => false,
          );
        }

        return user;
      } on FirebaseAuthException catch (e) {
        EasyLoading.dismiss();
        BaseHelper.showSnackBar(context, e.message);
        GoogleSignIn().signOut();
      }
    } else {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, "Select account for login");
      return null;
    }

    EasyLoading.dismiss();
    return null;
  }

  static Future<void> initDynamicLinks() async {
    await Future.delayed(const Duration(seconds: 3));

    PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    var deepLink = data?.link;
    final queryParams = deepLink?.queryParameters;
    if (queryParams != null) {}

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      // final queryParams = dynamicLinkData.link.queryParameters;
      // print(queryParams);
    }).onError((_) {
      // Handle errors
    });
  }

  static Future<String> createDynamicLink() async {
    try {
      String domainUrl = 'https://flutterwannaplayapp.page.link';
      final DynamicLinkParameters parameters = DynamicLinkParameters(
          uriPrefix: domainUrl,
          link: Uri.parse('https://www.flutterwannaplayapp.com/'),
          androidParameters: const AndroidParameters(
              packageName: 'com.azzurri.flutter_wanna_play_app'),
          iosParameters: const IOSParameters(
            bundleId: 'com.azzurri.flutterWannaPlayApp',
          ));
      final shortDynamicLink =
          await FirebaseDynamicLinks.instance.buildShortLink(parameters);
      final Uri uri = shortDynamicLink.shortUrl;
      return uri.toString();
    } catch (_) {
      return '';
    }
  }

  static logOut(context) async {
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
    BaseHelper.showSnackBar(context, "Logout Successfully");
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const WelcomeView()),
      (route) => false,
    );
  }

  static Future forgetPassword(context, {required String email}) async {
    BaseHelper.hideKeypad(context);
    EasyLoading.show();
    try {
      await BaseHelper.auth.sendPasswordResetEmail(
        email: email.trim()..toLowerCase(),
      );
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, e.message);
      return;
    }
    EasyLoading.dismiss();
    BaseHelper.showSnackBar(context,
        'Password Reset Email Sent Has been sent to ${email.trim().toLowerCase()}');

    return;
  }
}
