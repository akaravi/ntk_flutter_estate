import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/widget/contract_widget.dart';

import 'estate_detail_screen.dart';
import 'package:get_time_ago/get_time_ago.dart';

class EstatePropertyAdapter extends BaseEntityAdapter<EstatePropertyModel> {
  EstatePropertyAdapter._(
      {super.key, required super.model, required super.stateCreator});

  factory EstatePropertyAdapter.verticalType(
      {required EstatePropertyModel model}) {
    return EstatePropertyAdapter._(
        model: model,
        stateCreator: () => _EstatePropertyVerticalAdapterState());
  }

  factory EstatePropertyAdapter.horizontalType(
      {required EstatePropertyModel model}) {
    return EstatePropertyAdapter._(
        model: model,
        stateCreator: () => _EstatePropertyHorizontalAdapterState());
  }
}

class _EstatePropertyVerticalAdapterState
    extends BaseEntityAdapterEstate<EstatePropertyAdapter> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () async => viewDetail(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //1st's of Column is a row
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //image container
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.loose,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          fit: BoxFit.fill,
                          width: GlobalData.screenWidth * (3 / 8),
                          height: GlobalData.screenWidth * (3 / 8),
                          widget.model.linkMainImageIdSrc!,
                        ),
                      ),
                      //shade
                      Positioned.fill(
                          child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0x620B0505),
                        ),
                      )),
                      //location
                      Positioned(
                        bottom: 0,
                        child: Text(
                          "${widget.model.linkLocationIdTitle ?? ""} - ${widget.model.linkLocationIdParentTitle ?? ""}",
                          style: const TextStyle(
                              color: GlobalColor.colorTextOnPrimary,
                              fontSize: 13),
                        ),
                      ),
                      //picture count
                      Positioned(
                          right: 8,
                          top: 8,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: pictureCount(),
                                    style: const TextStyle(
                                        color: GlobalColor.colorTextOnPrimary,
                                        fontSize: 12)),
                                const WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: GlobalColor.colorTextOnPrimary,
                                        size: 13,
                                      ),
                                    )),
                              ],
                            ),
                          )),
                      Positioned(
                          left: 8,
                          top: 8,
                          child: Icon(
                            (widget.model.favorited ?? false)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: (widget.model.favorited ?? false)
                                ? Colors.red
                                : GlobalColor.colorTextOnPrimary,
                            size: 16,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                //title and price container
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.model.title!,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 14, color: GlobalColor.colorTextPrimary),
                      ),
                      ...ContractWidget().getPriceWidget(widget.model)
                    ],
                  ),
                ),
              ],
            ),
            //2's of Column is row of property
            Container(
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: GlobalColor.colorSemiBackground,
                ),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
                color: GlobalColor.colorBackground,
              ),
              child: Row(
                children: gePropertyWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> gePropertyWidget() {
    List<Widget> p = [];
    var textStyle = TextStyle();
    var dayStyle = TextStyle(color: GlobalColor.extraTimeAgoColor);
    if (widget.model.propertyTypeLanduse != null) {
      p.add(Expanded(
        child: Container(
          margin: EdgeInsets.all(1),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: GlobalColor.colorBackground),
          child: Text(widget.model.propertyTypeLanduse?.title ?? "",
              style: textStyle),
        ),
      ));
    }
    if (widget.model.propertyTypeLanduse != null &&
        widget.model.propertyTypeLanduse?.titlePartition != ("") &&
        widget.model.propertyTypeLanduse?.titlePartition != ("---")) {
      p.add(Expanded(
        child: Container(
          margin: EdgeInsets.all(1),
          alignment: Alignment.center,
          child: Text(
              "${widget.model.propertyTypeLanduse?.titlePartition ?? ""} : ${widget.model.partition?.toString() ?? ""}",
              style: textStyle),
        ),
      ));
    }
    if (widget.model.area != 0) {
      p.add(Expanded(
        child: Container(
          margin: EdgeInsets.all(1),
          alignment: Alignment.center,
          child: Text(
              "${((widget.model.area ?? 0) % 1 == 0 ? widget.model.area?.toInt() : widget.model.area)} ${GlobalString.meter}",
              style: textStyle),
        ),
      ));
    }
    p.add(Expanded(
      child: Container(
        margin: EdgeInsets.all(1),
        alignment: Alignment.center,
        child: Text(
            GetTimeAgo.parse(widget.model.createdDate ?? DateTime.now()),
            style: dayStyle),
      ),
    ));
    return p;
  }

  String pictureCount() {
    return (1 + ((widget.model.linkExtraImageIdsSrc?.length) ?? 0)).toString();
  }

//see detail
  Future<void> viewDetail(BuildContext context) async {
    EstateDetailController.detailPage(context,
        detailScreen: EstateDetailScreen(id: widget.model.id ?? ""));
  }
}

class _EstatePropertyHorizontalAdapterState
    extends _EstatePropertyVerticalAdapterState {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Card(
          elevation: 30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: SizedBox(
              width: 2 * GlobalData.screenWidth / 5,
              child: InkWell(
                onTap: () async => viewDetail(context),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //1st's is iamge
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          fit: BoxFit.cover,
                          width: 2 * GlobalData.screenWidth / 5,
                          height: 2 * GlobalData.screenHeight / 7,
                          widget.model.linkMainImageIdSrc!,
                        )),
                    const SizedBox(
                      width: 4,
                    ),

                    //title and price container
                    Column(

                      children: [  Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.model.title!,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 14, color: GlobalColor.colorTextPrimary),
                        ),
                      ),
                        Container(    width: 2 * GlobalData.screenWidth / 5,
                          height: -56+(1 * GlobalData.screenHeight / 7),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                ...ContractWidget().getPriceWidget(widget.model)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }
}
