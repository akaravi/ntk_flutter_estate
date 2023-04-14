import 'package:flutter/src/widgets/framework.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';

import '../../controller/new_estate_controller.dart';

class SubNewEstate2 extends SubNewEstateBase {
  SubNewEstate2({Key? key, required NewEstateController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewEstate1> createState() => _Container1State();
}

class _Container1State extends State<SubNewEstate1> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

