import 'package:base/src/index.dart';
import 'package:flutter/material.dart';

import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/list_entity_screen.dart';

import 'landuse_adapter.dart';

class LandUsedListScreen
    extends EntityListScreen<EstatePropertyTypeLanduseModel> {
  LandUsedListScreen.withFilterScreen({super.key})
      : super.withFilterScreen(
          title: GlobalString.landUsedList,
          controller: EstateLandUsedListController(
              adapterCreatorFunction: (context, m, index) =>
                  LandUsePropertyAdapter.verticalType(
                    model: m,
                  )),
        );
  LandUsedListScreen.listOnMainScreen({super.key,required List<EstatePropertyTypeLanduseModel> items})
      : super.listOnly(listItems: items,
    controller: EstateLandUsedListController(
        adapterCreatorFunction: (context, m, index) =>
            LandUsePropertyAdapter.horizontalType(
              model: m,
            )),
  );
}
