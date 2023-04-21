import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';

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

  estateList(BuildContext context) {}
}

class _LandUsedVerticalAdapterState
    extends _EstatePropertyHorizontalAdapterState {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: super.build(context),
    );
  }
}

class _EstatePropertyHorizontalAdapterState
    extends BaseEntityAdapterEstate<LandUsePropertyAdapter> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => widget.estateList(context),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.model.linkMainImageIdSrc != null)
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Image.network(
                    fit: BoxFit.fill,
                    width: GlobalData.screenWidth*((1 / 8)),
                    height: GlobalData.screenWidth*((1 / 8)),
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
