import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/new_estate_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/edit_estate_screen.dart';
import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:intl/intl.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';
import 'package:collection/collection.dart';

class EditEstateController extends NewEstateController {
  static start(BuildContext context, String id) {
    Future.microtask(() => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditEstateScreen(
              id: id,
            ))));
  }

  Future<EstatePropertyModel> geModel(String id) async {
    if (item.id != null) {
      return item;
    }
    item = await EstatePropertyService().getOneByEdit(id);
    if (item.area != 0) {
      areaController.text = priceFormat(item.area ?? 0);
    }
    if (item.partition != 0) {
      areaController.text = priceFormat(item.partition ?? 0);
    }
    if (item.createdYaer != 0) {
      areaController.text = priceFormat(item.createdYaer ?? 0);
    }
    for (EstatePropertyDetailGroupModel group
        in item.propertyDetailGroups ?? []) {
      for (EstatePropertyDetailModel detail in group.propertyDetails ?? []) {
        EstatePropertyDetailValueModel? estatePropertyDetailModel =
            (item.propertyDetailValues ?? []).firstWhereOrNull(
                (valueModel) => valueModel.linkPropertyDetailId == detail.id);
        if (estatePropertyDetailModel != null &&
            (estatePropertyDetailModel.value ?? "").toLowerCase() != "false"&&
            (estatePropertyDetailModel.value ?? "").toLowerCase() != "0") {
          detail.text.text = estatePropertyDetailModel.value ?? "";
        } else {
          detail.text.text = "";
        }
      }
    }
    codeTextWidget.text = item.caseCode ?? "";
    titleTextWidget.text = item.title ?? "";
    descTextWidget.text = item.description ?? "";
    addressTextWidget.text = item.address ?? "";
    locationTextController.text = item.linkLocationIdTitle ?? "";
    return item;
  }
  @override
  Future<Sub1Data> subOneLoad() async {
    Sub1Data data = await super.subOneLoad();
    if (item.linkPropertyTypeUsageId != null) {
      item.propertyTypeUsage = data.typeUsagesList
          .where(
              (element) => element.id == (item.linkPropertyTypeUsageId ?? ""))
          .first;
    }
    if (item.linkPropertyTypeLanduseId != null) {
      item.propertyTypeLanduse = data.landUsesList
          .where(
              (element) => element.id == (item.linkPropertyTypeLanduseId ?? ""))
          .first;
    }

    return data;
  }

  String priceFormat(dynamic price) {
    return NumberFormat("###,###,###,###,###,###").format(price);
  }

  Future<void> editModel(BuildContext context) async {
    item.propertyDetailGroups = null;
    item.uploadFileGUID = [];
    if (mainImage != null &&
        mainImage?.guId != null &&
        (mainImage?.guId.isNotEmpty ?? false)) {
      item.uploadFileGUID?.add(mainImage?.guId ?? "");
    }
    for (ImageUpload x in otherImage) {
      item.uploadFileGUID?.add(x.guId ?? "");
    }
    for (EstateContractModel model in item.contracts ?? []) {
      model.linkCoreCurrencyId = selectedCurrency.id;
    }
    SubLoadingScreen.showProgress(context);
    var errorException = await EstatePropertyService().edit(item);
    SubLoadingScreen.dismiss(context);
    if (errorException.isSuccess) {
      Navigator.of(context).pop();
    } else {
      toast(context, errorException.errorMessage ?? GlobalString.error);
    }
  }
}
