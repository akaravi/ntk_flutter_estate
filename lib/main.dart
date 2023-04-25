import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/auth/auth_sms_confirm.dart';
import 'package:ntk_flutter_estate/screen/customer_order/new_customer_order_screen.dart';
import 'package:ntk_flutter_estate/screen/estate/estate_search.dart';
import 'package:ntk_flutter_estate/screen/generalized/intro_screen.dart' as d;
import 'package:ntk_flutter_estate/screen/main_screen.dart';
import 'package:ntk_flutter_estate/screen/news/news_list_screen.dart';
import 'package:ntk_flutter_estate/screen/generalized/splash_screen.dart';
import 'package:ntk_flutter_estate/screen/test2.dart';
import 'package:ntk_flutter_estate/screen/test_checkable.dart';
import 'package:ntk_flutter_estate/screen/test_scroll.dart';
import 'package:ntk_flutter_estate/screen/test_widget.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';

import 'screen/auth/auth_sms_screen.dart';
import 'screen/generalized/sub_empty_screen.dart';
import 'screen/add/user_location_on_map_screen.dart';
import 'screen/test.dart';

void main() async {
  //prevent from crash on start
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      //read static data of app
      NTKApplication.get(packageName: "ntk.android.estate.APPNTK");
      await MyApplicationPreference().read();

      //main thread of creating app
      runApp(const MyApp());
    },
    (error, st) => print(error),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [Locale("fa"), Locale("en")],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: const Locale("fa"),
      title: "الونک",
      theme: ThemeData(
        primarySwatch: GlobalColor.getMaterialColor(GlobalColor.colorPrimary),
      ),
      // home: const TestWidget(),
      // home:  EstateSearchScreen(),
      // home: TestCheck()
      // home: const TestScroll(),
      // home: const TestCheck(),
      home: SplashScreen(),
      // home:  MainScreen(),
      // home:  SubEmptyScreen(title: "موردی یافت نشد"),
      // home: AuthSmsConfirmScreen("09132131542"),
      // home: NewEstateScreen(),
      // home: NewCustomerOrderScreen(),
      // home: ( ArticleList()),
    );
  }
}
