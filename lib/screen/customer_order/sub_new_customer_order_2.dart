import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/customer_order/sub_new_customer_order_1.dart';
import 'package:ntk_flutter_estate/widget/estate_property_details_widget.dart';
import 'package:ntk_flutter_estate/widget/property_detail_selector_widget.dart';

import '../../controller/new_customer_order_controller.dart';
import '../sub_loading_screen.dart';

class SubNewCustomerOrder2 extends SubNewCustomerOrderBase {
  SubNewCustomerOrder2({Key? key, required NewCustomerOrderController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewCustomerOrder2> createState() => _Container1State();
}

class _Container1State extends State<SubNewCustomerOrder2> {
  @override
  Widget build(BuildContext context) {
    if (widget.screenWidth == -1) {
      widget.screenWidth = MediaQuery.of(context).size.width;
    }
    return FutureBuilder<Sub2CustomerData>(
        future: widget.controller.subTowLoad(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: (snapshot.data?.propertydetailGroups ?? [])
                    .map((e) => widget.card(children: [
                  widget.box(
                      title: e.title ?? "",
                      widget: Wrap(
                        children: ((e.propertyDetails ?? []).map((t) =>
                            PropertyDetailSelector().viewHolder(t)))
                            .toList(),
                      ))
                ]))
                    .toList());
          }
          return SubLoadingScreen();
        });
  }
}
