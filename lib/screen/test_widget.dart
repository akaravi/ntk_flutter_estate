import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widget/image_slider.dart';

class TestWidget extends StatelessWidget {
  static const String route = '/';

  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Expanded(child: mapWidget()),
            imageSlider(),
          ],
        ),
      ),
    );
  }

  mapWidget() {
    return FlutterMap(
      options: MapOptions(
        maxZoom: 12,
        initialCenter: LatLng(51.5, -0.09),
        initialZoom: 12,
        minZoom: 12,
      ),
      // nonRotatedChildren: [
      //   AttributionWidget.defaultWidget(
      //     source: 'OpenStreetMap contributors',
      //     onSourceTapped: () {},
      //   ),
      // ],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'javad',
        ),
        MarkerLayer(markers: [
          Marker(
            width: 80,
            height: 80,
            point: LatLng(48.8566, 2.3522),
            child: const FlutterLogo(
              textColor: Colors.purple,
              key: ObjectKey(Colors.purple),
            ),
          ),
        ]),
      ],
    );
  }

  imageSlider() {
    List<String> images = [
      "https://images.freeimages.com/images/large-previews/cf7/sunset-in-paris-1447018.jpg",
      "https://images.freeimages.com/images/large-previews/ddf/tour-d-eiffel-1447025.jpg",
      "https://images.freeimages.com/images/previews/321/sunflower-in-bulgaria-1641774.jpg"
    ];
    return ImageSilder(images: images);
  }
}
