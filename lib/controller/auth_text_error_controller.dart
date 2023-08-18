import 'package:flutter/widgets.dart';
import 'package:ntk_flutter_estate/global_data.dart';

abstract class AuthTextErrorController {
  String? registerPasswordError(TextEditingController controller) {
    var text = controller.text;
    if (text.isEmpty) {
      return GlobalString.cantBeEmpty;
    }
    if (text.length < 4) {
      return GlobalString.atleast6digit;
    }
    return "";
  }

  String? textEmptyError(TextEditingController controller) {
    var text = controller.text;
    if (text.isEmpty) {
      return GlobalString.cantBeEmpty;
    }
    return "";
  }

  String? loginUsernameError(TextEditingController controller) {
    var text = controller.text;
    if (text.isEmpty) {
      return GlobalString.cantBeEmpty;
    }
    if (!isEmailValid(text) && !isMobileValid(text)) {
      return GlobalString.enterMobileCorrect;
    }
    return "";
  }

  String? registerEmailError(TextEditingController controller) {
    var text = controller.text;
    if (text.isEmpty) {
      return GlobalString.cantBeEmpty;
    }
    if (!isEmailValid(text)) {
      return 'enter your email address correctly';
    }
    return "";
  }

  String? registerMobileError(TextEditingController controller) {
    var text = controller.text;
    if (text.isEmpty) {
      return GlobalString.cantBeEmpty;
    }
    if (!isMobileValid(text)) {
      return GlobalString.enterMobileCorrect;
    }
    return "";
  }

  ///is password have complexity for setting
  bool _isPasswordCompliant(String password) {
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasSpecialCharacters = true;
    //     password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters;
  }

  /// is value have email patten
  bool isEmailValid(String value) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(p);
    return (regex.hasMatch(value));
  }

  /// is value have phone patten
  bool isMobileValid(String value) {
    String p = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    RegExp regex = RegExp(p);
    return (regex.hasMatch(value));
  }
}
