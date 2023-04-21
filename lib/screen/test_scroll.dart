import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:base/src/index.dart';
import 'landused/landused_screen.dart';

class TestScroll extends StatefulWidget {
  const TestScroll({Key? key}) : super(key: key);

  @override
  State<TestScroll> createState() => _TestScrollState();
}

class _TestScrollState extends State<TestScroll> {
  @override
  Widget build(BuildContext context) {
    GlobalData.screenWidth=MediaQuery.of(context).size.width;
    return FutureBuilder<List<EstatePropertyTypeLanduseModel>>(
        future: EstatePropertyTypeLandUseService().getAll(FilterModel()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [SizedBox(height: 3*GlobalData.screenWidth/7,child: sd(snapshot.data ?? []),),Expanded(child: sd(snapshot.data ?? []))],
            );
          }
          return Container();
        });
  }

  sd(List<EstatePropertyTypeLanduseModel> landUseList) {
    return Card(
        color: GlobalColor.colorBackground,
        child: rowWidget(
            itemsScreen:
                LandUsedListScreen.listOnMainScreen(items: landUseList),
            title: GlobalString.landUsedList,
            seeAll: () => {}));
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
