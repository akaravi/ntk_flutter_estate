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
    if (widget.screenWidth == -1) {
      widget.screenWidth = MediaQuery
          .of(context)
          .size
          .width;
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

abstract class SubNewEstateBase extends StatefulWidget with Sub {
  NewEstateController controller;
  double screenWidth = -1;

  SubNewEstateBase({Key? key, required this.controller});
}
mixin Sub{


  Container box(
      {bool? fitContainer, required String title, required Widget widget}) {
    fitContainer ??= false;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: GlobalColor.colorBackground),
      margin: new EdgeInsets.all(20.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          ClipPath(
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      border: Border.all(
                          width: 1, color: GlobalColor.colorPrimary)),
                  padding: fitContainer
                      ? EdgeInsets.zero
                      : EdgeInsets.only(
                    right: 16,
                    left: 16,
                    bottom: 20,
                    top: 20,
                  ),
                  child: widget),
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: (fitContainer)
                          ? BorderRadius.circular(16)
                           :BorderRadius.zero))),
          Positioned(
            top: -10,
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

  Container card({required List<Widget> children}) {
    return Container(
      child: Card(
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipPath(
            child: Column(
              children: children,
            ),
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),
          )),
    );
  }

  Widget textFieldBoxWidget({required String title,
    required TextEditingController textController,
    TextInputType? keyboardType}) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      padding:
      const EdgeInsets.only(top: 10, bottom: 10, left: 16.0, right: 16),
      child: TextField(
        controller: textController,
        keyboardType: keyboardType ?? TextInputType.number,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: GlobalColor.colorPrimary, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: GlobalColor.colorPrimary, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: title,
            labelStyle: TextStyle(
              color: GlobalColor.colorAccent,
            )),
      ),
    );
  }


}
