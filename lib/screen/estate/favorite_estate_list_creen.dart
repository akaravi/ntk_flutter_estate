import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/landused/list_entity_screen.dart';

import 'estate_adapter.dart';

class FavoriteListScreen extends EntityListScreen<EstatePropertyModel> {
  FavoriteListScreen.withFilterScreen({super.key,FilterModel? filter})
      : super.withFilterScreen(
    title: GlobalString.estate,
    controller: FavoriteEstateListController(filter: filter,
        adapterCreatorFunction: (context, m, index) =>
            EstatePropertyAdapter.verticalType(
              model: m,
            )),
  );


}
