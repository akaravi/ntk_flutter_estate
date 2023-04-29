import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/auth_sms_controller.dart';
import 'package:ntk_flutter_estate/controller/auth_text_error_controller.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/controller/main_controller.dart';
import 'package:ntk_flutter_estate/screen/auth/auth_sms_confirm.dart';
class AuthSmsConfirmController with AuthTextErrorController {
  ///entered mobile number that get from register page
  String mobileNumber;

  ///last captcha get form url
  late CaptchaModel model;

  /// Create a text controller and use it to retrieve the current value
  /// of the TextField.
  final TextEditingController smsTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController captchaTextController = TextEditingController();

  bool hasTimerStopped = false;

  ///constructor
  AuthSmsConfirmController(this.mobileNumber);

  static void verifyPage(BuildContext context, String mobile) {
    Future.microtask(() => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AuthSmsConfirmScreen(mobile))));
  }

  ///when user want to login with one step verifying mobile number
  ///he can go ahead if enter sms code correctly
  /// if he enter smsCode correctly  api return true as successful message
  Future<bool> loginMobileWithVerify() async {
    String sms = smsTextController.text;
    String captchaText = captchaTextController.text;
    String captchaKey = model.key ?? '';
    AuthUserSignInBySmsDtoModel req = AuthUserSignInBySmsDtoModel()
      ..mobile = mobileNumber
      ..code = sms
      ..captchaText = captchaText
      ..captchaKey = captchaKey;

    var response = await AuthService().loginWithSMS(req, saveId: true);
    if (response.isSuccess) {
      return true;
    }
    return false;
  }

  smsErrorText() {
    return textEmptyError(smsTextController);
  }

  captchaErrorText() {
    return textEmptyError(captchaTextController);
  }



  ///load captcha on as model for use on api call
  Future<String> loadCaptcha() async {
    model = await AuthService().getCaptcha();
    return model.image ?? '';
  }

  void mainPage(BuildContext context) {
    MainScreenController().startScreen(context);
  }

  ///dispose all instance of controller on exit
  void dispose() {
    smsTextController.dispose();
    captchaTextController.dispose();
  }

  Future<bool> resendCode(CaptchaModel captcha, String text) async {
    var s = await AuthSmsController().sendCode(mobileNumber,text,captcha.key??'');
    //if not empty
    return s.isNotEmpty;
  }
}
