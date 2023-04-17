import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';

import '../../controller/new_estate_controller.dart';

class SubNewEstate5 extends SubNewEstateBase {
  SubNewEstate5({Key? key, required NewEstateController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewEstate5> createState() => _Container1State();
}

class _Container1State extends State<SubNewEstate5> {

  @override
  Widget build(BuildContext context) {
    if (widget.screenWidth == -1) {
      widget.screenWidth = MediaQuery.of(context).size.width;
    }
    return Column(
      children: [
        widget.card(children: [
          widget.box(
              title: GlobalString.mainPic,
              widget: Container(
                width: 200,
              ))
        ]),
        if (widget.controller.mainGUID != "")
          widget.card(children: [
            widget.box(title: GlobalString.morePic, widget: widget)
          ])
      ],
    );
  }
}
