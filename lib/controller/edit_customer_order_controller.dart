import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/new_customer_order_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/customer_order/edit_customer_screen.dart';
import 'package:base/src/index.dart';
import 'package:intl/intl.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';
import 'package:collection/collection.dart';

class EditCustomerOrderController extends NewCustomerOrderController {
  static start(BuildContext context, String id) {
    Future.microtask(() => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditCustomerOrderScreen(
              id: id,
            ))));
  }

  Future<EstateCustomerOrderModel> geModel(String id) async {
    if (item.id != null) {
      return item;
    }
    item = await EstateCustomerOrderService().getOneByEdit(id);
    if (item.area != 0) {
      areaController.text = priceFormat(item.area ?? 0);
    }
    if (item.partition != 0) {
      areaController.text = priceFormat(item.partition ?? 0);
    }
    if (item.createdYaer != 0) {
      areaController.text = priceFormat(item.createdYaer ?? 0);
    }
    titleTextWidget.text = item.title ?? "";
    descTextWidget.text = item.description ?? "";
    for (EstatePropertyDetailGroupModel group
        in item.propertyDetailGroups ?? []) {
      for (EstatePropertyDetailModel detail in group.propertyDetails ?? []) {
        EstatePropertyDetailValueModel? estatePropertyDetailModel =
            (item.propertyDetailValues ?? []).firstWhereOrNull(
                (valueModel) => valueModel.linkPropertyDetailId == detail.id);
        if (estatePropertyDetailModel != null &&
            (estatePropertyDetailModel.value ?? "").toLowerCase() != "false" &&
            (estatePropertyDetailModel.value ?? "").toLowerCase() != "0") {
          detail.text.text = estatePropertyDetailModel.value ?? "";
        } else {
          detail.text.text = "";
        }
      }
    }
    //get location titles
    item.locationTitles = [];
    for (int id in (item.linkLocationIds ?? [])) {
      item.locationTitles
          ?.add((await CoreLocationService().getOne(id)).title ?? "");
    }
    return item;
  }

  Future<void> editModel(BuildContext context) async {
    item.propertyDetailGroups = null;

    SubLoadingScreen.showProgress(context);
    var errorException = await EstateCustomerOrderService().edit(item);
    SubLoadingScreen.dismiss(context);
    if (errorException.isSuccess) {
      Navigator.of(context).pop();
    } else {
      toast(context, errorException.errorMessage ?? GlobalString.error);
    }
  }

  @override
  Future<Sub1CustomerData> subOneLoad() async {
    Sub1CustomerData data = await super.subOneLoad();
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

  @override
  Future<Sub3Data> subThreeLoad() async {
    Sub3Data data = Sub3Data();
    data.contractsList = await EstateContractTypeService()
        .getAll(FilterModel()..rowPerPage = 100);
    //find selected contracts
    selectedContractModel = data.contractsList
        .firstWhereOrNull((element) => element.id == item.linkContractTypeId);
    data.currencyList =
        await CoreCurrencyService().getAll(FilterModel()..rowPerPage = 100);
    //find selected currency
    selectedCurrency = data.currencyList.firstWhereOrNull(
            (element) => element.id == item.linkCoreCurrencyId) ??
        data.currencyList[0];
    //set min max values
    if (selectedContractModel != null) {
      if (selectedContractModel?.hasSalePrice ?? false) {
        if (item.salePriceMax != null && item.salePriceMax != 0) {
          maxSalePriceController.text = priceFormat(item.salePriceMax ?? 0);
        }
        if (item.salePriceMin != null && item.salePriceMin != 0) {
          minSalePriceController.text = priceFormat(item.salePriceMin ?? 0);
        }
      }
      if (selectedContractModel?.hasRentPrice ?? false) {
        if (item.rentPriceMax != null && item.rentPriceMax != 0) {
          maxRentPriceController.text = priceFormat(item.rentPriceMax ?? 0);
        }
        if (item.rentPriceMin != null && item.rentPriceMin != 0) {
          minRentPriceController.text = priceFormat(item.rentPriceMin ?? 0);
        }
      }
      //deposit
      if (selectedContractModel?.hasDepositPrice ?? false) {
        if (item.depositPriceMax != null && item.depositPriceMax != 0) {
          maxDepositPriceController.text =
              priceFormat(item.depositPriceMax ?? 0);
        }
        if (item.depositPriceMin != null && item.depositPriceMin != 0) {
          minDepositPriceController.text =
              priceFormat(item.depositPriceMin ?? 0);
        }
      }
      //Period
      if (selectedContractModel?.hasPeriodPrice ?? false) {
        if (item.periodPriceMax != null && item.periodPriceMax != 0) {
          maxPeriodPriceController.text = priceFormat(item.periodPriceMax ?? 0);
        }
        if (item.depositPriceMin != null && item.depositPriceMin != 0) {
          minPeriodPriceController.text =
              priceFormat(item.depositPriceMin ?? 0);
        }
      }
    }
    return data;
  }
}

String priceFormat(num price) {
  return NumberFormat("###,###,###,###,###,###").format(price);
}
