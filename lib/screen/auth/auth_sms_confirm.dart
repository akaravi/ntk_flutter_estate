import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ntk_flutter_estate/controller/auth_sms_confrim_controller.dart';
import 'package:ntk_flutter_estate/controller/auth_sms_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/auth/auth_sms_screen.dart';

import 'base_auth.dart';

class AuthSmsConfirmScreen extends StatefulWidget {
  String mobile;
  CaptchaModel model;
  String captchaText;
  AuthSmsConfirmScreen(
    { required this.model,required this.mobile,required this.captchaText,
    Key? key,
  });

  @override
  State<AuthSmsConfirmScreen> createState() =>
      _AuthSmsConfirmScreenState(mobile, model,captchaText);
}

class _AuthSmsConfirmScreenState extends AuthScreen<AuthSmsConfirmScreen> {
  //controller object for login form
  late final AuthSmsConfirmController verifyController;

  bool smsNotValid = false;
  bool captchaNotValid = false;

  _AuthSmsConfirmScreenState(String mobile, CaptchaModel model,String captchaText) : super() {
    verifyController = AuthSmsConfirmController(mobile, model,captchaText);
  }

  @override
  void initState() {
    CaptchaWidget.captcha = verifyController.model;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    verifyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(children: [
          // Positioned.fill(
          //   child: Lottie.asset(
          //     'assets/lottie/auth_confirm_sms.json',
          //     repeat: true,
          //     reverse: true,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 100.0, bottom: 40),
                  child: Text(GlobalString.confirmSmsCode,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: GlobalColor.colorTextPrimary,
                          fontSize: 24)),
                ),
              ),

              //mobile text field
              getTextInputWidget(
                Icons.phone_android_outlined,
                GlobalString.enterSmsCode,
                verifyController.smsTextController,
              ),
              //sms code hint
              getHintWidget(
                "",
                smsNotValid ? verifyController.smsErrorText() : null,
              ),

              //captcha text field
              getCaptchaWidget(verifyController.captchaTextController),
              //captcha hint
              getHintWidget("",
                  captchaNotValid ? verifyController.captchaErrorText() : null),

              Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      backgroundColor: GlobalColor.colorPrimary,
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20.0),
                      alignment: Alignment.center,
                      child: const Text(GlobalString.confirmMobile,
                          style: TextStyle(
                              color: GlobalColor.colorTextOnPrimary,
                              fontSize: 16)),
                    ),
                    onPressed: () => registerClicked()),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        width: 1.0, color: GlobalColor.colorAccent),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    alignment: Alignment.center,
                    child: const Text(
                      GlobalString.changeNumber,
                      style: TextStyle(color: GlobalColor.colorAccent),
                    ),
                  ),
                  onPressed: () => AuthSmsController.registerMobileWithPage(
                      context, verifyController.model),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0, right: 4.0),
                child: !verifyController.hasTimerStopped
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CountDownTimer(
                            secondsRemaining: 60,
                            whenTimeExpires: () {
                              setState(() {
                                verifyController.hasTimerStopped = true;
                              });
                            },
                            countDownTimerStyle: const TextStyle(
                              color: GlobalColor.colorPrimary,
                              fontSize: 12.0,
                            ),
                          ),
                          const Text(GlobalString.sendCondCountDown,
                              style: TextStyle(
                                color: GlobalColor.colorPrimary,
                                fontSize: 12.0,
                              ))
                        ],
                      )
                    : Center(
                        child: TextButton(
                            onPressed: () =>
                                {MyDialogs().showCaptcha(context, sendCode)},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(GlobalString.sendCodeAgain,
                                    style: TextStyle(fontSize: 13)),
                                Icon(Icons.refresh)
                              ],
                            )),
                      ),
              ),
            ],
          ),
        ]),
      ),
    ));
  }

  @override
  loadCaptcha(CaptchaModel chModel) {
    verifyController.model = chModel;
  }

  registerClicked() async {
    if (verifyController.smsErrorText() != "") {
      smsNotValid = true;
    } else {
      smsNotValid = false;
    }
    if (verifyController.captchaErrorText() != "") {
      captchaNotValid = true;
    } else {
      captchaNotValid = false;
    }

    setState(() {});
    //if error Occurred
    if (smsNotValid || captchaNotValid) {
      return;
    }
    var myDialogs = MyDialogs();
    myDialogs.showProgress(context);

    try {
      var bool = await verifyController.loginMobileWithVerify();
      //dismiss loading dialog
      myDialogs.dismiss(context);
      //go to main page
      if (bool) {
        verifyController.mainPage(context);
      }
    } catch (exp) {
      //dismiss loading
      myDialogs.dismiss(context);
      myDialogs.showError(
        context,
        exp.toString(),
      );
    }
  }

  sendCode(CaptchaModel captcha, String text) async {
    var myDialogs = MyDialogs();
    myDialogs.showProgress(context);
    try {
      var bool = await verifyController.resendCode(captcha, text);
      if (bool) {
        setState(() {
          verifyController.hasTimerStopped = false;
        });
        myDialogs.dismiss(context);
        //show toast
      }
    } catch (exp) {
      myDialogs.dismiss(context);
      myDialogs.showError(context, exp.toString());
    }
  }
}
