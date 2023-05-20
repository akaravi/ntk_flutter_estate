import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';


class TicketListController extends BaseListController<TicketingTaskModel> {
  Widget Function(BuildContext context, TicketingTaskModel m, int index)?
  adapterCreatorFunction;

  TicketListController({this.adapterCreatorFunction, FilterModel? filter})
      : super(filterModel: filter);

  @override
  Future<List<TicketingTaskModel>> service(FilterModel filter) {
    return TicketingTaskService().getAll(filter);
  }

  @override
  void showFilters(BuildContext context) {
    // TODO: implement showFilters
  }

  @override
  Widget widgetAdapter(BuildContext context, TicketingTaskModel m, int index) {
    if (adapterCreatorFunction != null) {
      return adapterCreatorFunction!(context, m, index);
    } else {
      return _ModelAdapter(model: m);
    }
  }
}

class _ModelAdapter extends StatelessWidget {
  TicketingTaskModel model;

  _ModelAdapter({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw Container();
  }
}
