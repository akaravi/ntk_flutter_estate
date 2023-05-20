import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/estate_list_with_order_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/landused/list_entity_screen.dart';

import 'estate_adapter.dart';

class EstateListScreen extends EntityListScreen<EstatePropertyModel> {
  EstateListScreen.withFilterScreen({super.key, FilterModel? filter})
      : super.withFilterScreen(
          title: GlobalString.estate,
          controller: EstateListController(
              filter: filter,
              adapterCreatorFunction: (context, m, index) =>
                  EstatePropertyAdapter.verticalType(
                    model: m,
                  )),
        );

  EstateListScreen.listOnMainScreen(
      {super.key, required List<EstatePropertyModel> items})
      : super.listOnly(
          listItems: items,
          controller: EstateListController(
              adapterCreatorFunction: (context, m, index) =>
                  EstatePropertyAdapter.horizontalType(
                    model: m,
                  )),
        );

  EstateListScreen.withOrder({super.key, required String id})
      : super.withFilterScreen(
    title: GlobalString.estate,
    controller: EstateWithOrderController(id: id,

        adapterCreatorFunction: (context, m, index) =>
            EstatePropertyAdapter.verticalType(
              model: m,
            )),
  );
}
