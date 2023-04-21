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
  static const Color colorSemiBackground = Color(0xffd8d7d7);

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
  static const String article = "مقالات";
  static const String estate = "املاک";
  static const String meter = "متر";
  static const String estateId = "شماره ملک";
  static const String login = "ورود";
  static const String profile = "پروفایل";
  static const String myEstate = "املاک من";
  static const String myRequests = "درخواست های من";
  static const String favoriteList = "لیست علاقه مندی";
  static const String ticket = "پشتیبانی";
  static const String polling = "نظرسنجی";
  static const String inbox = "صندوق پیام";
  static const String faq = "پرسش های متداول";
  static const String feedback = "بازخورد";
  static const String aboutUs = "درباره ما";
  static const String help = "راهنما";
  static const String inviteFriend = "دعوت از دوستان";
  static const String exit = "خروج";
  static const String searchDotDotDot = "جست و جو . . .";
  static const String userID = "شناسه ی کاربری :";
  static const String noUserID = "فاقد شناسه ی کاربری";
  static const String guest = "کاربر مهمان";
  static const String mobile = "تلفن همراه";
  static const String addDotDotDot = "ثبت . . .";
  static const String landUsedList = "دسته بندی املاک";
  static const String seeAll = "مشاهده همه";
  static const String newList = "حدیدترین";
  static const String suggestedEstate = "پیشنهادی";
  static const String dailyRent = "اجاره روزانه";
  static const String companies = "انبوه سازان";
  static const String projects = "پروژه ها";
  static const String estateType = "نوع ملک";
  static const String areaAsMeter = "مساحت (متر مربع)";
  static const String estateTypeUsage = "نوع کاربری";
  static const String newEstateProperties = "مشحصات کلی ";
  static const String newEstateDetails = "جزئیات و مشخصات";
  static const String newEstateFeatures = "مشخصات آگهی";
  static const String newEstateExtraFeatures = "سایر مشخصات";
  static const String newEstateContracts = "شرایط معامله";
  static const String newEstatePictures = "تصاویر ملک";
  static const String newEstate = "ملک جدید";
  static const String continueStr = "ادامه";
  static const String back = "بازگشت";
  static const String add = "ثب";
  static const String estateCode = "کد ملک";
  static const String title = "عنوان";
  static const String desc = "توضیحات";
  static const String location = "موقعیت";
  static const String address = "آدرس";
  static const String mapLocation = "موقعیت تقریبی";
  static const String contractType = "نوع قرارداد";
  static const String currency = "واحد پولی";
  static const String noSelected = "موردی انتخاب نشده است";
  static const String agreementSale = "به صورت توافقی";
  static const String mainPic = "عکس اصلی";
  static const String morePic = "عکس های بیشتر";
  static const String estimateLoc = "مکان تقریبی";
  static const String submitLocation = "ثبت مکان";
  static const String noLocSelected = "نقطه ای روی نقشه انتخب نشده است";
  static const String selectLoc = "تعیین محدوده";
  static const String addToContract = "افزودن به لیست";
  static const String contractsList = "لیست معاملات ثبت شده";
  static const String noContractsAdd = "موردی ثبت نشده است";
  static const String newOrder = "سفارش جدید";
  static const String reTry = "تلاش مجدد";
  static const String keywords = "کلمه کلیدی";
  static const String testString = "asdasdlmak a,amskdjal as.,dalkw";
  static const String contractProperties = "مشخصات قرارداد";
  static const String estateTypeUsageProperties = "مشخصات کاربری ملک";
  static const String select = "انتخاب";

  static const String projects1 = "";
  static const String projects2 = "";
}
