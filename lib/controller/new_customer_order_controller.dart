import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_4.dart';
import 'package:ntk_flutter_estate/screen/customer_order/new_customer_order_screen.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';

class NewCustomerOrderController {
  EstateCustomerOrderModel item;
  late CoreCurrencyModel selectedCurrency;
  String mainGUID = "";
  EstateContractTypeModel? selectedContractModel;
  TextEditingController areaController = TextEditingController();
  TextEditingController createdYearController = TextEditingController();
  TextEditingController partitionController = TextEditingController();
  TextEditingController codeTextWidget = TextEditingController();
  TextEditingController titleTextWidget = TextEditingController();
  TextEditingController descTextWidget = TextEditingController();
  TextEditingController maxSalePriceController = TextEditingController();
  TextEditingController minSalePriceController = TextEditingController();
  TextEditingController maxRentPriceController = TextEditingController();
  TextEditingController minRentPriceController = TextEditingController();
  TextEditingController maxDepositPriceController = TextEditingController();
  TextEditingController minDepositPriceController = TextEditingController();

  TextEditingController maxPeriodPriceController = TextEditingController();
  TextEditingController minPeriodPriceController = TextEditingController();

  NewCustomerOrderController({EstateCustomerOrderModel? model})
      : item = model ?? EstateCustomerOrderModel();

  Future<Sub1CustomerData> subOneLoad() async {
    var sub1data = Sub1CustomerData();
    sub1data.propertyTypeList =
        await EstatePropertyTypeService().getAll(FilterModel()
          ..rowPerPage = 100
          ..currentPageNumber = 1);
    sub1data.typeUsagesList =
        await EstatePropertyTypeUsageService().getAll(FilterModel()
          ..rowPerPage = 100
          ..currentPageNumber = 1);
    sub1data.landUsesList =
        await EstatePropertyTypeLandUseService().getAll(FilterModel()
          ..rowPerPage = 100
          ..currentPageNumber = 1);
    return sub1data;
  }

  List<EstatePropertyTypeLanduseModel> usageList(Sub1CustomerData? data) {
    List<EstatePropertyTypeModel> mappers = (data?.propertyTypeList ?? [])
        .where((element) =>
            element.linkPropertyTypeUsageId == item.propertyTypeUsage?.id)
        .toList();
    return (data?.landUsesList ?? [])
        .where((t) => mappers.any((k) => k.linkPropertyTypeLanduseId == t.id))
        .toList();
  }

  bool isValid(BuildContext context, int index) {
    switch (index) {
      case 1:
        return sub1Validation(context);
      case 2:
        return sub2Validation();
      case 3:
        return sub3Validation(context);
      case 4:
        return sub4Validation(context);
      case 5:
        return sub5Validation();
    }
    return true;
  }

  Future<Sub2CustomerData> subTowLoad() async {
    if (item.propertyDetailGroups == null) {
      Sub2CustomerData data = Sub2CustomerData();
      data.propertydetailGroups =
          await EstatePropertyDetailGroupService().getAll(FilterModel()
            ..addFilter(FilterDataModel()
              ..setPropertyName("linkPropertyTypeLanduseId")
              ..value = item.propertyTypeLanduse?.id ?? ""));
      return data;
    } else {
      await Future.delayed(const Duration(microseconds: 1000));
      Sub2CustomerData data = Sub2CustomerData();
      data.propertydetailGroups = item.propertyDetailGroups ?? [];
      return data;
    }
  }

  Future<Sub3Data> subThreeLoad() async {
    Sub3Data data = Sub3Data();
    data.contractsList = await EstateContractTypeService()
        .getAll(FilterModel()..rowPerPage = 100);

    data.currencyList =
        await CoreCurrencyService().getAll(FilterModel()..rowPerPage = 100);
    selectedCurrency = data.currencyList[0];
    return data;
  }

