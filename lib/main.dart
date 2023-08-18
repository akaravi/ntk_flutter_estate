import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/generalized/splash_screen.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  //prevent from crash on start
  await runZonedGuarded(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      //read static data of app
      NTKApplication.get(packageName: "ntk.android.estate.APPNTK");
      await MyApplicationPreference().read();
      await SentryFlutter.init(
            (options) {
          options.dsn = 'https://cea3c8047b464cda860ebf53e16a0a15@o1135344.ingest.sentry.io/4505177627164672';
          // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
          // We recommend adjusting this value in production.
          options.tracesSampleRate = 1.0;
        },
        appRunner: () => runApp(MyApp()),
      );
    },
        (error, st) => print(error),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GetTimeAgo.setDefaultLocale('fa');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home:  SplashScreen(),
    );
  }
}
