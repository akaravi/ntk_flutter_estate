import 'package:flutter/material.dart';
import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/user_location_on_map_screen.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';
import 'package:ntk_flutter_estate/widget/contract_widget.dart';
import 'package:ntk_flutter_estate/widget/dash_separator.dart';
import 'package:flutter_html/flutter_html.dart';
import '/widget/estate_property_details_widget.dart';
import '/widget/image_slider.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:flutter_map/src/layer/marker_layer/marker_layer.dart' as marked;
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
            return SubLoadingScreen();
          }),
    );
  }
//
}

class _Detail extends StatefulWidget {
  EstatePropertyModel model;
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
                      //estate id
                      Row(
                        children: [
                          Text(
                            "${GlobalString.estateId} : ${widget.model
                                .caseCode}",
                            style: const TextStyle(
                                color: GlobalColor.colorTextPrimary,
                                fontSize: 13),
                          ),
                          const Spacer(),
                          Text(
                            GetTimeAgo.parse(
                                widget.model.createdDate ?? DateTime.now()),
                            style: const TextStyle(
                                color: GlobalColor.extraTimeAgoColor,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      dotSpace(),
                      //prices
                      Column(
                        children: ContractWidget().getPriceWidget(
                            widget.model, showAll: true),
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
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          child: Visibility(
              visible: widget.sliderVisibillity,
              child: slider(),
              replacement: map()),
        ),
        if (widget.model.geolocationlongitude != null)
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                    elevation: 17,
                    backgroundColor: GlobalColor.colorPrimary),
                onPressed: () {
                  widget.sliderVisibillity = !widget.sliderVisibillity;
                  setState(() {});
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        widget.sliderVisibillity
                            ? GlobalString.mapLocation
                            : GlobalString.slider,
                        style: const TextStyle(
                            color: GlobalColor.colorTextOnPrimary,
                            fontSize: 16)),
                    SizedBox(width: 50),
                    Icon(widget.sliderVisibillity ? Icons.map : Icons.photo,
                        color: GlobalColor.colorTextOnPrimary),
                  ],
                ),
              ),
            ),
          ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                ((widget.model.linkLocationIdParentTitle ?? "") +
                    (widget.model.linkLocationIdParentTitle == null
                        ? ""
                        : " - ") +
                    (widget.model.linkLocationIdTitle ?? "")),
                style: const TextStyle(
                    color: GlobalColor.colorTextOnPrimary, fontSize: 13)),
          ),
        ),
      ],
    );
  }

  Widget map() {
    return FlutterMap(
      options: MapOptions(
        maxZoom: 12,
        initialCenter: LatLng(widget.model.geolocationlatitude ?? 0,
            widget.model.geolocationlongitude ?? 0),
        initialZoom: 12,
        minZoom: 12,
      ),
      // nonRotatedChildren: [LiveLocationPage.attributionWidgetDefault()],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'ntkCorp',
        ),
        MarkerLayer(markers: [
          marked.Marker(
            point: LatLng(widget.model.geolocationlatitude ?? 0,
                widget.model.geolocationlongitude ?? 0),
            width: 80,
            height: 80,
            child:FlutterLogo(),
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
    return const Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8),
      child: DashSeparator(
        color: GlobalColor.colorPrimary,
        height: 1,
      ),
    );
  }
}
