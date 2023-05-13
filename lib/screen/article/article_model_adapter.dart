import 'dart:io';

import 'package:base/src/index.dart';

import 'package:flutter/material.dart';

import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/article/article_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleModelAdapter extends BaseEntityAdapter<ArticleContentModel> {
  ArticleModelAdapter._(
      {required super.model, super.key, required super.stateCreator});

  factory ArticleModelAdapter.verticalType(
      {required ArticleContentModel model}) {
    return ArticleModelAdapter._(
        model: model, stateCreator: () => _ArticleModelAdapterState());
  }

  factory ArticleModelAdapter.horizontalForMain(
      {required ArticleContentModel model}) {
    return ArticleModelAdapter._(
        model: model, stateCreator: () => _ArticleModelAdapterForMainState());
  }

  detailScreen(BuildContext context) {
    BaseController().newPage(
        context: context,  newWidget: (context) =>  ArticleDetailScreen(id: model.id ?? 0));
  }
}

class _ArticleModelAdapterState
    extends BaseEntityAdapterEstate<ArticleModelAdapter> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () async => widget.detailScreen(context),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.model.linkMainImageIdSrc != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12)),
                    child: Image.network(
                      fit: BoxFit.fill,
                      width: GlobalData.screenWidth,
                      height: 2 * GlobalData.screenHeight / 7,
                      widget.model.linkMainImageIdSrc!,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.model.title!,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 15, color: GlobalColor.colorTextPrimary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      StarDisplay(
                          ViewCount: widget.model.viewCount,
                          ScoreSumPercent: widget.model.scoreSumPercent,
                          color: GlobalColor.colorAccent),
                      Spacer(
                        flex: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          widget.model.viewCount.toString(),
                          style: const TextStyle(
                              fontSize: 15, color: GlobalColor.colorAccent),
                        ),
                      ),
                      const Icon(
                        Icons.remove_red_eye,
                        size: 15,
                        color: GlobalColor.colorAccent,
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

class _ArticleModelAdapterForMainState
    extends BaseEntityAdapterEstate<ArticleModelAdapter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: GlobalData.screenWidth - 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: InkWell(
          onTap: () async => widget.detailScreen(context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.model.linkMainImageIdSrc != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      fit: BoxFit.cover,
                      width: GlobalData.screenWidth / 8,
                      height: GlobalData.screenWidth / 8,
                      widget.model.linkMainImageIdSrc!,
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      widget.model.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 15, color: GlobalColor.colorTextPrimary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
