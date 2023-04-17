import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/new_customer_order_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:ntk_flutter_estate/widget/wrap_widget_model.dart';
import 'package:base/src/index.dart';

import '../sub_loading_screen.dart';

class SubNewCustomerOrder1 extends SubNewCustomerOrderBase {
  SubNewCustomerOrder1(
      {Key? key, required NewCustomerOrderController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewCustomerOrder1> createState() => _Container1State();
}

class _Container1State extends State<SubNewCustomerOrder1> {
  @override
  Widget build(BuildContext context) {
    if (widget.screenWidth == -1) {
      widget.screenWidth = MediaQuery.of(context).size.width;
    }
    return FutureBuilder<Sub1CustomerData>(
        future: widget.controller.subOneLoad(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.card(children: [
                  widget.box(
                      title: GlobalString.estateTypeUsage,
                      widget: WrapWidgetModel<EstatePropertyTypeUsageModel>(
                        selectMethod: (item) {
                          setState(() {
                            widget.controller.item.propertyTypeUsage = item;
                            widget.controller.item.propertyTypeLanduse = null;
                          });
                        },
                        models: snapshot.data?.typeUsagesList ?? [],
                        titleModelMethod: (item) => item.title ?? "",
                      )),
                ]),
                if (widget.controller.item.propertyTypeUsage != null)
                  widget.card(children: [
                    //landused
                    widget.box(
                        title: GlobalString.estateType,
                        widget: WrapWidgetModel<EstatePropertyTypeLanduseModel>(
                          selectMethod: (item) {
                            setState(() {
                              widget.controller.item.propertyTypeLanduse = item;
                            });
                          },
                          models: widget.controller.usageList(snapshot.data),
                          titleModelMethod: (item) => item.title ?? "",
                        )),
                    if (widget.controller.item.propertyTypeUsage != null)
                      widget.textFieldBoxWidget(
                          title: GlobalString.areaAsMeter,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                          textController: widget.controller.areaController),
                    //created year
                    if (widget.controller.item.propertyTypeLanduse != null &&
                        (widget.controller.item.propertyTypeLanduse
                                    ?.titleCreatedYaer ??
                                "")
                            .isNotEmpty &&
                        (widget.controller
                                    .item.propertyTypeLanduse?.titleCreatedYaer ??
                                "") !=
                            ("---"))
                      widget.textFieldBoxWidget(
                          title: widget.controller.item.propertyTypeLanduse
                                  ?.titleCreatedYaer ??
                              "",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: false),
                          textController:
                              widget.controller.createdYearController),
                    //created year
                    if (widget.controller.item.propertyTypeLanduse !=
                            null &&
                        (widget.controller.item.propertyTypeLanduse
                                    ?.titlePartition ??
                                "")
                            .isNotEmpty &&
                        (widget.controller.item.propertyTypeLanduse
                                    ?.titlePartition ??
                                "") !=
                            ("---"))
                      widget.textFieldBoxWidget(
                          title: widget.controller.item.propertyTypeLanduse
                                  ?.titlePartition ??
                              "",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: false),
                          textController: widget.controller.partitionController)
                  ]),
              ],
            );
          }
          return SubLoadingScreen();
        });
  }
}

abstract class SubNewCustomerOrderBase extends StatefulWidget with Sub {
  NewCustomerOrderController controller;
  double screenWidth = -1;

  SubNewCustomerOrderBase({Key? key, required this.controller});
}
