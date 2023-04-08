
import 'package:base/src/models/entity/news/news_content_model.dart';
import 'package:flutter/material.dart';
import 'package:base/src/index.dart';


class NewsListScreen extends BaseModelListScreen<NewsContentModel> {
  NewsListScreen({Key? key}) : super(key: key, title: 'News',controller: NewsListController());

}


