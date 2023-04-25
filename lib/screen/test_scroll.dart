import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/main_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/screen/estate/estate_list_screen.dart';
import 'package:ntk_flutter_estate/widget/main_shimmer.dart';
import 'landused/landused_screen.dart';
import 'package:shimmer/shimmer.dart';

class TestScroll extends StatefulWidget {
  const TestScroll({Key? key}) : super(key: key);

  @override
  State<TestScroll> createState() => _TestScrollState();
}

class _TestScrollState extends State<TestScroll> {
  @override
  Widget build(BuildContext context) {
    GlobalData.screenWidth = MediaQuery.of(context).size.width;
    GlobalData.screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 15)),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                shrinkWrap: true,
                children: [
                  Expanded(child: sd(snapshot.data ?? [])),
                  sd(snapshot.data ?? [])
                ],
              );
            }
            return ShimmerOnMain();
          }),
    );
  }


  sd(List<EstatePropertyModel> landUseList) {
    return rowWidget(
        itemsScreen: SizedBox(
            width: GlobalData.screenWidth,
            height: 3 * GlobalData.screenWidth / 6,
            child: EstateListScreen.listOnMainScreen(items: landUseList)),
        title: GlobalString.landUsedList,
        seeAll: () => {});
  }

  rowWidget(
      {required Widget itemsScreen,
      required String title,
      required void Function() seeAll}) {
    return Column(
      children: [
        Row(
          children: [
            Text(title),
            Expanded(
              child: Container(),
            ),
            TextButton(
                onPressed: () => seeAll, child: const Text(GlobalString.seeAll))
          ],
        ),
        itemsScreen
      ],
    );
  }
}
