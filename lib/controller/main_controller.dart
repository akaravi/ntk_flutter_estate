import 'package:base/src/index.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/model/row_model.dart';
import 'package:ntk_flutter_estate/screen/estate/estate_list_screen.dart';
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
    String mobile = await LoginCache().getMobile();
    user.userId =
        userId > 0 ? ("${GlobalString.userID} $userId") : GlobalString.noUserID;
    user.isLogin = userId > 0;
    user.name =
        userId > 0 ? ("${GlobalString.mobile} : $mobile") : GlobalString.guest;
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
    //new
    model.landUseList = await EstatePropertyTypeLandUseService()
        .getAll(FilterModel()..rowPerPage = 100);
    model.filterEstateList1 = FilterModel()
      ..rowPerPage = 20
      ..sortColumn = "id"
      ..currentPageNumber = 1
      // ..sortColumn="CreatedDate"
      ..sortType = EnumSortType.descending;
    model.estateList1 =
        await EstatePropertyService().getAll(model.filterEstateList1);
    //special list
    model.filterEstateList2 = FilterModel()
      ..addFilter(FilterDataModel()
        ..propertyName = "PropertyAds"
        ..propertyAnyName = "ViewLevel"
        ..value = "1,2,3,4,5,6")
      ..addFilter(FilterDataModel()
        ..propertyName = "PropertyAds"
        ..propertyAnyName = "StationLevel"
        ..value = "212");
    model.estateList2 =
        await EstatePropertyService().getAll(model.filterEstateList2);
    model.filterEstateList3 = FilterModel()
      ..addFilter(FilterDataModel()
            ..propertyName = "Contracts"
            ..propertyAnyName = "LinkEstateContractTypeId"
            ..value = "68dc5e3b-7c34-4412-c071-08d972b7fc67")
          .sortType = EnumSortType.descending;
    //daily rent
    model.estateList3 =
        await EstatePropertyService().getAll(model.filterEstateList3);

    model.articles = await ArticleModelService().getAll(FilterModel());
    return model;
  }

  static void searchWithText(BuildContext context, String text) {
    if (text.trim().isEmpty) {
      OverlayEntry entry = OverlayEntry(builder: (context) {
        return Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Card(
                color: GlobalColor.colorPrimary.withOpacity(.5),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(GlobalString.plzInsertTitle,
                      style: TextStyle(color: GlobalColor.colorAccent)),
                ),
              ),
            ));
      });

      //show overlay
      Overlay.of(context).insert(entry);
      //auto remove this overlay after 3 seconds
      Future.delayed(const Duration(seconds: 3))
          .then((value) => entry.remove());
    } else {
      //show estateList
      var filterModel = FilterModel()
        ..addFilter(FilterDataModel()
          ..propertyName = "title"
          ..searchType = EnumFilterDataModelSearchTypes.contains
          ..clauseType = EnumClauseType.or
          ..value = text)
        ..addFilter(FilterDataModel()
          ..propertyName = "title"
          ..searchType = EnumFilterDataModelSearchTypes.contains
          ..clauseType = EnumClauseType.or
          ..value = text);
      Future.microtask(() => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EstateListScreen.withFilterScreen(
                filter: filterModel,
              ))));
    }
  }
}

class MainContentModel {
  late List<NewsContentModel> news;
  late List<EstatePropertyTypeLanduseModel> landUseList;
  late List<EstatePropertyModel> estateList1;
  late List<EstatePropertyModel> estateList2;
  late List<EstatePropertyModel> estateList3;
  late RowModel especialList1;
  late RowModel especialList2;
  late List<ArticleContentModel> articles;

  late FilterModel filterEstateList1;
  late FilterModel filterEstateList2;
  late FilterModel filterEstateList3;
}

class MainScreenSize {
  double newsListWidth = GlobalData.screenWidth + 10;
  double newsListHeight = GlobalData.screenHeight / 3;
  double newsItemWidth = 9 * GlobalData.screenWidth / 10;
  double newsItemHeight = -40 + GlobalData.screenHeight / 3;

  double landUseListWidth = GlobalData.screenWidth + 10;
  double landUseListHeight = GlobalData.screenWidth / 5;
  double landUseItemWidth = GlobalData.screenWidth * ((1 / 8));
  double landUseItemHeight = GlobalData.screenWidth * ((1 / 8));
  double specialListWidth = GlobalData.screenWidth;

  double specialUseListHeight = 20 + GlobalData.screenWidth / 5;
  double specialItemWidth = GlobalData.screenWidth / 3;
  double specialItemHeight = GlobalData.screenWidth / 5;

  double estateListWidth = GlobalData.screenWidth;
  double estateListHeight = 3 * GlobalData.screenHeight / 7;
  double articleListWidth = GlobalData.screenWidth - 40;
  double articleListHeight = 20 + GlobalData.screenWidth / 8;
}
