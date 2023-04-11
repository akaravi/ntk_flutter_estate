import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
              return detail(errorException?.item);
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('محددا تلاش کنید'),
              );
            }
            return Container();
          }),
    );
  }

  Widget detail(EstatePropertyModel? model) {
    return header();
    // return CustomScrollView(
    //   slivers: <Widget>[
    //     //2
    //     SliverAppBar(
    //       expandedHeight: 250.0,
    //       floating: false,
    //       pinned: true,
    //       flexibleSpace: FlexibleSpaceBar(
    //           title: Text(model?.title ?? "", textScaleFactor: 1),
    //           background: header(),
    //       ),
    //     ),
    //     //3
    //     SliverList(
    //       delegate: SliverChildBuilderDelegate(
    //             (_, int index) {
    //           return ListTile(
    //             leading: Container(
    //                 padding: EdgeInsets.all(8),
    //                 width: 100,
    //                 child: Placeholder()),
    //             title: Text('Place ${index + 1}', textScaleFactor: 2),
    //           );
    //         },
    //         childCount: 20,
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget header() {
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
          urlTemplate:
          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'javad',
        ),
        MarkerLayer(markers: [   Marker(
          point: LatLng(30, 40),
          width: 80,
          height: 80,
          builder: (context) => FlutterLogo(),
        )]),
      ],
    );
    // return Stack(children: [Visibility(child: Text(), replacement:,)],);
  }
}
