import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ntk_flutter_estate/screen/add/user_location_on_map_screen.dart';
import 'package:ntk_flutter_estate/widget/location_model_selector_widget.dart';
import '../../controller/new_estate_controller.dart';
import 'package:ntk_cms_flutter_base/src/index.dart';

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
                readOnly: true,
                onClick: () async {
                  CoreLocationModel? model =
                      await LocationModelSelectorDialog().show(context);
                  if (model != null) {
                    widget.controller.locationTextController.text =
                        model.title ?? "";
                    widget.controller.item.linkLocationId = model.id;
                    setState(() {});
                  }
                },
                title: GlobalString.location,
                keyboardType: TextInputType.text,
                textController: widget.controller.locationTextController),
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
                    interactionOptions:InteractionOptions(flags: InteractiveFlag.none ) ,
                    maxZoom: 12,
                    initialCenter: LatLng(
                      widget.controller.item.geolocationlatitude ?? 32.661343,
                      widget.controller.item.geolocationlongitude ?? 51.680374,
                    ),
                    initialZoom: 12,
                    minZoom: 12,
                    ),
                  // nonRotatedChildren: [
                  //   LiveLocationPage.attributionWidgetDefault(
                  //       alignment: Alignment.bottomCenter)
                  // ],
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
                        child: FlutterLogo(),
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
              onPressed: () async {
                bool locSelected =
                    await widget.controller.selectLocation(context);
                if (locSelected) {
                  setState(() {});
                }
              },
              child: const Text(GlobalString.selectLoc,
                  style: TextStyle(
                      color: GlobalColor.colorTextOnPrimary, fontSize: 16)),
            ),
          )
        ])
      ],
    );
  }
}
