import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';
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
    if (widget.screenWidth == -1) {
      widget.screenWidth = MediaQuery.of(context).size.width;
    }
    return FutureBuilder<Sub1Data>(
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
                        isSelected: (element) =>
                            element.id ==
                            widget.controller.item.propertyTypeUsage?.id,
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
                          isSelected: (p0) =>
                              p0.id ==
                              widget.controller.item.propertyTypeLanduse?.id,
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
                          textController:
                              widget.controller.partitionController),
                    const SizedBox(height: 8),
                  ]),
              ],
            );
          }
          return SizedBox(
              width: GlobalData.screenWidth,
              height: GlobalData.screenHeight,
              child: const SubLoadingScreen());
        });
  }
}

abstract class SubNewEstateBase extends StatefulWidget with Sub {
  NewEstateController controller;
  double screenWidth = -1;

  SubNewEstateBase({Key? key, required this.controller});
}

mixin Sub {
  Container box(
      {bool? fitContainer, required String title, required Widget widget}) {
    fitContainer ??= false;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: GlobalColor.colorBackground),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          ClipPath(
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: (fitContainer)
                          ? BorderRadius.circular(16)
                          : BorderRadius.zero)),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      border: Border.all(
                          width: 1, color: GlobalColor.colorPrimary)),
                  padding: fitContainer
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(
                          right: 8,
                          left: 8,
                          bottom: 13,
                          top: 13,
                        ),
                  child: widget)),
          Positioned(
            top: -12,
            right: 20,
            child: Container(
              color: Colors.white,
              child: Text(title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: GlobalColor.colorAccent, fontSize: 13)),
            ),
          )
        ],
      ),
    );
  }

  Widget card({required List<Widget> children}) {
    return Card(
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          child: Column(
            children: children,
          ),
        ));
  }

  Widget textFieldBoxWidget(
      {required String title,
      required TextEditingController textController,
      TextInputType? keyboardType}) {
    return Container(
      margin: EdgeInsets.only(top: 2, bottom: 2),
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16.0, right: 16),
      child: TextField(
        style: const TextStyle(fontSize: 13),
        controller: textController,
        keyboardType: keyboardType ?? TextInputType.number,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: GlobalColor.colorPrimary, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: GlobalColor.colorPrimary, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: title,
            labelStyle: const TextStyle(
              fontSize: 13,
              color: GlobalColor.colorAccent,
            )),
      ),
    );
  }
}
