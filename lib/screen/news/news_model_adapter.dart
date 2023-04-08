import 'dart:io';

import 'package:base/src/models/entity/news/news_content_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsModelAdapter extends StatefulWidget {
  const NewsModelAdapter({
    required this.model,
    Key? key,
  })  : super(key: key);
  final NewsContentModel model;

  @override
  State<NewsModelAdapter> createState() => _NewsModelAdapterState();
}

class _NewsModelAdapterState extends State<NewsModelAdapter> {
  String get _formattedDurationInMinutes {
    final durationInMinutes =120 / 60;
    return '${durationInMinutes.toStringAsFixed(0)} mins';
  }

  String get _formattedReleaseDate =>
      DateFormat('MMM d yyyy').format(widget.model.createdDate!);

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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.model.title!,
                      style: textTheme.subtitle1,
                    ),
                  ),
                  if (widget.model.linkMainImageIdSrc != null)
                    const SizedBox(
                      width: 16,
                    ),
                  if (widget.model.linkMainImageIdSrc != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.model.linkMainImageIdSrc!,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.model.description!,
                style: textTheme.bodyText2,
              ),
              Text(
                '$_formattedReleaseDate ($_formattedDurationInMinutes)',
                style: textTheme.bodyText2,
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
