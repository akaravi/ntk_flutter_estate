import 'package:base/src/index.dart';

import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/MainController.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:lottie/lottie.dart';
import 'package:ntk_flutter_estate/screen/auth/auth_sms_screen.dart';
import 'base_auth.dart';

class AuthSmsConfirmScreen extends StatefulWidget {
  String mobile;

  AuthSmsConfirmScreen(
    this.mobile, {
    Key? key,
  });

  @override
  State<AuthSmsConfirmScreen> createState() =>
      _AuthSmsConfirmScreenState(mobile);
}

class _AuthSmsConfirmScreenState extends AuthScreen<AuthSmsConfirmScreen> {
  //controller object for login form
  late final RegisterVerifyMobileController verifyController;

  bool smsNotValid = false;
  bool captchaNotValid = false;

  _AuthSmsConfirmScreenState(String mobile) : super() {
    verifyController = RegisterVerifyMobileController(mobile);
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
          Positioned.fill(
            child: Lottie.asset(
              'assets/lottie/auth_confirm_sms.json',
              repeat: true,
              reverse: true,
              fit: BoxFit.fill,
            ),
          ),
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
                padding: const EdgeInsets.only(top: 14.0, right: 4.0),
                child: !verifyController.hasTimerStopped
                    ? CountDownTimer(
                        secondsRemaining: 120,
                        whenTimeExpires: () {
                          setState(() {
                            verifyController.hasTimerStopped = true;
                          });
                        },
                        countDownTimerStyle: const TextStyle(
                          color: Color(0XFFf5a623),
                          fontSize: 17.0,
                          height: 1.2,
                        ),
                      )
                    : Center(
                        child: TextButton(
                            onPressed: () =>
                                {MyDialogs().showCaptcha(context, sendCode)},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('send again Code '),
                                Icon(Icons.refresh)
                              ],
                            )),
                      ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Expanded(
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
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 20),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          width: 1.0, color: GlobalColor.colorAccent),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20.0),
                      alignment: Alignment.center,
                      child: const Text(
                        GlobalString.notInterested,
                        style: TextStyle(color: GlobalColor.colorAccent),
                      ),
                    ),
                    onPressed: () =>
                        RegisterWithMobileController.registerMobileWithPage(
                            context, AuthSmsScreen()),
                  ),
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
    return verifyController.loadCaptcha;
  }

  registerClicked() async {
    if (verifyController.smsErrorText() != null) {
      smsNotValid = true;
    } else {
      smsNotValid = false;
    }
    if (verifyController.captchaErrorText() != null) {
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
