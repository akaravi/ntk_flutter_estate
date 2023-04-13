import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/main_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/screen/landused/landused_screen.dart';
import 'package:ntk_flutter_estate/screen/news/news_list_screen.dart';
import 'package:ntk_flutter_estate/widget/app_drawer.dart';

class MainScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  MainScreen({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
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
                          child: const TextField(
                            maxLines: 1,
                            style: TextStyle(fontSize: 17),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Icon(Icons.search,
                                  color: GlobalColor.colorPrimary),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.all(4),
                              hintText: GlobalString.searchDotDotDot,
                            ),
                          ),
                        ))),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: GlobalColor.colorBackground,
          ),
          SingleChildScrollView(
              primary: true,
              scrollDirection: Axis.vertical,
              child: FutureBuilder<MainContentModel>(
                  future: MainScreenController().getMainData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return MainData(context,
                          snapshot.data ?? MainContentModel());
                    return Container();
                  })),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: Row(children: [
                //add new
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0)),
                        elevation: 17,
                        backgroundColor: GlobalColor.colorAccent),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(GlobalString.addDotDotDot,
                            style: TextStyle(
                                color: GlobalColor.colorPrimary, fontSize: 16)),
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
                      backgroundColor:
                      MaterialStateProperty.all(GlobalColor.colorAccent),
                      shape: MaterialStateProperty.all(const CircleBorder())),
                  onPressed: () {},
                  child: const Icon(
                    Icons.search,
                    color: GlobalColor.colorPrimary,
                    size: 28,
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  Widget MainData(BuildContext context, MainContentModel mainContentModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 300,
            width: double.infinity,
            child:
            NewsListScreen.listOnMainScreen(items: mainContentModel.news)),
        Card(
            color: GlobalColor.colorBackground,
            child: rowWidget(
              title: GlobalString.landUsedList,
              seeAll: () =>
                  EstateLandUsedListController().newPage(context: context,
                      newScreen: LandUsedListScreen.withFilterScreen()),)),
        Container(
          height: 400,
          color: Colors.red,
        ),
        Container(
          height: 400,
          color: Colors.deepPurpleAccent,
        ),
        Container(
          height: 400,
          color: Colors.red,
        )
      ],
    );
  }

  rowWidget({required String title, required void Function() seeAll}) {
    return Column(
      children: [
        Row(
          children: [
            Text(title),
            Expanded(
              child: Container(),
            )
            ,
            TextButton(
                onPressed: seeAll, child: const Text(GlobalString.seeAll))
          ],
        )
      ],
    );
  }
}
