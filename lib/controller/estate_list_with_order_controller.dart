import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';

class EstateWithOrderController extends EstateListController {
  String id;

  EstateWithOrderController(
      {required this.id,
      required Widget Function(
              BuildContext context, EstatePropertyModel m, int index)
          adapterCreatorFunction,
      FilterModel? filter})
      : super(adapterCreatorFunction: adapterCreatorFunction, filter: filter);

  @override
  Future<List<EstatePropertyModel>> service(FilterModel filter) {
    return EstatePropertyService().getAllWithCustomerId(id, filter);
  }
}
