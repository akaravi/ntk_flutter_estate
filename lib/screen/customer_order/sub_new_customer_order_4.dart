import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/new_customer_order_controller.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';

class SubNewCustomerOrder4 extends SubNewCustomerOrderBase {
  SubNewCustomerOrder4(
      {Key? key, required NewCustomerOrderController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewCustomerOrder4> createState() => _Container1State();
}

class _Container1State extends State<SubNewCustomerOrder4> {
  @override
  Widget build(BuildContext context) {
    if (widget.screenWidth == -1) {
      widget.screenWidth = MediaQuery.of(context).size.width;
    }
    return Container();
  }
}

abstract class SubNewCustomerOrderBase extends StatefulWidget with Sub {
  NewCustomerOrderController controller;
  double screenWidth = -1;

  SubNewCustomerOrderBase({Key? key, required this.controller});
}
