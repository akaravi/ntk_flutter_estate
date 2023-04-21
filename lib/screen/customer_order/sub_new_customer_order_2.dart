import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/screen/customer_order/sub_new_customer_order_1.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';
import 'package:ntk_flutter_estate/widget/property_detail_selector_widget.dart';

import '../../controller/new_customer_order_controller.dart';

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
            return SingleChildScrollView(
              child: Column(
                  children: (snapshot.data?.propertydetailGroups ?? [])
                      .map((e) => widget.card(children: [
                    widget.box(
                        title: e.title ?? "",
                        widget: Flexible(
                          child: Wrap(runSpacing: 8,spacing: 8,
                            children: ((e.propertyDetails ?? []).map((t) =>
                                PropertyDetailSelector().viewHolder(context,t)))
                                .toList(),
                          ),
                        ))
                  ]))
                      .toList()),
            );
          }
          return SubLoadingScreen();
        });
  }
}
