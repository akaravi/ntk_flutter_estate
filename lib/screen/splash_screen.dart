import 'package:base/src/controller/base/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:lottie/lottie.dart';
import 'package:ntk_flutter_estate/screen/estate/estate_list_screen.dart';

import 'auth/auth_sms_screen.dart';
import 'intro_screen.dart';
import 'news/news_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return StreamBuilder<SplashProgress>(
        stream: SplashController().initApp(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //get progress send
            var splashProgress = snapshot.data ?? SplashProgress.ifNull();
            //if progress is complete go to next Page
            if (splashProgress.progress == 1) {
              SplashController().nextPage(context,
                  intro: IntroScreen(),
                  login: AuthSmsScreen(),
                  main: EstateListScreen());
            } else {
              return splash(splashProgress);
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('محددا تلاش کنید'),
            );
          }
          return Container();
        });
  }

  Widget splash(SplashProgress data) {
    final background = Lottie.asset(
      'assets/lottie/circle_reval.json',
      repeat: false,
      fit: BoxFit.fill,
    );

    final logo = Lottie.asset('assets/lottie/splash_logo.json');

    var cortTextStyle = const TextStyle(
      fontSize: 12,
      color: GlobalColor.colorTextPrimary,
    );
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          OverflowBox(
              maxWidth: double.infinity,
              alignment: Alignment.center,
              child: background),
          logo,
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Expanded(
                  child: Container(),
                  flex: 4,
                ),
                ScaleTransition(
                  scale: animation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 42, vertical: 16),
                    child: LinearProgressIndicator(
                      value: data.progress,
                      color: GlobalColor.colorAccent,
                      backgroundColor: GlobalColor.colorPrimary,
                      semanticsLabel: 'Linear progress indicator',
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: animation,
                  child: Text(
                    data.title,
                    style: const TextStyle(
                        color: GlobalColor.colorPrimary, fontSize: 14),
                  ),
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                FadeTransition(
                  opacity: animation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "@NTK CORP",
                        style: cortTextStyle,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        '-',
                        style: cortTextStyle,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "نسخه ی ${GlobalData.appVersion}",
                        style: cortTextStyle,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 23,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  ColorSwatch s = Colors.blueAccent;
}
