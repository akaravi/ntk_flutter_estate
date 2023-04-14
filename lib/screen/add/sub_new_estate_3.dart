import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';

import '../../controller/new_estate_controller.dart';

class SubNewEstate3 extends SubNewEstateBase {
  SubNewEstate3({Key? key, required NewEstateController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewEstate3> createState() => _Container1State();
}

class _Container1State extends State<SubNewEstate3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.card(children: [
          widget.box(
              title: GlobalString.estateCode,
              widget: widget.textFieldWidget(
                  keyboardType: TextInputType.text,
                  textController: widget.controller.codeTextWidget))
        ]),
        widget.card(children: [
          widget.box(
              title: GlobalString.title,
              widget: widget.textFieldWidget(
                  keyboardType: TextInputType.text,
                  textController: widget.controller.titleTextWidget))
        ]),
        widget.card(children: [
          widget.box(
              title: GlobalString.desc,
              widget: widget.textFieldWidget(
                  keyboardType: TextInputType.text,
                  textController: widget.controller.descTextWidget))
        ]),
        widget.card(children: [
          widget.box(
              title: GlobalString.location,
              widget: widget.textFieldWidget(
                  keyboardType: TextInputType.text,
                  textController: widget.controller.descTextWidget)),
          widget.box(
              title: GlobalString.address,
              widget: widget.textFieldWidget(
                  keyboardType: TextInputType.text,
                  textController: widget.controller.addressTextWidget))
        ]),
      ],
    );
  }
}
