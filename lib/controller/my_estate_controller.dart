import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/screen/generalized/dialogs.dart';


class MyEstateController extends BaseListController<EstatePropertyModel> {
  Widget Function(BuildContext context, EstatePropertyModel m, int index)?
  adapterCreatorFunction;

  MyEstateController({this.adapterCreatorFunction, FilterModel? filter})
      : super(filterModel: filter);

  @override
  Future<List<EstatePropertyModel>> service(FilterModel filter) {
    return EstatePropertyService().getAllEditor(filter);
  }

  @override
  void showFilters(BuildContext context) {
    // TODO: implement showFilters
  }

  @override
  Widget widgetAdapter(BuildContext context, EstatePropertyModel m, int index) {
    if (adapterCreatorFunction != null) {
      return adapterCreatorFunction!(context, m, index);
    } else {
      return BaseEstateModelAdapter(model: m);
    }
  }

  static void delete(BuildContext context,EstatePropertyModel model) {
    DeleteDialog().showConfirm( context: context, delete: ()async => EstatePropertyService().delete(model));
  }
}

class BaseEstateModelAdapter extends StatelessWidget {
  EstatePropertyModel model;

  BaseEstateModelAdapter({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw Container();
  }
}
