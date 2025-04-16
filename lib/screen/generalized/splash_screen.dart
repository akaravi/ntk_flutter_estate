import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:ntk_cms_flutter_base/src/controller/base/splash_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_error_screen.dart';
import 'package:ntk_flutter_estate/screen/main_screen.dart';
import 'package:ntk_flutter_estate/screen/news/news_list_screen.dart';

import '../auth/auth_sms_screen.dart';
import 'intro_screen.dart';
import 'package:ntk_cms_flutter_base/src/controller/base/base_controller.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //todo: for view full bug
    bool viewStackTrace=false;
    return StreamBuilder<SplashProgress>(
        stream: SplashController().initApp(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //get progress send
            var splashProgress = snapshot.data ?? SplashProgress.ifNull();
            //if progress is complete go to next Page
            if (splashProgress.progress == 1) {
              SplashController().nextPage(context,
                  intro: (context) => IntroScreen(),
                  login: (context) => AuthSmsScreen(),
                  main: (context) => MainScreen());

            } else {
              return _Splash(splashProgress);
            }
          } else if (snapshot.hasError) {
            if(viewStackTrace)
            {
              return Scaffold(
                body: SubErrorScreen(
                  title: snapshot.error.toString()+" stackTrace:"+snapshot.stackTrace.toString(),
                  tryAgainMethod: () =>
                      SplashController().restart(context, (C) => SplashScreen()),
                ),
              );
            }else {
              return Scaffold(
                body: SubErrorScreen(
                  title: snapshot.error.toString() ,
                  tryAgainMethod: () =>
                      SplashController().restart(
                          context, (C) => SplashScreen()),
                ),
              );
            }
          }
          return Container();
        });
  }
}

class _Splash extends StatefulWidget {
  SplashProgress data;

  _Splash(this.data, {Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState(SplashController());
}

class _SplashState extends State<_Splash> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  SplashController wdigetController;

  _SplashState(this.wdigetController);

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
    if (GlobalData.screenWidth == -1) {
      GlobalData.screenWidth = MediaQuery.of(context).size.width;
      GlobalData.screenHeight = MediaQuery.of(context).size.height;
    }
    return splash(widget.data);
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
