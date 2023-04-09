import 'package:base/src/models/entity/news/news_content_model.dart';
import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/list_with_filter.dart';
import 'package:ntk_flutter_estate/screen/news/news_model_adapter.dart';

import 'estate_vertical_adapter.dart';

class EstateListScreen extends BaseListWithFilterScreen<EstatePropertyModel> {
  EstateListScreen({Key? key})
      : super(
            key: key,
            title: GlobalString.estate,
            controller: EstateListController(
              adapterCreatorFunction: (context, m, index) =>
                  EstatePropertyVerticalAdapter(model: m),
            ));
}
