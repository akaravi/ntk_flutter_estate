import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:ntk_flutter_estate/widget/wrap_widget_model.dart';

import '../../controller/new_estate_controller.dart';
import '../sub_loading_screen.dart';

class SubNewEstate4 extends SubNewEstateBase {
  SubNewEstate4({Key? key, required NewEstateController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewEstate4> createState() => _Container1State();
}

class _Container1State extends State<SubNewEstate4> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Sub4Data>(
        future: widget.controller.subFourLoad(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(children: [
              widget.card(children: [
                widget.box(
                    title: GlobalString.contractType,
                    widget: WrapWidgetModel<EstateContractTypeModel>(
                        models: snapshot.data?.contractsList ?? [],
                        titleModelMethod: (item) => item?.title ?? "",
                        selectMethod: (item) {
                          setState(() {});
                        }))
              ])
            ]);
          }
          return SubLoadingScreen();
        });
  }
}
