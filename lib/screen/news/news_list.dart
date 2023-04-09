import 'package:base/src/models/entity/news/news_content_model.dart';
import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/screen/list_with_filter.dart';

class NewsListScreen extends BaseListWithFilterScreen<NewsContentModel> {
  NewsListScreen({Key? key})
      : super(key: key, title: 'News', controller: NewsListController(adapterCreatorFunction: (context, m, index) => News,));
}
