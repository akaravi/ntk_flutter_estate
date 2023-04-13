import 'package:base/src/index.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/model/row_model.dart';
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

  Future<MainContentModel> getMainData() async {
    MainContentModel model = MainContentModel();
    //get news
    model.news = await NewsListController().service(FilterModel()
      ..rowPerPage = 10
      ..sortColumn = "id"
      ..currentPageNumber = 1);
    return model;
  }
}

class MainContentModel {
  late List<NewsContentModel> news;
  late List<EstatePropertyTypeLanduseModel> estateCategories;
  late List<EstatePropertyModel> estateList1;
  late List<EstatePropertyModel> estateList2;
  late List<EstatePropertyModel> estateList3;
  late RowModel especialList1;
  late RowModel especialList2;
  late List<ArticleContentModel> articles;
}
