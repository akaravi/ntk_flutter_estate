import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:ntk_flutter_estate/global_data.dart';

class SubLoadingScreen extends StatelessWidget {
  const SubLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(margin: const EdgeInsets.only(bottom: 25),
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
}
