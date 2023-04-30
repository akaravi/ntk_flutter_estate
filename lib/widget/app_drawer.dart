import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:ntk_flutter_estate/dialog/need_auth_dialog.dart';
import 'package:ntk_flutter_estate/screen/auth/auth_sms_screen.dart';
import 'package:ntk_flutter_estate/screen/customer_order/customer_order_list_screen.dart';
import 'package:ntk_flutter_estate/screen/estate/favorite_estate_list_creen.dart';
import 'package:ntk_flutter_estate/screen/estate/my_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/estate/test_wdiget.dart';
import 'package:ntk_flutter_estate/screen/generalized/intro_screen.dart';
import 'package:ntk_flutter_estate/screen/news/news_list_screen.dart';

import '../controller/main_controller.dart';
import '../controller/profile_controller.dart';
import '../global_data.dart';

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
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            iconHeader(),
                            Text(
                              userModel.name,
                              style: const TextStyle(
                                  color: GlobalColor.colorAccent, fontSize: 14),
                            ),
                            Text(
                              userModel.userId,
                              style: const TextStyle(
                                  color: GlobalColor.colorAccent, fontSize: 14),
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                  backgroundColor: GlobalColor.colorAccent,
                                ),
                                onPressed: userModel.isLogin
                                    ? () => ProfileController.page(context)
                                    : () {
                                        //close dialog
                                        BaseController().close(context);
                                        BaseController().replacePage(
                                            context: context,
                                            newScreen: AuthSmsScreen());
                                      },
                                child: Container(
                                  padding: EdgeInsets.only(left: 18, right: 18),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          (userModel.isLogin)
                                              ? GlobalString.profile
                                              : GlobalString.login,
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
                                ))
                          ],
                        ))
                  ]..addAll(_DrawerItem.drawerItems(
                          userModel.isLogin, userModel.allowDirectShareApp)
                      .map((element) => ListTile(
                            onTap: element.onClick != null
                                ? () => element.onClick!(context)
                                : () => BaseController().newPage(
                                    context: context,
                                    newScreen: (element.page!())),
                            title: Text(
                              element.name,
                              style: const TextStyle(
                                  color: GlobalColor.colorPrimary),
                            ),
                            leading: Image.asset(
                              element.icon,
                              color: GlobalColor.colorPrimary,
                              width: 40,
                              height: 40,
                            ),
                          ))
                      .toList()),
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
  Widget Function()? page;
  void Function(BuildContext c)? onClick;

  _DrawerItem({required this.name, required this.icon, required this.page});

  _DrawerItem.onTap(
      {required this.name, required this.icon, required this.onClick});

  static List<_DrawerItem> drawerItems(bool isLogin, bool allowDirectShareApp) {
    List<_DrawerItem> items = [];
    items.add(isLogin
        ? _DrawerItem(
            name: GlobalString.myEstate,
            icon: "assets/drawable/my_estate.png",
            page: () => MyEstateListScreen.withFilterScreen())
        : _DrawerItem.onTap(
            name: GlobalString.myEstate,
            icon: "assets/drawable/my_estate.png",
            onClick: (c) => NeedAuthorization().show(c),
          ));
    items.add(isLogin
        ? _DrawerItem(
            name: GlobalString.myRequests,
            icon: "assets/drawable/order2.png",
            page: () => CustomerOrderListScreen.withFilterScreen())
        : _DrawerItem.onTap(
            name: GlobalString.myRequests,
            icon: "assets/drawable/order2.png",
            onClick: (c) => NeedAuthorization().show(c),
          ));
    items.add(_DrawerItem(
        name: GlobalString.favoriteList,
        icon: "assets/drawable/favorites_folder.png",
        page: () => FavoriteListScreen.withFilterScreen()));
    items.add(_DrawerItem(
        name: GlobalString.news,
        icon: "assets/drawable/news2.png",
        page: () => NewsListScreen.withFilterScreen()));
    items.add(_DrawerItem(
        name: GlobalString.article,
        icon: "assets/drawable/article_place_holder.png",
        page: () => const TestScreen()));
    items.add(_DrawerItem(
        name: GlobalString.ticket,
        icon: "assets/drawable/inbox.png",
        page: () => const TestScreen()));
    items.add(_DrawerItem(
        name: GlobalString.polling,
        icon: "assets/drawable/polling2.png",
        page: () => const TestScreen()));
    items.add(_DrawerItem(
        name: GlobalString.inbox,
        icon: "assets/drawable/notification2.png",
        page: () => const TestScreen()));
    items.add(_DrawerItem(
        name: GlobalString.faq,
        icon: "assets/drawable/faq2.png",
        page: () => const TestScreen()));
    items.add(_DrawerItem(
        name: GlobalString.feedback,
        icon: "assets/drawable/feedback2.png",
        page: () => const TestScreen()));
    items.add(_DrawerItem(
        name: GlobalString.aboutUs,
        icon: "assets/drawable/about_us2.png",
        page: () => const TestScreen()));
    items.add(_DrawerItem(
        name: GlobalString.help,
        icon: "assets/drawable/intro2.png",
        page: () => IntroScreen(asHelpScreen: true)));
    if (allowDirectShareApp) {
      items.add(_DrawerItem(
          name: GlobalString.inviteFriend,
          icon: "assets/drawable/invite2.png",
          page: () => const TestScreen()));
    }
    if (isLogin) {
      items.add(_DrawerItem.onTap(
        name: GlobalString.exit,
        icon: "assets/drawable/exit.png",
        onClick: (c) {
          FlutterExitApp.exitApp();
        },
      ));
    }
    return items;
  }
}
