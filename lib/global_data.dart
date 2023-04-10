import 'package:flutter/material.dart';

class GlobalData {
  static const int appVersion = 2;
  static const String appName = "املاک آلونک";
}

class GlobalColor {
  static const Color colorPrimary = Color(0xff41444c);
  static const Color colorPrimaryDark = Color(0xff2E3036);
  static const Color colorAccent = Color(0xffFFB900);
  static const Color colorAccentDark = Color(0xffFF7D00);
  static const Color colorTextPrimary = Color(0xff202020);
  static const Color colorTextSecondary = Color(0xff454545);

  static const Color colorTextOnPrimary = Color(0xffffffff);
  static const Color colorBackground = Color(0xffffffff);
  static const Color colorOnAccent = Color(0xffffffff);
  static const Color extraPriceColor = Color(0xff1242ed);


  static MaterialColor getMaterialColor(Color color) {
    final Map<int, Color> shades = {
      50: Color.fromRGBO(136, 14, 79, .1),
      100: Color.fromRGBO(136, 14, 79, .2),
      200: Color.fromRGBO(136, 14, 79, .3),
      300: Color.fromRGBO(136, 14, 79, .4),
      400: Color.fromRGBO(136, 14, 79, .5),
      500: Color.fromRGBO(136, 14, 79, .6),
      600: Color.fromRGBO(136, 14, 79, .7),
      700: Color.fromRGBO(136, 14, 79, .8),
      800: Color.fromRGBO(136, 14, 79, .9),
      900: Color.fromRGBO(136, 14, 79, 1),
    };
    return MaterialColor(color.value, shades);
  }
}

class GlobalString {
  static const signUpString = 'ثبت نام کاربر';

  static String enterMobileString = 'شماره تلفن همراه';

  static const String confirmMobile = "تایید شماره";
  static const String confirmSmsCode = "تایید شماره تلفن همراه";
  static const String notInterested = "تمایلی ندارم";
  static const String enterSmsCode = "کد ارسال شده";
  static const String enterCaptcha = "کد امنیتی";
  static const String sendCodeAgain = "ارسال مجدد کد اعتبار سنجی";
  static const String sendCondCountDown = " ثانیه تا درخواست مجدد کد";
  static const String changeNumber = "تغییر شماره";
  static const String loading = "در حال دریافت اطلاعات";

  static const String next = "بعدی";
  static const String news = "اخبار";
  static const String estate = "املاک";


}
