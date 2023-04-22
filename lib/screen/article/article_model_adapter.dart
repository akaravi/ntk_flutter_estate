import 'dart:io';

import 'package:base/src/index.dart';

import 'package:flutter/material.dart';

import 'package:ntk_flutter_estate/global_data.dart';
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
    //todo
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
                      width: 250,
                      widget.model.linkMainImageIdSrc!,
                    ),
                  ),
                Text(
                  widget.model.title!,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 15, color: GlobalColor.colorTextPrimary),
                ),
              ]),
        ),
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    final url = 'https://raywenderlich.com/redirect?uri=${widget.model.source}';
    if (Platform.isIOS || await canLaunch(url)) {
      await launch(url);
    } else {
      // Scaffold.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Could\'nt launch the article\'s URL.'),
      //   ),
      // );
    }
  }
}

class _ArticleModelAdapterForMainState
    extends BaseEntityAdapterEstate<ArticleModelAdapter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: GlobalData.screenWidth-80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: InkWell(
          onTap: () async => widget.detailScreen(context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Center(
                  child: Expanded(
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
