import 'dart:async';

import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/screen/splash_screen.dart';

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
      supportedLocales: const [Locale("fa")],
      locale: const Locale("fa"),
      title: "الونک",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      // home: ( ArticleList()),
    );
  }
}
