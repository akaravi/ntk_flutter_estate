import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';


class FaqController extends BaseListController<TicketingFaqModel> {
  Widget Function(BuildContext context, TicketingFaqModel m, int index)?
  adapterCreatorFunction;

  FaqController({this.adapterCreatorFunction, FilterModel? filter})
      : super(filterModel: filter);

  @override
  Future<List<TicketingFaqModel>> service(FilterModel filter) {
    return TicketingFaqService().getAll(filter);
  }

  @override
  void showFilters(BuildContext context) {
    // TODO: implement showFilters
  }

  @override
  Widget widgetAdapter(BuildContext context, TicketingFaqModel m, int index) {
    if (adapterCreatorFunction != null) {
      return adapterCreatorFunction!(context, m, index);
    } else {
      return _ModelAdapter(model: m);
    }
  }
}

class _ModelAdapter extends StatelessWidget {
  TicketingFaqModel model;

  _ModelAdapter({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw Container();
  }
}
