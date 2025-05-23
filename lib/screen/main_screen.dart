import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/main_controller.dart';
import 'package:ntk_flutter_estate/controller/new_customer_order_controller.dart';
import 'package:ntk_flutter_estate/controller/new_estate_controller.dart';
import 'package:ntk_flutter_estate/controller/estate_search_controller.dart';
import 'package:ntk_flutter_estate/dialog/need_auth_dialog.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/article/article_list_screen.dart';
import 'package:ntk_flutter_estate/screen/company/comany_list_screen.dart';
import 'package:ntk_flutter_estate/screen/company/project_list_screen.dart';
import 'package:ntk_flutter_estate/screen/estate/estate_list_screen.dart';
import 'package:ntk_flutter_estate/screen/estate/estate_search.dart';
import 'package:ntk_flutter_estate/screen/landused/landused_screen.dart';
import 'package:ntk_flutter_estate/screen/news/news_list_screen.dart';
import 'package:ntk_flutter_estate/widget/app_drawer.dart';
import 'package:ntk_flutter_estate/widget/main_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Screen();
  }
}

class _Screen extends StatefulWidget {
  @override
  State<_Screen> createState() => _ScreenState();
}

class _ScreenState extends State<_Screen> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController? animationController;
  List animation = [];
  OverlayEntry? overlayEntry;
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    for (int i = 2; i > 0; i--) {
      animation.add(Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: animationController!,
          curve: Interval(0.2 * i, 1.0, curve: Curves.ease))));
    }
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(),
      // drawerEdgeDragWidth:50,
      appBar: AppBar(
        backgroundColor: GlobalColor.colorBackground,
        elevation: 0,
        leading: Container(),
        //toolbar
        flexibleSpace: Padding(
          padding: EdgeInsets.only(
              top: statusBarHeight + 8, left: 4, bottom: 8, right: 4),
          child: Row(
            children: [
              //button menu
              TextButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(17),
                    backgroundColor:
                        MaterialStateProperty.all(GlobalColor.colorAccent),
                    shape: MaterialStateProperty.all(const CircleBorder())),
                onPressed: () {
                  if (scaffoldKey.currentState!.isDrawerOpen) {
                    scaffoldKey.currentState!.closeDrawer();
                    //close drawer, if drawer is open
                  } else {
                    scaffoldKey.currentState!.openDrawer();
                    //open drawer, if drawer is closed
                  }
                },
                child: const Icon(
                  Icons.menu,
                  color: GlobalColor.colorPrimary,
                  size: 28,
                ),
              ),

              Expanded(
                child: Card(
                    elevation: 17,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8),
                        child: Container(
                          height: 40,
                          child: TextField(
                            controller: _searchController,
                            textInputAction: TextInputAction.search,
                            maxLines: 1,
                            style: const TextStyle(fontSize: 17),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              prefixIcon: InkWell(
                                  child: const Icon(Icons.search,
                                      color: GlobalColor.colorPrimary),
                                  onTap: () {
                                    MainScreenController.searchWithText(
                                        context, _searchController.text);
                                  }),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.all(4),
                              hintText: GlobalString.searchDotDotDot,
                            ),
                          ),
                        ))),
              )
            ],
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          color: GlobalColor.colorSemiBackground,
        ),
        FutureBuilder<MainContentModel>(
            future: MainScreenController().getMainData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Widget> mainData =
                    MainData(context, snapshot.data ?? MainContentModel());
                return ListView(
                  children: mainData,
                );
              }
              return ShimmerOnMain();
            }),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child:
              //add new
              FutureBuilder<UserModel>(
                  future: MainScreenController().getUserInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12),
                          child: Row(children: [
                            Expanded(
                              child: TextButton(
                                key: globalKey,
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0)),
                                    elevation: 17,
                                    backgroundColor: GlobalColor.colorAccent),
                                onPressed:
                                (snapshot.data?.isLogin ?? false)
                                  ? () => _showOverLay()
                                    : () => NeedAuthorization().show(context),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(GlobalString.addDotDotDot,
                                        style: TextStyle(
                                            color: GlobalColor.colorPrimary,
                                            fontSize: 16)),
                                    SizedBox(width: 50),
                                    Icon(
                                      Icons.add,
                                      color: GlobalColor.colorPrimary,
                                      size: 28,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(17),
                                  backgroundColor: MaterialStateProperty.all(
                                      GlobalColor.colorAccent),
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder())),
                              onPressed: () => EstateSearchController.start(context),
                              child: const Icon(
                                Icons.search,
                                color: GlobalColor.colorPrimary,
                                size: 28,
                              ),
                            ),
                          ]));
                    }
                    return const SizedBox(
                      width: 100,
                      height: 5,
                      child: LinearProgressIndicator(
                          backgroundColor: GlobalColor.colorPrimary,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              GlobalColor.colorAccent)),
                    );
                  }),
        )
      ]),
    );
  }

  List<Widget> MainData(
      BuildContext context, MainContentModel mainContentModel) {
    MainScreenSize mainSize = MainScreenSize();
    return [
      //news section
      SizedBox(
          width: mainSize.newsListWidth,
          height: mainSize.newsListHeight,
          child: NewsListScreen.listOnMainScreen(items: mainContentModel.news)),
      // landUsedProperty section
      Container(
        width: mainSize.landUseListWidth,
        child: Card(
            color: GlobalColor.colorBackground,
            elevation: 18,
            child: rowWidget(
              itemsScreen: SizedBox(
                height: mainSize.landUseListHeight,
                child: LandUsedListScreen.listOnMainScreen(
                    items: mainContentModel.landUseList),
              ),
              title: GlobalString.landUsedList,
              seeAll: () => EstateLandUsedListController().newPage(
                  context: context, newWidget: (context) => LandUsedListScreen.gridView()),
            )),
      ),
      //     //row sections
      //     //todo
      //     //row estateList 1

      if (mainContentModel.estateList1.isNotEmpty) ...[
        rowWidget(
            itemsScreen: SizedBox(
              width: mainSize.estateListWidth,
              height: mainSize.estateListHeight,
              child: EstateListScreen.listOnMainScreen(
                  items: mainContentModel.estateList1),
            ),
            title: GlobalString.newList,
            seeAll: () => EstateListController().newPage(
                context: context,
                newWidget: (context) => EstateListScreen.withFilterScreen(
                  filter: mainContentModel.filterEstateList1,
                )))
      ],
      //     //row estateList 2
      if (mainContentModel.estateList2.isNotEmpty) ...[
        Material(
            color: Colors.transparent,
            clipBehavior: Clip.none,
            elevation: 60,
            child: SizedBox(
              width: GlobalData.screenWidth,
              height: 20,
            )),
        rowWidget(
            itemsScreen: SizedBox(
              width: mainSize.estateListWidth,
              height: mainSize.estateListHeight,
              child: EstateListScreen.listOnMainScreen(
                  items: mainContentModel.estateList2),
            ),
            title: GlobalString.suggestedEstate,
            seeAll: () => EstateListController().newPage(
                context: context,
                newWidget: (context) =>  EstateListScreen.withFilterScreen(
                  filter: mainContentModel.filterEstateList2,
                )))
      ],
      //     //row estateList 3
      if (mainContentModel.estateList3.isNotEmpty) ...[
        Material(
            color: Colors.transparent,
            clipBehavior: Clip.none,
            elevation: 70,
            child: SizedBox(
              width: GlobalData.screenWidth,
              height: 10,
            )),
        rowWidget(
            itemsScreen: SizedBox(
              width: mainSize.estateListWidth,
              height: mainSize.estateListHeight,
              child: EstateListScreen.listOnMainScreen(
                  items: mainContentModel.estateList3),
            ),
            title: GlobalString.dailyRent,
            seeAll: () => EstateListController().newPage(
                context: context,
                newWidget: (context) =>  EstateListScreen.withFilterScreen(
                  filter: mainContentModel.filterEstateList3,
                )))
      ],
      //     //buttons
      IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                    elevation: 17,
                    backgroundColor: GlobalColor.colorBackground),
                onPressed: () => BaseController().newPage(
                    context: context,
                    newWidget: (context) =>  CompanyListScreen.withFilterScreen()),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(GlobalString.companies,
                        style: TextStyle(
                            color: GlobalColor.colorPrimary, fontSize: 16)),
                    SizedBox(width: 50),
                    Image.asset(
                      "assets/drawable/constructor.png",
                      color: GlobalColor.colorPrimary,
                      width: 34,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                    elevation: 17,
                    backgroundColor: GlobalColor.colorBackground),
                onPressed: () => BaseController().newPage(
                    context: context,
                    newWidget: (context) =>  ProjectListScreen.withFilterScreen()),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(GlobalString.projects,
                        style: TextStyle(
                            color: GlobalColor.colorPrimary, fontSize: 16)),
                    SizedBox(width: 50),
                    Image.asset(
                      "assets/drawable/projects.png",
                      color: GlobalColor.colorPrimary,
                      width: 34,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            )
          ],
        ),
      ),
      //     //articles
      rowWidget(
          itemsScreen: SizedBox(
            width: mainSize.articleListWidth,
            height: mainSize.articleListHeight,
            child: ArticleListScreen.listOnMainScreen(
                items: mainContentModel.articles),
          ),
          title: GlobalString.article,
          seeAll: () => ArticleController().newPage(
              context: context,
              newWidget: (context) =>  ArticleListScreen.withFilterScreen())),
      //spacer because of see search and new... btn
      const SizedBox(
        height: 90,
      )
    ];
  }

  Widget shimmer() {
    return Shimmer.fromColors(
      child: Container(
        width: 200,
        height: 200,
        child: Text("asdasd"),
      ),
      baseColor: GlobalColor.colorSemiBackground,
      highlightColor: GlobalColor.colorAccentDark,
    );
  }

  _showOverLay() async {
    List icons = [
      Icons.add_home,
      Icons.web_rounded,
    ];
    List colors = [
      GlobalColor.colorPrimary,
      GlobalColor.colorPrimary,
    ];
    List txt = [GlobalString.newEstate, GlobalString.newOrder];
    RenderBox? renderBox =
        globalKey.currentContext!.findRenderObject() as RenderBox?;
    Offset offset = renderBox!.localToGlobal(Offset.zero);

    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
        builder: (context) => Stack(children: <Widget>[
              Positioned.fill(
                  child: GestureDetector(
                onTap: () async {
                  await Future.delayed(const Duration(microseconds: 100))
                      .whenComplete(() => animationController!
                          .reverse()
                          .whenComplete(() => overlayEntry!.remove()));
                },
                child: Container(
                  color: Colors.transparent,
                ),
              )),
              Positioned(
                left: offset.dx + renderBox.size.width / 3,
                bottom: renderBox.size.height + 16,
                child: ScaleTransition(
                  scale: animation[0],
                  child: Container(
                    decoration: const BoxDecoration(
                        color: GlobalColor.colorBackground,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: IntrinsicWidth(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < animation.length; i++)
                            ScaleTransition(
                              scale: animation[i],
                              child: TextButton(
                                onPressed: () async {
                                  await Future.delayed(
                                          const Duration(microseconds: 100))
                                      .whenComplete(
                                          () => animationController!.reverse())
                                      .whenComplete(
                                          () => overlayEntry!.remove())
                                      .whenComplete(() => i == 0
                                          ? NewEstateController.start(context)
                                          : NewCustomerOrderController.start(
                                              context));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: GlobalColor.colorAccentDark,
                                          width: 1)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(txt[i]),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        icons[i],
                                        color: colors[i],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]));
    animationController!.addListener(() {
      overlayState.setState(() {});
    });
    animationController!.forward();
    overlayState.insert(overlayEntry!);

    // await Future.delayed(const Duration(seconds: 5))
    //     .whenComplete(() => animationController!.reverse())
    //     .whenComplete(() => overlayEntry!.remove());
  }

  rowWidget(
      {required Widget itemsScreen,
      required String title,
      required void Function() seeAll}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: GlobalColor.colorPrimary, fontSize: 14),
            ),
            Expanded(
              child: Container(),
            ),
            TextButton(
                onPressed: () => seeAll(),
                child: const Text(
                  GlobalString.seeAll,
                  style: TextStyle(
                      color: GlobalColor.extraPriceColor, fontSize: 14),
                ))
          ],
        ),
        itemsScreen
      ],
    );
  }
}
