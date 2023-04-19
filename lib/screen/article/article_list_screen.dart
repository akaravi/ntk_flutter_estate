import 'package:base/src/models/entity/article/article_content_model.dart';
import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/landused/list_entity_screen.dart';
import 'package:ntk_flutter_estate/screen/article/article_model_adapter.dart';

class ArticleListScreen extends EntityListScreen<ArticleContentModel> {
  ArticleListScreen.withFilterScreen({super.key})
      : super.withFilterScreen(
          title: GlobalString.article,
          controller: ArticleListController(
              adapterCreatorFunction: (context, m, index) =>
                  ArticleModelAdapter.verticalType(
                    model: m,
                  )),
        );

  ArticleListScreen.listOnMainScreen({super.key, required List<ArticleContentModel> items})
      : super.listOnly(
          listItems: items,
          controller: ArticleListController(
              adapterCreatorFunction: (context, m, index) =>
                  ArticleModelAdapter.horizontalForMain(
                    model: m,
                  )),
        );
}
