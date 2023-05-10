import 'package:base/src/index.dart';

import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/auth_sms_controller.dart';
import 'package:ntk_flutter_estate/controller/main_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:lottie/lottie.dart';
import 'base_auth.dart';

class AuthSmsScreen extends StatefulWidget {
  AuthSmsScreen({
    Key? key,
  });

  @override
  State<AuthSmsScreen> createState() => _AuthSmsScreenState();
}

class _AuthSmsScreenState extends AuthScreen<AuthSmsScreen> {
  //controller object for login form
  final registerMobileController = AuthSmsController();

  bool mobileNotValid = false;
  bool captchaNotValid = false;

  _AuthSmsScreenState() : super();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    registerMobileController.dispose();
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
          child: Stack(
            children: [  Positioned.fill(
              child: Lottie.asset(
                'assets/lottie/auth_sms.json',
                repeat: true,reverse: true,
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
                      child: Text(GlobalString.signUpString,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: GlobalColor.colorTextPrimary,
                              fontSize: 24)),
                    ),
                  ),

                  //mobile text field
                  getTextInputWidget(
                    Icons.phone_android_outlined,
                    GlobalString.enterMobileString,
                    registerMobileController.userNameTextController,
                  ),
                  //mobile hint
                  getHintWidget(
                    "",
                    mobileNotValid
                        ? registerMobileController.usernameErrorText()
                        : null,
                  ),

                  //captcha text field
                  getCaptchaWidget(
                      registerMobileController.captchaTextController),
                  //captcha hint
                  getHintWidget(
                      "",
                      captchaNotValid
                          ? registerMobileController.captchaErrorText()
                          : null),
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
                        onPressed: () => registerMobileController.notInterested(
                            context),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  loadCaptcha(CaptchaModel chModel) {
     registerMobileController.model=chModel;

  }

  registerClicked() async {
    if (registerMobileController.usernameErrorText() != null) {
      mobileNotValid = true;
    } else {
      mobileNotValid = false;
    }
    if (registerMobileController.captchaErrorText() != null) {
      captchaNotValid = true;
    } else {
      captchaNotValid = false;
    }

    setState(() {});
    //if error Occurred
    if (mobileNotValid || captchaNotValid) {
      return;
    }
    var myDialogs = MyDialogs();
    myDialogs.showProgress(context);

    try {
      var mobile = await registerMobileController.signupMobileWithSms();
      //dismiss loading dialog
      myDialogs.dismiss(context);
      //go to verify page
      if (mobile.isNotEmpty) {
        LoginCache().setMobile(registerMobileController.mobile());
        registerMobileController.verifyMobile(context, mobile);
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
}
