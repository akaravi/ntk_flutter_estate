import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';
import 'package:ntk_flutter_estate/widget/estate_property_details_widget.dart';
import 'package:ntk_flutter_estate/widget/property_detail_selector_widget.dart';

import '../../controller/new_estate_controller.dart';

class SubNewEstate2 extends SubNewEstateBase {
  SubNewEstate2({Key? key, required NewEstateController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewEstate2> createState() => _ContainerState();
}

class _ContainerState extends State<SubNewEstate2> {
  @override
  Widget build(BuildContext context) {
    if (widget.screenWidth == -1) {
      widget.screenWidth = MediaQuery.of(context).size.width;
    }
    return FutureBuilder<Sub2Data>(
        future: widget.controller.subTowLoad(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                children: (snapshot.data?.propertydetailGroups ?? [])
                    .map((e) => widget.card(
                          children: [
                            widget.box(
                                title: e.title ?? "",
                                widget: Wrap(
                                  children: ((e.propertyDetails ?? []).map(
                                      (t) => Container(width: 4*widget.screenWidth/10,
                                        child: PropertyDetailSelector()
                                            .viewHolder(context,t),
                                      ))).toList(),
                                )),
                          ],
                        ))
                    .toList());
          }
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const SubLoadingScreen());
        });
  }
}
