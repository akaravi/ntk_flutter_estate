import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_font_awesome_web_names/flutter_font_awesome.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:collection/collection.dart';

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
    return Column(mainAxisSize: MainAxisSize.max,children: [
      Container(width:double.infinity,color:GlobalColor.colorAccent.withOpacity(.1),child: Text(detailGroup.title ?? "")),
      Wrap(
        children: [
          ...(detailGroup.propertyDetails ?? []).mapIndexed(
            (index, item) => ItemTile(detailGroup.propertyDetails?[index] ??
                EstatePropertyDetailModel()),)
        ],
      )
    ]);
  }

  Widget ItemTile(EstatePropertyDetailModel propertyDetail) {
    String iconFont = propertyDetail.iconFont ?? "";
    String icon = iconFont.replaceFirst(
        iconFont.substring(0, iconFont.indexOf("-") + 1), "fas fa-");
    return Container(width: -20+GlobalData.screenWidth/2,padding: EdgeInsets.only(bottom: 4,top: 4),
      child: Row(
        children: [
          // {
          //   " + iconFont.replace(iconFont.substring(0,iconFont.indexOf(" -
          //       ")+1), "
          //   faw - ") + "
          // }
          // "
          FaIcon(FaIconData.fromName(icon).name,
              size: 20,
              color: propertyDetail.iconColor != null
                  ? ((propertyDetail.iconColor ?? "#000").toColor())
                  : GlobalColor.colorAccent),
          SizedBox(
            width: 4,
          ),
          Text(propertyDetail.title ?? "",style: TextStyle(fontSize: 13),),
          Text(" : "),
          if ((propertyDetail.value ?? "") == "true")
            const Icon(
              Icons.check_box,size: 13,
              color: GlobalColor.colorAccentDark,
            )
          else if ((propertyDetail.value ?? "") == "false")
            const Icon(size: 13,
              Icons.close,
              color: GlobalColor.colorAccentDark,
            )
          else
            Flexible(
              child: Text(propertyDetail.value ?? "",style: TextStyle(fontSize: 11), maxLines: 2,
                overflow: TextOverflow.ellipsis,),
            )
        ],
      ),
    );
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
