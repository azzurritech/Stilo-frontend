import 'dart:developer';

import 'package:intl/intl.dart';

class Validators {
  static String? validateField(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return "required";
    }
    return null;
  }

  static String? ageValidateField(
    String? value,
  ) {
    DateTime date = DateFormat("MMM,dd,yyyy").parse(value.toString());
    final int days = DateTime.now().difference(date).inDays;
    if (value == null || value.isEmpty) {
      return "required";
    } else if (days <= 2922) {
      return "Age is less than 8 years";
    }
    log(value);
    return null;
  }

  static String? urlValidate(
    value,
  ) {
    Pattern pattern =
        r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
    RegExp regex = RegExp(pattern as String);

    if (value.isEmpty) {
      return "url is required";
    } else if (!regex.hasMatch(value)) {
      return "Website Url must be started from www";
    }
    return null;
  }

  static String? validateDropdown(
    var value,
  ) {
    if (value == null) {
      return "required";
    }
    return null;
  }

  static String? validateEmailVerifyOTP(
    String value,
  ) {
    if (value.isEmpty) {
      return "otp_is_required";
    } else if (value.length < 6) {
      return "incorrect_otp_entered";
    }
    return null;
  }

  static String? validateEmail(value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern as String);

    if (value.isEmpty) {
      return "required";
    } else if (!regex.hasMatch(value)) {
      return "incorrect_email_entered";
    }
    return null;
  }

  static String? validatePassword(
    value,
  ) {
    if (value.isEmpty) {
      return "required";
    } else if (value.length < 8) {
      return "min_8_char_required";
    }
    return null;
  }

  static String? validateStrongPassword(
    String value,
  ) {
    // RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~+%^.,]).{8,}$');
    if (value.isEmpty) {
      return "required";
    }

    if (value.length < 8) {
      return "password_should_be_at_least_of_x_char";
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "password_should_contain_at_least_an_uppercase";
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return "password_should_contain_at_least_a_lowercase";
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return "password_should_contain_at_least_a_digit";
    }

    if (!value.contains(RegExp(r'[!@#\$&*~+%^.,]'))) {
      return "password_should_contain_at_least_a_special_char";
    }

    // if (!regex.hasMatch(value)) return 'enter_strong_password'.tr;

    return null;
  }

  static String? validatePhoneNumber(
     value,
  ) {
    Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = RegExp(pattern as String);
    if (value.isEmpty) {
      return "required";
    } else if (!regex.hasMatch(value)) {
      return "Incorrect phone number entered";
    }
    return null;
  }
}
