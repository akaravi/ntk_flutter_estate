import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_font_awesome_web_names/flutter_font_awesome.dart';

//for view on estate detail screen for properties of each Estate
class EstatePropertyDetailWidget extends StatelessWidget {
  List<EstatePropertyDetailGroupModel> list;

  factory EstatePropertyDetailWidget.forView(
      List<EstatePropertyDetailGroupModel?> details,
      List<EstatePropertyDetailValueModel?> values) {
    for (EstatePropertyDetailGroupModel? estatePropertyDetailGroupModel
        in (details)) {
      List<EstatePropertyDetailModel> newDetail = [];
      for (EstatePropertyDetailModel estatePropertyDetailModel
          in estatePropertyDetailGroupModel?.propertyDetails ?? []) {
        EstatePropertyDetailValueModel? estatePropertyDetailValueModel =
            values.firstWhereOrNull(
          (valueModel) =>
              valueModel?.linkPropertyDetailId == estatePropertyDetailModel.id,
        );

        estatePropertyDetailModel.value = estatePropertyDetailValueModel?.value;
        if (estatePropertyDetailModel.value != null &&
            estatePropertyDetailModel.value != "") {
          newDetail.add(estatePropertyDetailModel);
        }
      }
      estatePropertyDetailGroupModel?.propertyDetails = (newDetail);
    }
    details
        .removeWhere((element) => element?.propertyDetails?.isEmpty ?? false);

    return EstatePropertyDetailWidget._internal(List.from(details));
  }

  EstatePropertyDetailWidget._internal(this.list, {Key? key});

  @override
  Widget build(BuildContext context) {
    var w = list.map((detailGroup) => createRow(detailGroup)).toList();
    return Column(
      children: w,
    );
  }

  Widget createRow(EstatePropertyDetailGroupModel detailGroup) {
    return Column(
      children: [
        Text(detailGroup.title ?? ""),
        GridView.builder( shrinkWrap: true,
            itemCount: detailGroup.propertyDetails?.length,
            itemBuilder: (context, index) => ItemTile(
                detailGroup.propertyDetails?[index] ??
                    new EstatePropertyDetailModel()),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            )),
      ],
    );
  }

  Widget ItemTile(EstatePropertyDetailModel propertyDetail) {
    return Row(
      children: [
        FaIcon(propertyDetail.iconFont??""),
        Text(propertyDetail.title ?? ""),
        Text(propertyDetail.value??"")
      ],
    );
  }
}
