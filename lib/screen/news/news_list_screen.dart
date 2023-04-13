import 'package:base/src/models/entity/news/news_content_model.dart';
import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/list_entity_screen.dart';
import 'package:ntk_flutter_estate/screen/news/news_model_adapter.dart';

class NewsListScreen extends EntityListScreen<NewsContentModel> {
  NewsListScreen.withFilterScreen({super.key})
      : super.withFilterScreen(
          title: GlobalString.news,
          controller: NewsListController(
              adapterCreatorFunction: (context, m, index) =>
                  NewsModelAdapter.verticalType(
                    model: m,
                  )),
        );

  NewsListScreen.listOnMainScreen({super.key, required List<NewsContentModel> items})
      : super.listOnly(
          listItems: items,
          controller: NewsListController(
              adapterCreatorFunction: (context, m, index) =>
                  NewsModelAdapter.horizontalForMain(
                    model: m,
                  )),
        );
}
