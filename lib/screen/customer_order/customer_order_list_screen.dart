import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/customer_order_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/landused/list_entity_screen.dart';

import '../../widget/contract_widget.dart';

class CustomerOrderListScreen
    extends EntityListScreen<EstateCustomerOrderModel> {
  CustomerOrderListScreen.withFilterScreen({super.key})
      : super.withFilterScreen(
          title: GlobalString.myEstate,
          controller: CustomerOrderController(),
        );
}

