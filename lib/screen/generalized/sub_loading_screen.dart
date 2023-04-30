import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:ntk_flutter_estate/global_data.dart';

class SubLoadingScreen extends StatelessWidget {
  static bool _show = true;

  const SubLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 25),
            height: MediaQuery.of(context).size.height / 3,
            child: Lottie.asset(
              'assets/lottie/sub_loading.json',
              repeat: false,
            ),
          ),
          const Text(
            GlobalString.loading,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: GlobalColor.colorAccent),
          )
        ],
      )),
    );
  }

  static void showProgress(BuildContext context) {
    _show = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45.withAlpha(12), spreadRadius: 4)
                    ]),
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 32),
                    Text(
                      GlobalString.loading,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ))));
  }

  static void dismiss(BuildContext context) {
    if (_show) {
      Navigator.pop(context);
    }
  }
}
