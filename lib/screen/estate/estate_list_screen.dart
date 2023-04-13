import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/list_entity_screen.dart';

import 'estate_adapter.dart';

class EstateListScreen extends EntityListScreen<EstatePropertyModel> {
  EstateListScreen.withFilterScreen({super.key})
      : super.withFilterScreen(
          title: GlobalString.estate,
          controller: EstateListController(
              adapterCreatorFunction: (context, m, index) =>
                  EstatePropertyAdapter.verticalType(
                    model: m,
                  )),
        );

}
