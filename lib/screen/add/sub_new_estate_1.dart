import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/sub_loading_screen.dart';
import 'package:ntk_flutter_estate/widget/wrap_widget_model.dart';
import 'package:base/src/index.dart';
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
    return FutureBuilder<Sub1Data>(
        future: widget.controller.subOneLoad(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                widget.card(children: [
                  widget.box(
                      title: GlobalString.estateType,
                      widget: WrapWidgetModel<EstatePropertyTypeUsageModel>(
                        models: snapshot.data?.typeUsagesList ?? [],
                        titleModel: (item) => item.title ?? "",
                      )),
                ]),
                if (widget.controller.item.propertyTypeUsage != null)
                  widget.card(children: [
                    //landused
                    widget.box(
                        title: GlobalString.estateType,
                        widget: WrapWidgetModel<EstatePropertyTypeUsageModel>(
                          models: snapshot.data?.typeUsagesList ?? [],
                          titleModel: (item) => item.title ?? "",
                        )),

                    widget.box(
                        title: GlobalString.areaAsMeter, widget: TextField()),
                    //created year
                    if (widget.controller.item.propertyTypeLanduse != null &&
                        (widget.controller.item.propertyTypeLanduse
                                    ?.titleCreatedYaer ??
                                "")
                            .isNotEmpty &&
                        (widget.controller.item.propertyTypeLanduse
                                    ?.titleCreatedYaer ??
                                "") !=
                            ("---"))
                      widget
                          .box(
                              title: widget.controller.item.propertyTypeLanduse
                                      ?.titleCreatedYaer ??
                                  "",
                              widget: TextField()),
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
                      widget.box(
                          title: widget.controller.item.propertyTypeLanduse
                                  ?.titlePartition ??
                              "",
                          widget: TextField())
                  ]),
              ],
            );
          }
          return SubLoadingScreen();
        });
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
          Container(margin: EdgeInsets.only(top: 40,), child: widget),
          Positioned(

            top: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              color: Colors.white,
              child: Text(title,textAlign: TextAlign.start,
                  style: const TextStyle(color: GlobalColor.colorAccent,fontSize: 13)),
            ),
          )
        ],
      ),
    );
  }

  Card card({required List<Widget> children}) {
    return Card(elevation: 16,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: children,
        ));
  }
}
