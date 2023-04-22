import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/screen/estate/estate_list_screen.dart';
import 'landused/landused_screen.dart';

class TestScroll extends StatefulWidget {
  const TestScroll({Key? key}) : super(key: key);

  @override
  State<TestScroll> createState() => _TestScrollState();
}

class _TestScrollState extends State<TestScroll> {
  @override
  Widget build(BuildContext context) {
    GlobalData.screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder<List<EstatePropertyModel>>(
        future: EstatePropertyService().getAll(FilterModel()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                sd(snapshot.data ?? []),
                Expanded(child: sd(snapshot.data ?? []))
              ],
            );
          }
          return Container();
        });
  }

  sd(List<EstatePropertyModel> landUseList) {
    return rowWidget(
        itemsScreen: SizedBox( height: 3 * GlobalData.screenWidth / 7,
            child: EstateListScreen.listOnMainScreen(items:  landUseList)),
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
