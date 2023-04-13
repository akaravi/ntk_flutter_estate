import 'package:base/src/index.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';

import '../screen/main_screen.dart';

class MainScreenController extends BaseMainController {
  @override
  void startScreen(BuildContext context) {
    Future.microtask(() => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen())));
  }

  Future<UserModel> getUserInfo() async {
    UserModel user = new UserModel();
    int userId = await LoginCache().getUserID();
    user.userId =
        userId > 0 ? ("${GlobalString.userID} $userId") : GlobalString.noUserID;
    user.isLogin = userId > 0;
    user.name = userId > 0 ? GlobalString.guest : GlobalString.mobile;
    user.allowDirectShareApp = false; //todo
    return user;
  }
}
