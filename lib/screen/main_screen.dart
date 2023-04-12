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
     double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
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
          padding:  EdgeInsets.only(top:statusBarHeight+8,left: 8,bottom: 8,right: 8),
          child: Row(
            children: [
              //button menu
              Card(
                elevation: 17,color: GlobalColor.colorAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45.0),
                ),
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent, // button color
                    child: Ink(
                        decoration: const ShapeDecoration(
                            shape: CircleBorder(), color: GlobalColor.colorAccent),
                        child: IconButton(
                          icon: const Icon(
                            Icons.menu,
                            size: 24,
                            color: GlobalColor.colorPrimary,
                          ),
                          onPressed: () {
                            if (scaffoldKey.currentState!.isDrawerOpen) {
                              scaffoldKey.currentState!.closeDrawer();
                              //close drawer, if drawer is open
                            } else {
                              scaffoldKey.currentState!.openDrawer();
                              //open drawer, if drawer is closed
                            }
                          },
                        ),
                      ),
                  ),
                ),
              ),
              // Ink(
              //   decoration: const ShapeDecoration(
              //       shape: CircleBorder(), color: GlobalColor.colorAccent),
              //   child: IconButton(
              //     icon: const Icon(
              //       Icons.menu,
              //       size: 24,
              //       color: GlobalColor.colorPrimary,
              //     ),
              //     onPressed: () {
              //       if (scaffoldKey.currentState!.isDrawerOpen) {
              //         scaffoldKey.currentState!.closeDrawer();
              //         //close drawer, if drawer is open
              //       } else {
              //         scaffoldKey.currentState!.openDrawer();
              //         //open drawer, if drawer is closed
              //       }
              //     },
              //   ),
              // ),
              SizedBox(width: 10,),
              Expanded(
                child: Card(elevation: 17,  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search,color: GlobalColor.colorPrimary,),
                          Expanded(
                            child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: GlobalColor.colorPrimary),
                  cursorColor: GlobalColor.colorPrimary,
                  decoration: const InputDecoration(
                            hintText: GlobalString.searchDotDotDot,
                            hintStyle: TextStyle(color: GlobalColor.colorPrimary),
                            border: InputBorder.none,
                  ),
                ),
                          ),
                        ],
                      ),
                    )),
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
