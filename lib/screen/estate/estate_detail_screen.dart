import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/widget/contract_widget.dart';
import 'package:ntk_flutter_estate/screen/widget/dash_separator.dart';
import 'package:flutter_html/flutter_html.dart';
import '../widget/estate_property_details_widget.dart';
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
          SliverToBoxAdapter(
            child: Card(
                child: Column(
              children: [
                //estate id
                Row(
                  children: [
                    Text(
                      "${GlobalString.estateId} : ${widget.model.caseCode}",
                      style: const TextStyle(
                          color: GlobalColor.colorTextPrimary, fontSize: 13),
                    ),
                    const Spacer(),
                    const Text(
                      "120 rooz ghabl",
                      style: TextStyle(
                          color: GlobalColor.colorTextPrimary, fontSize: 13),
                    ),
                  ],
                ),
                dotSpace(),
                //prices
                Column(
                  children: ContractWidget().getPriceWidget(widget.model),
                ),
                dotSpace(),
                //description
                Html(
                  data: widget.model.description,
                ),
                dotSpace(),
                EstatePropertyDetailWidget.forView(
                    widget.model.propertyDetailGroups ?? [],
                    widget.model.propertyDetailValues ?? [])
              ],
            )),
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
      widget.model.linkMainImageIdSrc ?? "",
      ...?widget.model.linkExtraImageIdsSrc
    ];
    return ImageSilder(
      images: urls,
    );
  }

  dotSpace() {
    return const DashSeparator(
      color: GlobalColor.colorPrimary,
      height: 1,
    );
  }
}
