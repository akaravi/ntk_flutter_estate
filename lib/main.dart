import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/auth/auth_sms_confirm.dart';
import 'package:ntk_flutter_estate/screen/intro_screen.dart' as d;
import 'package:ntk_flutter_estate/screen/news/news_list_screen.dart';
import 'package:ntk_flutter_estate/screen/splash_screen.dart';
import 'package:ntk_flutter_estate/screen/sub_loading_screen.dart';
import 'package:ntk_flutter_estate/screen/test_widget.dart';

import 'screen/auth/auth_sms_screen.dart';
import 'screen/sub_empty_screen.dart';

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
      home: const SplashScreen(),
      // home:  SubEmptyScreen(title: "موردی یافت نشد"),
      // home: AuthSmsConfirmScreen("09132131542"),
      // home: NewsListScreen(),
      // home: ( ArticleList()),
    );
  }
}
