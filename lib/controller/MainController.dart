import 'package:base/src/index.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import '../screen/main_screen.dart';
class MainScreenController extends BaseMainController

{
  @override
  void startScreen(BuildContext context) {
    Future.microtask(() => Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MainScreen())));
  }

}
