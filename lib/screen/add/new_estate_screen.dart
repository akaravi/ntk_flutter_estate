import 'package:flutter/cupertino.dart';
import 'package:ntk_flutter_estate/controller/new_estate_controller.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';

class NewEstateState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SubNewEstate1(
        controller: NewEstateController(),
      ),
    );
  }
}