  static start(BuildContext context) {
    Future.microtask(() => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => NewCustomerOrderScreen())));
  }

  bool sub1Validation(BuildContext context) {
    if (item.propertyTypeUsage == null) {
      toast(context, GlobalString.insertTypeUsage);
      return false;
    }
    if (item.propertyTypeLanduse == null) {
      toast(context, GlobalString.insertTypeUse);
      return false;
    }
    if (areaController.text.isNotEmpty) {
      item.area = double.parse(areaController.text);
    }
    //for renewing details
    if (item.linkPropertyTypeLanduseId != null &&
        item.linkPropertyTypeLanduseId !=
            (item.propertyTypeLanduse?.id ?? "")) {
      item.propertyDetailGroups = null;
      item.propertyDetailValues = null;
    }
    item.linkPropertyTypeLanduseId = item.propertyTypeLanduse?.id;
    item.linkPropertyTypeUsageId = item.propertyTypeUsage?.id;

    if (createdYearController.text.isNotEmpty) {
      item.createdYaer = int.parse(createdYearController.text);
    }
    if (partitionController.text.isNotEmpty) {
      item.partition = int.parse(partitionController.text);
    }
    return true;
  }

  bool sub2Validation() {
    item.propertyDetailValues = [];
    for (EstatePropertyDetailGroupModel group
        in item.propertyDetailGroups ?? []) {
      (group.propertyDetails ?? [])
          .where((estatePropertyDetailModel) =>
      estatePropertyDetailModel.text.text.isNotEmpty)
          .toList()
          .forEach((estatePropertyDetailModel) {
        var v = EstatePropertyDetailValueModel()
          ..linkPropertyDetailId = estatePropertyDetailModel.id
          ..value = estatePropertyDetailModel.text.text;
        item.propertyDetailValues?.add(v);
      });
    }
    return true;
  }

  bool sub4Validation(BuildContext context) {
    if (titleTextWidget.text.isEmpty) {
      toast(context, GlobalString.plzInsertTitle);
      return false;
    }
    if (descTextWidget.text.isEmpty) {
      toast(context, GlobalString.insertDesc);
      return false;
    }

    if (item.linkLocationIds == null||(item.linkLocationIds??[]).isEmpty) {
      toast(context, GlobalString.insertLocation);
      return false;
    }
    item.title=titleTextWidget.text;
    item.description=descTextWidget.text;
    return true;
  }

  bool sub3Validation(BuildContext context) {
    if (selectedContractModel == null) {
      toast(context, GlobalString.plzInsertContract);
      return false;
    }
    item.linkContractTypeId=selectedContractModel?.id;
    //sale price
    if (selectedContractModel?.hasSalePrice ?? false) {
      //price is empty
      if (maxSalePriceController.text.isNotEmpty) {
        item.salePriceMax = int.parse(maxSalePriceController.text
            .replaceAll(ThousandsSeparatorInputFormatter.separator, ""));
      }
      if (minSalePriceController.text.isNotEmpty) {
        item.salePriceMin = int.parse(minSalePriceController.text
            .replaceAll(ThousandsSeparatorInputFormatter.separator, ""));
      }
    }
    //rent
    if (selectedContractModel?.hasRentPrice ?? false) {
      //add price
      if (maxRentPriceController.text.isEmpty) {
        item.rentPriceMax = int.parse(maxRentPriceController.text
            .replaceAll(ThousandsSeparatorInputFormatter.separator, ""));
      }
      if (minRentPriceController.text.isNotEmpty) {
        item.rentPriceMin = int.parse(minRentPriceController.text
            .replaceAll(ThousandsSeparatorInputFormatter.separator, ""));
      }
    }

    //deposit
    if (selectedContractModel?.hasDepositPrice ?? false) {
      //price is empty
      if (maxDepositPriceController.text.isNotEmpty) {
        item.depositPriceMax = int.parse(maxDepositPriceController.text
            .replaceAll(ThousandsSeparatorInputFormatter.separator, ""));
      }
      if (minDepositPriceController.text.isNotEmpty) {
        item.depositPriceMin = int.parse(minDepositPriceController.text
            .replaceAll(ThousandsSeparatorInputFormatter.separator, ""));
      }
    }
    //Period
    if (selectedContractModel?.hasPeriodPrice ?? false) {
      //price is empty
      if (maxPeriodPriceController.text.isNotEmpty) {
        item.periodPriceMax = int.parse(maxPeriodPriceController.text
            .replaceAll(ThousandsSeparatorInputFormatter.separator, ""));
      }
      if (minPeriodPriceController.text.isNotEmpty) {
        item.periodPriceMin = int.parse(minPeriodPriceController.text
            .replaceAll(ThousandsSeparatorInputFormatter.separator, ""));
      }
    }
    return true;
  }

  bool sub5Validation() {
    return true;
  }

  void toast(BuildContext c, String detail) {
    MotionToast.error(description: Text(detail)).show(c);
  }

  Future<void> createModel(BuildContext context) async {
    item.propertyDetailGroups = null;


    SubLoadingScreen.showProgress(context);
    var errorException = await EstateCustomerOrderService().add(item);
    SubLoadingScreen.dismiss(context);
    if (errorException.isSuccess) {
      Navigator.of(context).pop();
    } else {
      toast(context, errorException.errorMessage ?? GlobalString.error);
    }
  }
}

class Sub1CustomerData {
  late List<EstatePropertyTypeModel> propertyTypeList;
  late List<EstatePropertyTypeUsageModel> typeUsagesList;
  late List<EstatePropertyTypeLanduseModel> landUsesList;
}

class Sub2CustomerData {
  late List<EstatePropertyDetailGroupModel> propertydetailGroups;
}

class Sub3Data {
  late List<CoreCurrencyModel> currencyList;
  late List<EstateContractTypeModel> contractsList;
}
