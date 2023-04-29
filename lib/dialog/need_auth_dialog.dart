import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/auth/auth_sms_screen.dart';
import 'package:base/src/index.dart';

class NeedAuthorization {
  show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(margin: EdgeInsets.only(right: 32,left: 32),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: GlobalColor.colorBackground,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Column(mainAxisSize: MainAxisSize.min,children: [
              const Icon(
                Icons.error_outline,
                size: 45,
                color: GlobalColor.colorError,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0,bottom: 24),
                child: Text(
                  GlobalString.error,
                  style: TextStyle(fontSize: 18,color: GlobalColor.colorError),
                ),
              ),
              const Text(
                GlobalString.needLogin,
                style: TextStyle(color: GlobalColor.colorTextPrimary),
              ),
              Row(
                children: [
                  Spacer(),  TextButton(    style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(8.0)),
                    backgroundColor: GlobalColor.colorPrimary,
                  ),
                      onPressed: () => LoginController.loginInPage(
                          context: context, newLogin: AuthSmsScreen()),
                      child: const Text(
                        GlobalString.yes,
                        style: TextStyle(color: GlobalColor.colorTextOnPrimary),
                      )),
                  Spacer(flex: 2),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(backgroundColor: GlobalColor.colorTextOnPrimary,
                        side: const BorderSide(width: 1.0, color: GlobalColor.colorPrimary),
                      ),
                      onPressed: () => BaseController().close(context),
                      child: const Text(
                        GlobalString.notInterested,
                        style: TextStyle(color: GlobalColor.colorPrimary),
                      )), Spacer(),
                ],
              )
            ]),
          ),
        );
      },
    );
  }
}
