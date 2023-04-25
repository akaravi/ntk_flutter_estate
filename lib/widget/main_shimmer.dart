import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/main_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOnMain extends StatelessWidget {
  MainScreenSize mainSize = MainScreenSize();

  ShimmerOnMain({Key? key}) : super(key: key);
  bool enable = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalColor.colorBackground,
      child: Shimmer.fromColors(
          baseColor: GlobalColor.colorSemiBackground,
          highlightColor: GlobalColor.colorShimmer,
          enabled: enable,
          child: ListView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                //news
                SizedBox(
                  width: mainSize.newsListWidth,
                  height: mainSize.newsListHeight,
                  child: ListView(
                      clipBehavior: Clip.hardEdge,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        _news(),
                        SizedBox(
                          width: 16,
                        ),
                        _news()
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    text(width: 100),
                    Expanded(child: Container()),
                    text(width: 120)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),

                SizedBox(
                  width: mainSize.landUseListWidth,
                  height: mainSize.landUseItemHeight,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      typeUsage(),
                      typeUsage(),
                      typeUsage(),
                      typeUsage(),
                      typeUsage(),
                      typeUsage(),
                      typeUsage(),
                      typeUsage(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: mainSize.specialListWidth,
                  height: mainSize.specialUseListHeight,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      children: [special(), special(), special()]),
                ),
                SizedBox(
                  width: mainSize.specialListWidth,
                  height: mainSize.specialUseListHeight,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      children: [special(), special(), special()]),
                ),
                //estate lists
                SizedBox(
                  width: mainSize.estateListWidth,
                  height: mainSize.estateListHeight,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        estate(),
                        estate(),
                        estate(),
                        estate(),
                      ]),
                )  ,SizedBox(
                  width: mainSize.estateListWidth,
                  height: mainSize.estateListHeight,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        estate(),
                        estate(),
                        estate(),
                        estate(),
                      ]),
                )  ,SizedBox(
                  width: mainSize.estateListWidth,
                  height: mainSize.estateListHeight,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        estate(),
                        estate(),
                        estate(),
                        estate(),
                      ]),
                )
              ])),
    );
  }

  _news() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      width: mainSize.newsItemWidth,
      height: mainSize.newsItemHeight,
    );
  }

  typeUsage() {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      width: mainSize.landUseItemWidth,
      height: mainSize.landUseItemHeight,
    );
  }

  estate() {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      width: mainSize.estateListWidth / 3,
      height: mainSize.estateListHeight - 20,
    );
  }

  text({required double width}) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      width: width,
      height: 10,
      color: Colors.white,
    );
  }

  special() {
    return Container(
        width: mainSize.specialItemWidth,
        margin: EdgeInsets.all(6),
        height: mainSize.specialItemHeight,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16))));
  }
}
