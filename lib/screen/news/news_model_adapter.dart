import 'dart:io';

import 'package:base/src/index.dart';

import 'package:flutter/material.dart';

import 'package:ntk_flutter_estate/global_data.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsModelAdapter extends StatefulWidget {
  const NewsModelAdapter({
    required this.model,
    Key? key,
  }) : super(key: key);
  final NewsContentModel model;

  @override
  State<NewsModelAdapter> createState() => _NewsModelAdapterState();
}

class _NewsModelAdapterState extends State<NewsModelAdapter> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () async => _launchURL(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.model.linkMainImageIdSrc != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    fit: BoxFit.contain,
                    width: 300,
                    widget.model.linkMainImageIdSrc!,
                  ),
                ),
              Text(
                widget.model.title!,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 15, color: GlobalColor.colorTextPrimary),
              ),
              Text(
                widget.model.description!,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 15, color: GlobalColor.colorTextPrimary),
              ),
              Row(
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
                  ),  const Icon(
                    Icons.remove_red_eye,
                    size: 15,
                    color: GlobalColor.colorAccent,
                  ),
                ],
              )
            ],
          ),
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
