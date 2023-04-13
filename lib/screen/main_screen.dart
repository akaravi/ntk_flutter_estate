import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/main_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/widget/app_drawer.dart';

class MainScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  MainScreen({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
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
                        child: Container(height: 40,
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
      body: Container(
        color: GlobalColor.colorBackground,
      ),
    );
  }
}
