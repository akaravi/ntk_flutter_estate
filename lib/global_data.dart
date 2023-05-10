import 'package:flutter/material.dart';

class GlobalData {
  static const int appVersion = 2;
  static const String appName = "املاک آلونک";
  static double screenWidth = -1;
  static double screenHeight = -1;
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
  static const Color colorError = Color(0xFFB71C1C);
  static const Color colorShimmer = Color(0xffffebb1);
  static const Color extraTimeAgoColor = Colors.lightBlue;

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
  static const String profile = "حساب کاربری";
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
  static const String newList = "جدیدترین";
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
  static const String add = "ثبت نهایی";
  static const String estateCode = "کد ملک";
  static const String title = "عنوان";
  static const String desc = "توضیحات";
  static const String location = "موقعیت";
  static const String address = "آدرس";
  static const String mapLocation = "موقعیت تقریبی";
  static const String contractType = "نوع قرارداد";
  static const String currency = "واحد پولی";
  static const String noSelected = "موردی انتخاب نشده است";
  static const String agreement = "به صورت توافقی";
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

  static const String plzInsertTitle = "عنوان نورد نظر خود را وارد کنید";
  static const String insertTypeUsage = "نوع کاربری را انتخاب نمایید";
  static const String insertTypeUse = "نوع ملک را انتخاب نمایید";
  static const String insertArea = "متراژ را وارد نمایید";

  static const String insertDesc = "توضیحات  را وارد نمایید";
  static const String insertLocation = "منظقه مورد نظر  را وارد نمایید";
  static const String insertAddress = " آدرس را وارد نمایید";
  static const String plzInsertContract =
      "لطفا برای این ملک حداقل یک نوع معامله وارد نمایید";
  static const String countryLoc = "کشور";
  static const String provinceLoc = "استان";
  static const String cityLoc = "شهر";
  static const String areaLoc = "منطقه";
  static const String confirmLocation = "ثبت موقعیت";
  static const String plzSelectLocation = "موقعیت جهت ثبت انتخاب کنید";
  static const String plzInsertNum = " مورد نظر خود را وارد نمایید";
  static const String max = "حداکثر";
  static const String min = "حداقل";
  static const String from = " از : ";
  static const String to = " تا : ";
  static const String confirm = "تایید";
  static const String range = "مجدوده ی ";
  static const String searchResult = "نتایج جست و جو";
  static const String errorInUpload = "خطا در اپلود";
  static const String noImageAdded = "فایلی انتخاب نشده است";
  static const String duplicateFileUpload = "فایل انتخاب شده تکراری است";
  static const String delete = "حذف";
  static const String slider = "تصاویر";
  static const String needLogin =
      "برای ثبت ملک نیاز است که به حساب خود وارد شوید. آیا مایلید به صفحه ی ورود هدایت شوید؟";

  static const String yes = "بلی";
  static const String error = "خطا";
  static const String cantBeEmpty = "باید مقدار داشته باشد";
  static const String atleast6digit = "حداقل شش رقمی باشد";
  static const String enterMobileCorrect =
      "شماره تلفم خود را به صورت صحیح وارد کنید";

  static const String contactUs = "تماس با ما";
  static const String telephone = "َشماره تلفن تماس";
  static const String fax = "ََشماره فکس";
  static const String email = "ایمیل";
  static const String submit = "ثبت";
  static const String build = "نسخه ی کنونی";
  static const String successfullyAddVote = "نظر شما با موفقیت ثبت شد";
  static const String ticketing = "پشتیبانی";
  static const String newTicket = "تیکت جدید";
  static const String fullName = "نام و نام خانوادگی";
  static const String edit = "ویرایش";
  static const String history = "تاریخچه";
  static const String share = "اشتراک گذاری";
  static const String no = "خیر";
  static const String alert = "هشدار";
  static const String visitCount = "تعداد مشاهدات";
  static const String projects2 = "";

  static String deleteConfirm = "آیا نسبت به حذف این مورد مطمئن هستید؟ ";

  static const String result = "نتایج";
}
