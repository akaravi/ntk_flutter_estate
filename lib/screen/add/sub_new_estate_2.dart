import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';

import '../../controller/new_estate_controller.dart';
import '../sub_loading_screen.dart';

class SubNewEstate2 extends SubNewEstateBase {
  SubNewEstate2({Key? key, required NewEstateController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewEstate2> createState() => _Container1State();
}

class _Container1State extends State<SubNewEstate2> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Sub2Data>(
        future: widget.controller.subTowLoad(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: (snapshot.data?.propertydetailGroups ?? [])
                    .map((e) => widget.card(children: [
                          widget.box(
                              title: e.title ?? "",
                              widget: Container(
                                height: 200,
                              ))
                        ]))
                    .toList());
          }
          return SubLoadingScreen();
        });
  }
}
