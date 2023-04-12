import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/screen/estate/my_estate.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import '../controller/main_controller.dart';
import '../controller/profile_controller.dart';
import '../global_data.dart';
import 'package:base/src/index.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        child: FutureBuilder<UserModel>(
            future: MainScreenController().getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var userModel = snapshot.data ?? UserModel();
                return ListView(
                    children: [
                      DrawerHeader(
                          decoration: const BoxDecoration(
                              color: GlobalColor.colorPrimary),
                          child:
                          //user is login in app
                          Column(
                            children: [
                              iconHeader(),
                              Text(
                                userModel.name,
                                style: const TextStyle(
                                    color: GlobalColor.colorAccent,
                                    fontSize: 14),
                              ),
                              Text(userModel.userId),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            32.0)),
                                    backgroundColor: GlobalColor.colorAccent,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Text(
                                            (userModel.isLogin)
                                                ? GlobalString.login
                                                : GlobalString.profile,
                                            style: const TextStyle(
                                                color: GlobalColor.colorPrimary,
                                                fontSize: 16)),
                                        const SizedBox(width: 20),
                                        Icon(
                                          (userModel.isLogin)
                                              ? Icons.check_outlined
                                              : Icons.add,
                                          color: GlobalColor.colorPrimary,
                                          size: 14,
                                        )
                                      ],
                                    ),
                                  ),
                                  onPressed: () =>
                                  userModel.isLogin
                                      ? ProfileController.page(context)
                                      : FlutterExitApp.exitApp())
                            ],
                          ))
                    ]
                      ..addAll(
                          _DrawerItem.drawerItems(
                              userModel.isLogin, userModel.allowDirectShareApp)
                              .map((element) =>
                              ListTile(
                                title: Text(
                                  element.name, style: const TextStyle(
                                    color: GlobalColor.colorPrimary),)
                                ,
                                leading: Image.asset(
                                  element.icon, color: GlobalColor.colorPrimary,
                                  width: 40,
                                  height: 40,),
                              )).toList()),

                    );
                //user is guest
              }
              return Container();
            }));
  }


  Widget iconHeader() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: GlobalColor.colorAccent),
      child: const Icon(
        Icons.person,
        color: GlobalColor.colorPrimary,
        size: 13,
      ),
    );
  }
}

class _DrawerItem {
  String name;
  String icon;
  Widget page;

  _DrawerItem({required this.name, required this.icon, required this.page});

  static List<_DrawerItem> drawerItems(bool isLogin, bool allowDirectShareApp) {
    List<_DrawerItem> items = [];
    items.add(_DrawerItem(
        name: GlobalString.myEstate,
        icon: "assets/drawable/my_estate.png",
        page: const MyEstateScreen()));
    items.add(_DrawerItem(
        name: GlobalString.myRequests,
        icon: "assets/drawable/order2.png",
        page: const MyEstateScreen()));
    items.add(_DrawerItem(
        name: GlobalString.favoriteList,
        icon: "assets/drawable/favorites_folder.png",
        page: const MyEstateScreen()));
    items.add(_DrawerItem(
        name: GlobalString.news,
        icon: "assets/drawable/news2.png",
        page: const MyEstateScreen()));
    items.add(_DrawerItem(
        name: GlobalString.article,
        icon: "assets/drawable/article_place_holder.png",
        page: const MyEstateScreen()));
    items.add(_DrawerItem(
        name: GlobalString.ticket,
        icon: "assets/drawable/inbox.png",
        page: const MyEstateScreen()));
    items.add(_DrawerItem(
        name: GlobalString.polling,
        icon: "assets/drawable/polling2.png",
        page: const MyEstateScreen()));
    items.add(_DrawerItem(
        name: GlobalString.inbox,
        icon: "assets/drawable/notification2.png",
        page: const MyEstateScreen()));
    items.add(_DrawerItem(
        name: GlobalString.faq,
        icon: "assets/drawable/faq2.png",
        page: const MyEstateScreen()));
    items.add(_DrawerItem(
        name: GlobalString.feedback,
        icon: "assets/drawable/feedback2.png",
        page: const MyEstateScreen()));
    items.add(_DrawerItem(
        name: GlobalString.aboutUs,
        icon: "assets/drawable/about_us2.png",
        page: const MyEstateScreen()));
    items.add(_DrawerItem(
        name: GlobalString.help,
        icon: "assets/drawable/intro2.png",
        page: const MyEstateScreen()));
    if (allowDirectShareApp) {
      items.add(_DrawerItem(
          name: GlobalString.inviteFriend,
          icon: "assets/drawable/invite2.png",
          page: const MyEstateScreen()));
    }
    if (isLogin) {
      items.add(_DrawerItem(
          name: GlobalString.exit,
          icon: "assets/drawable/exit.png",
          page: const MyEstateScreen()));
    }
    return items;
  }
}
