import 'package:base/src/index.dart';
import 'package:flutter/material.dart';


class CustomerOrderController extends BaseListController<EstateCustomerOrderModel> {
  Widget Function(BuildContext context, EstateCustomerOrderModel m, int index)?
      adapterCreatorFunction;

  CustomerOrderController({ FilterModel? filter})
      : super(filterModel: filter);

  @override
  Future<List<EstateCustomerOrderModel>> service(FilterModel filter) {
    return EstateCustomerOrderService().getAllEditor(filter);
  }

  @override
  void showFilters(BuildContext context) {
    // TODO: implement showFilters
  }

  @override
  Widget widgetAdapter(BuildContext context, EstateCustomerOrderModel m, int index) {
    if (adapterCreatorFunction != null) {
      return adapterCreatorFunction!(context, m, index);
    } else {
      return _ModelAdapter(model: m);
    }
  }
}

class _ModelAdapter extends StatelessWidget {
  EstateCustomerOrderModel model;

  _ModelAdapter({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw Container();
  }
}
