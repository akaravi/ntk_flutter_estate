import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';

import '../../controller/new_estate_controller.dart';

class SubNewEstate1 extends SubNewEstateBase {
  SubNewEstate1({Key? key, required NewEstateController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewEstate1> createState() => _Container1State();
}

class _Container1State extends State<SubNewEstate1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.card(children: [
          widget.box(
              title: GlobalString.estateType,
              widget: Container(
                height: 100,
              )),
        ]),
        if (widget.controller.item.propertyTypeUsage != null)
          widget.card(children: [
            //landused
            widget.box(
                title: GlobalString.estateType,
                widget: Container(
                  height: 100,
                )),

            widget.box(title: GlobalString.areaAsMeter, widget: TextField()),
            //created year
            if (widget.controller.item.propertyTypeLanduse != null &&
                (widget.controller.item.propertyTypeLanduse?.titleCreatedYaer ??
                        "")
                    .isNotEmpty &&
                (widget.controller.item.propertyTypeLanduse?.titleCreatedYaer ??
                        "") !=
                    ("---"))
              widget.box(
                  title: widget.controller.item.propertyTypeLanduse
                          ?.titleCreatedYaer ??
                      "",
                  widget: TextField()),
            //created year
            if (widget.controller.item.propertyTypeLanduse != null &&
                (widget.controller.item.propertyTypeLanduse?.titlePartition ??
                        "")
                    .isNotEmpty &&
                (widget.controller.item.propertyTypeLanduse
                            ?.titlePartition ??
                        "") !=
                    ("---"))
              widget.box(
                  title: widget.controller.item.propertyTypeLanduse
                          ?.titlePartition ??
                      "",
                  widget: TextField())
          ]),
      ],
    );
  }
}

abstract class SubNewEstateBase extends StatefulWidget {
  NewEstateController controller;

  SubNewEstateBase({Key? key, required this.controller});

  Container box({required String title, required Widget widget}) {
    return Container(
      decoration: BoxDecoration(color: GlobalColor.colorBackground),
      padding: new EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          Container(margin: EdgeInsets.only(top: 10), child: widget),
          Positioned(
            left: 10,
            top: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              color: Colors.white,
              child: Text(title,
                  style: const TextStyle(color: GlobalColor.colorAccent)),
            ),
          )
        ],
      ),
    );
  }

  Card card({required List<Widget> children}) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: children,
        ));
  }
}
