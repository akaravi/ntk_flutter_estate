import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/auth_sms_confrim_controller.dart';
import 'package:ntk_flutter_estate/controller/auth_text_error_controller.dart';
import 'package:ntk_flutter_estate/controller/main_controller.dart';
import 'package:ntk_flutter_estate/screen/auth/auth_sms_screen.dart';

class AuthSmsController extends AuthTextErrorController {
  ///last captcha get form url
  late CaptchaModel model;

  /// Create a text controller and use it to retrieve the current value
  /// of the TextField.
  final TextEditingController userNameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController captchaTextController = TextEditingController();

  // ///start registering with verify mobile number with sms
  // static void registerMobile(BuildContext context) {
  //   Future.microtask(() =>
  //       Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(builder: (context) => RegisterWithMobile())));
  // }

  ///start registering with verify mobile number with sms
  static void registerMobileWithPage(
    BuildContext context,
  ) {
    Future.microtask(() => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AuthSmsScreen())));
  }

  ///dispose all instance of controller on exit
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameTextController.dispose();
    passwordTextController.dispose();
    captchaTextController.dispose();
  }

  ///when user want to login with one step verifying mobile number
  ///also provided that enter verify-sms code correctly
  /// if detect mobile number api return entered mobile number to continue
  Future<String> signupMobileWithSms() async {
    String mobile = userNameTextController.text;
    String captchaText = captchaTextController.text;
    String captchaKey = model.key ?? '';
    return await sendCode(mobile, captchaText, captchaKey);
  }

  String mobile() {
    return userNameTextController.text;
  }

  ///when user want to login with one step verifying mobile number
  ///also provided that enter verify-sms code correctly
  /// if detect mobile number api return entered mobile number to continue
  Future<String> sendCode(
      String mobile, String captchaText, String captchaKey) async {
    AuthUserSignInBySmsDtoModel req = AuthUserSignInBySmsDtoModel()
      ..mobile = mobile
      ..captchaText = captchaText
      ..captchaKey = captchaKey;

    var response = await AuthService().loginWithSMS(req);
    if (response.isSuccess) {
      return mobile;
    }
    return '';
  }

  ///load captcha on as model for use on api call
  Future<String> loadCaptcha() async {
    model = await AuthService().getCaptcha();
    return model.image ?? '';
  }

  usernameErrorText() {
    return registerMobileError(userNameTextController);
  }

  captchaErrorText() {
    return textEmptyError(captchaTextController);
  }

  void notInterested(
    BuildContext context,
  ) {
    MainScreenController().startScreen(context);
  }

  void verifyMobile(BuildContext context, String mobile) {
    AuthSmsConfirmController.verifyPage(context, mobile);
  }
}
