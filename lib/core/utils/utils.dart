import 'package:auth_flutter/core/utils/strings.dart';

class Utils {
  static bool isEmail(String input) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      caseSensitive: false,
    );
    return emailRegExp.hasMatch(input);
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty || !Utils.isEmail(value)) {
      return Strings.invalidEmailError;
    }

    return null;
  }

  static String? passwordlValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 4) {
      return Strings.invalidPasswordError;
    }

    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.invalidNameError;
    }

    return null;
  }
}
