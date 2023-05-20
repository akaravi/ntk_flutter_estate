import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/estate/estate_list_screen.dart';

class LandUsePropertyAdapter
    extends BaseEntityAdapter<EstatePropertyTypeLanduseModel> {
  LandUsePropertyAdapter._(
      {super.key, required super.model, required super.stateCreator});

  factory LandUsePropertyAdapter.verticalType(
      {required EstatePropertyTypeLanduseModel model}) {
    return LandUsePropertyAdapter._(
        model: model, stateCreator: () => _LandUsedVerticalAdapterState());
  }

  factory LandUsePropertyAdapter.horizontalType(
      {required EstatePropertyTypeLanduseModel model}) {
    return LandUsePropertyAdapter._(
        model: model,
        stateCreator: () => _EstatePropertyHorizontalAdapterState());
  }

  estateList(BuildContext context) {
    FilterModel filterModel = FilterModel()
      ..sortType = EnumSortType.descending
      ..sortColumn = "createDate"
      ..addFilter(FilterDataModel()
        ..setPropertyName("linkPropertyTypeLanduseId")
        ..value = model.id);
    BaseController().newPage(
        context: context,
        newWidget: (context) =>  EstateListScreen.withFilterScreen(
          filter: filterModel,
        ));
  }
}

class _LandUsedVerticalAdapterState
    extends _EstatePropertyHorizontalAdapterState {
  @override
  generateWidth() {
    width = GlobalData.screenWidth * ((1 / 4));
    height = GlobalData.screenWidth * ((1 / 4));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Expanded(child: super.build(context)),
    );
  }
}

class _EstatePropertyHorizontalAdapterState
    extends BaseEntityAdapterEstate<LandUsePropertyAdapter> {
  double? width;
  double? height;

  generateWidth() {
    width = GlobalData.screenWidth * ((1 / 8));
    height = GlobalData.screenWidth * ((1 / 8));
  }

  @override
  Widget build(BuildContext context) {
    generateWidth();
    return InkWell(
      onTap: () async => widget.estateList(context),
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.model.linkMainImageIdSrc != null)
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Image.network(
                    fit: BoxFit.fill,
                    width: width,
                    height: height,
                    widget.model.linkMainImageIdSrc!,
                  ),
                ),
              Text(
                widget.model.title!,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 11, color: GlobalColor.colorTextPrimary),
              ),
            ]),
      ),
    );
  }
}
