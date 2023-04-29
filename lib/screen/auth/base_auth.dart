import 'package:base/src/models/entity/base/captcha_model.dart';
import 'package:base/src/view/capcha_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';


abstract class AuthScreen<T extends StatefulWidget> extends State<T> {
  final Color gray=GlobalColor.colorTextPrimary.withOpacity(.8);
  AuthScreen();

  Widget getHintWidget(
      String title,
      String? error,
      ) {
    TextStyle hintStyle =  TextStyle(color:gray, fontSize: 16.0);
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Text.rich(TextSpan(text: title, style: hintStyle, children: [
        TextSpan(
          text: "  " + (error ?? ''),
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        )
      ])),
    );
  }

  Widget getTextInputWidget(
      IconData icon, String hint, TextEditingController textFieldController,
      {bool passwordType = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color:gray.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Icon(
              icon,
              color:gray,
            ),
          ),
          Container(
            height: 30.0,
            width: 1.0,
            color:gray.withOpacity(0.5),
            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
          ),
          Expanded(
            child: TextField(
              controller: textFieldController,
              obscureText: passwordType,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle:  TextStyle(color:gray),
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget getCaptchaWidget(TextEditingController captchaTextController,
      {void Function(CaptchaModel chModel)? func}) {
    func ??= loadCaptcha;
    return captchaInputLayout(captchaTextController, func);
  }

  static captchaInputLayout(TextEditingController captchaTextController,
      void Function(CaptchaModel chModel)? func) {
    Color gray=GlobalColor.colorTextPrimary.withOpacity(.8);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color:gray,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
             Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Icon(
                Icons.verified_user_outlined,
                color:gray,
              ),
            ),
            Container(
              height: 30.0,
              width: 1.0,
              color:gray.withOpacity(0.5),
              margin: const EdgeInsets.only(left: 00.0, right: 10.0),
            ),
            Expanded(
              child: TextField(
                controller: captchaTextController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: GlobalString.enterCaptcha,
                  hintStyle: TextStyle(color:GlobalColor.colorPrimary),
                ),
              ),
            ),
            CaptchaWidget(func)
          ],
        ),
      ),
    );
  }

   void loadCaptcha(CaptchaModel chModel);
}
