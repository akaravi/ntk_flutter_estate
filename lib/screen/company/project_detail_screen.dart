import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/company/project_list_screen.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';
import 'package:ntk_flutter_estate/widget/dash_separator.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ntk_flutter_estate/widget/image_slider.dart';

class ProjectDetailScreen extends StatelessWidget {
  ProjectDetailController modelController;

  ProjectDetailScreen({Key? key, required String id})
      : modelController = ProjectDetailController(id: id),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body
      body: StreamBuilder<ErrorException<EstatePropertyProjectModel>>(
          stream: modelController.loadEntity(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //get progress send
              var errorException = snapshot.data;
              //if progress is complete go to next Page
              return _Detail(
                  errorException?.item ?? EstatePropertyProjectModel());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('محددا تلاش کنید'),
              );
            }
            return SubLoadingScreen();
          }),
    );
  }
}

class _Detail extends StatefulWidget {
  EstatePropertyProjectModel model;
  bool sliderVisibillity = true;

  _Detail(this.model, {Key? key}) : super(key: key);

  @override
  State<_Detail> createState() => _DetailState();
}

class _DetailState extends State<_Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.model.title ?? "")),
      body: CustomScrollView(
        slivers: <Widget>[
          //2
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 250.0,
            floating: true,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              background: header(),
            ),
          ),
          //3
          SliverToBoxAdapter(
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //description
                  if (widget.model.description != null &&
                      widget.model.description?.toLowerCase() != "null") ...[
                    Html(
                      data: widget.model.description,
                    ),
                    dotSpace(),
                  ],
                  //body
                  if (widget.model.body != null &&
                      widget.model.body?.toLowerCase() != "null")
                    Html(
                      data: widget.model.body,
                    ),


                ],
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return SizedBox(
      height: 250,
      child: slider(),
    );
  }

  slider() {
    List<String> urls = [
      widget.model.linkMainImageIdSrc ?? "",
      ...?widget.model.linkExtraImageIdsSrc
    ];
    return ImageSilder(
      images: urls,
    );
  }

  dotSpace() {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8),
      child: DashSeparator(
        color: GlobalColor.colorPrimary,
        height: 1,
      ),
    );
  }
}
