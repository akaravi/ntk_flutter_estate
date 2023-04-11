import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../widget/image_slider.dart';

class EstateDetailScreen extends StatelessWidget {
  EstateDetailController modelController;

  EstateDetailScreen({Key? key, String? id})
      : modelController = EstateDetailController(id),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body
      body: StreamBuilder<ErrorException<EstatePropertyModel>>(
          stream: modelController.loadEntity(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //get progress send
              var errorException = snapshot.data;
              //if progress is complete go to next Page
              return _Detail(errorException?.item ?? EstatePropertyModel());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('محددا تلاش کنید'),
              );
            }
            return Container();
          }),
    );
  }
//
}

class _Detail extends StatefulWidget {
  EstatePropertyModel model;

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
            expandedHeight: 250.0,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: header(),
            ),
          ),
          //3
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return ListTile(
                  leading: Container(
                      padding: EdgeInsets.all(8),
                      width: 100,
                      child: Placeholder()),
                  title: Text('Place ${index + 1}', textScaleFactor: 2),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Stack(
      children: [Visibility(child: slider(), replacement: map())],
    );
  }

  Widget map() {
    return FlutterMap(
      options: MapOptions(
        maxZoom: 12,
        center: LatLng(51.5, -0.09),
        zoom: 12,
        minZoom: 12,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: () {},
        ),
      ],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'javad',
        ),
        MarkerLayer(markers: [
          Marker(
            point: LatLng(30, 40),
            width: 80,
            height: 80,
            builder: (context) => FlutterLogo(),
          )
        ]),
      ],
    );
  }

  slider() {
    List<String> urls = [
      widget.model.linkExtraImageIds ?? "",
      ...?widget.model.linkExtraImageIdsSrc
    ];
    return ImageSilder(
      images: urls,
    );
  }
}
