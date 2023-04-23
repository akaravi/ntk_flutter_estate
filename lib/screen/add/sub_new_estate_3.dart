import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../controller/new_estate_controller.dart';

class SubNewEstate3 extends SubNewEstateBase {
  SubNewEstate3({Key? key, required NewEstateController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewEstate3> createState() => _Container1State();
}

class _Container1State extends State<SubNewEstate3> {
  @override
  void initState() {
    widget.controller.codeTextWidget.text =
        (Random().nextInt(90000000) + 10000000).toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.screenWidth == -1) {
      widget.screenWidth = MediaQuery.of(context).size.width;
    }
    return Column(
      children: [
        widget.card(children: [
          //code estate
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: widget.textFieldBoxWidget(
                title: GlobalString.estateCode,
                keyboardType: TextInputType.text,
                textController: widget.controller.codeTextWidget),
          )
        ]),
        widget.card(children: [
          //title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: widget.textFieldBoxWidget(
                title: GlobalString.title,
                keyboardType: TextInputType.text,
                textController: widget.controller.titleTextWidget),
          )
        ]),
        //desc
        widget.card(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: widget.textFieldBoxWidget(
                title: GlobalString.desc,
                keyboardType: TextInputType.text,
                textController: widget.controller.descTextWidget),
          )
        ]),

        widget.card(children: [
          //location
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: widget.textFieldBoxWidget(
                readOnly: true,onClick: () {
                  
                },
                title: GlobalString.location,
                keyboardType: TextInputType.text,
                textController: widget.controller.descTextWidget),
          ),
          //address
          widget.textFieldBoxWidget(
              title: GlobalString.address,
              keyboardType: TextInputType.text,
              textController: widget.controller.addressTextWidget),
          //map
          widget.box(
            fitContainer: true,
            title: GlobalString.estimateLoc,
            widget: SizedBox(
              width: double.infinity,
              height: 350,
              child: FlutterMap(
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
                    MarkerLayer(markers: [
                      Marker(
                        point: LatLng(30, 40),
                        width: 80,
                        height: 80,
                        builder: (context) => FlutterLogo(),
                      )
                    ]),
                  ]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 35),
            child: TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 10,
                  backgroundColor: GlobalColor.colorAccent),
              onPressed: () {
                //todo
              },
              child: Text(GlobalString.selectLoc,
                  style: const TextStyle(
                      color: GlobalColor.colorTextOnPrimary, fontSize: 16)),
            ),
          )
        ])
      ],
    );
  }
}
