import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/screen/estate/estate_history_list_screen.dart';

class HistoryListController
    extends BaseListController<EstatePropertyHistoryModel> {
  List<EstateActivityTypeModel>? dataType;

  HistoryListController({FilterModel? filter}) : super(filterModel: filter);

  @override
  Future<List<EstatePropertyHistoryModel>> service(FilterModel filter) async {
    dataType ??= await EstateActivityTypeService().getAll(FilterModel()
      ..rowPerPage = 100
      ..currentPageNumber = 1);
    return EstatePropertyHistoryService().getAll(filter);
  }

  @override
  void showFilters(BuildContext context) {
    // TODO: implement showFilters
  }

  @override
  Widget widgetAdapter(
      BuildContext context, EstatePropertyHistoryModel m, int index) {
    return _ModelAdapter(
      model: m,
      dataType: dataType,
    );
  }

  static void start(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HistoryListScreen.withFilterScreen()));
  }
}

class _ModelAdapter extends StatelessWidget {
  EstatePropertyHistoryModel model;
  List<EstateActivityTypeModel>? dataType;

  _ModelAdapter({required this.model, required this.dataType, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(model.title ?? ""),
        Text(datatype(model)),
      ],
    );
  }

  String datatype(EstatePropertyHistoryModel model) {
    return (dataType
            ?.where((element) => element.id == model.linkActivityTypeId)
            .first
            .title ??
        "");
  }
}
