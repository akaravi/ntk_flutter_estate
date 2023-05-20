import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';


class PollingController extends BaseListController<PollingContentModel> {
  Widget Function(BuildContext context, PollingContentModel m, int index)?
  adapterCreatorFunction;

  PollingController({this.adapterCreatorFunction, FilterModel? filter})
      : super(filterModel: filter);

  @override
  Future<List<PollingContentModel>> service(FilterModel filter) {
    return PollingModelService().getAll(filter);
  }

  @override
  void showFilters(BuildContext context) {
    // TODO: implement showFilters
  }

  @override
  Widget widgetAdapter(BuildContext context, PollingContentModel m, int index) {
    if (adapterCreatorFunction != null) {
      return adapterCreatorFunction!(context, m, index);
    } else {
      return _ModelAdapter(model: m);
    }
  }
}

class _ModelAdapter extends StatelessWidget {
  PollingContentModel model;

  _ModelAdapter({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw Container();
  }
}
