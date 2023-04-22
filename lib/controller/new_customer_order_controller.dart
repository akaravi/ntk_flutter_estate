import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/customer_order/new_customer_order_screen.dart';

class NewCustomerOrderController {
  EstatePropertyModel item;
  late CoreCurrencyModel selectedCurrency;
  String mainGUID = "";
  EstateContractTypeModel? selectedContractModel;
  TextEditingController areaController = TextEditingController();
  TextEditingController createdYearController = TextEditingController();
  TextEditingController partitionController = TextEditingController();
  TextEditingController codeTextWidget = TextEditingController();
  TextEditingController titleTextWidget = TextEditingController();
  TextEditingController descTextWidget = TextEditingController();
  TextEditingController addressTextWidget = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController rentPriceController = TextEditingController();
  TextEditingController depositPriceController = TextEditingController();

  TextEditingController periodPriceController = TextEditingController();

  NewCustomerOrderController({EstatePropertyModel? model})
      : item = model ?? EstatePropertyModel();

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

  bool isValid(int index) {
    switch (index) {
      case 1:
        return sub1Validation();
      case 2:
        return sub2Validation();
      case 3:
        return sub3Validation();
      case 4:
        return sub4Validation();
      case 5:
        return sub5Validation();
    }
    return true;

  }

  Future<Sub2CustomerData> subTowLoad() async {
    Sub2CustomerData data = Sub2CustomerData();
    data.propertydetailGroups =
        await EstatePropertyDetailGroupService().getAll(FilterModel()
          ..addFilter(FilterDataModel()
            ..setPropertyName("linkPropertyTypeLanduseId")
            ..value = item.propertyTypeLanduse?.id ?? ""));
    return data;
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

  bool sub1Validation() {
    if (item.propertyTypeUsage == null) {
      toast(GlobalString.insertTypeUsage);
      return false;
    }
    if (item.propertyTypeLanduse == null) {
      toast(GlobalString.insertTypeUse);
      return false;
    }
    if (areaController.text.isEmpty) {
      toast(GlobalString.insertArea);
      return false;
    }
    if (item.linkPropertyTypeLanduseId != null &&
        item.linkPropertyTypeLanduseId !=
            (item.propertyTypeLanduse?.id ?? "")) {
      item.propertyDetailGroups = null;
      item.propertyDetailValues = null;
    }
    item.linkPropertyTypeLanduseId = item.propertyTypeLanduse?.id;
    item.linkPropertyTypeUsageId = item.propertyTypeUsage?.id;
    item.area = areaController.text as double?;
    item.createdYaer = createdYearController.text as int?;
    item.partition = partitionController.text as int?;
    return true;
  }

  bool sub2Validation() {
    item.propertyDetailValues = [];
    for (EstatePropertyDetailGroupModel group
        in item.propertyDetailGroups ?? []) {
      (group.propertyDetails ?? [])
          .where((estatePropertyDetailModel) =>
              estatePropertyDetailModel.value != null)
          .toList()
          .forEach((estatePropertyDetailModel) {
        var v = EstatePropertyDetailValueModel()
          ..id = estatePropertyDetailModel.id
          ..value = estatePropertyDetailModel.value;
        item.propertyDetailValues?.add(v);
      });
    }
    return true;
  }

  bool sub3Validation() {
    if (titleTextWidget.text.isEmpty) {
      toast(GlobalString.plzInsertTitle);
      return false;
    }
    if (descTextWidget.text.isEmpty) {
      toast(GlobalString.insertDesc);
      return false;
    }
    if (addressTextWidget.text.isEmpty) {
      toast(GlobalString.insertDesc);
      return false;
    }
    if (item.linkLocationId != null) {
      toast(GlobalString.insertLocation);
      return false;
    }

    return true;
  }

  bool sub4Validation() {
    if ((item.contracts ?? []).isEmpty) {
      toast(GlobalString.plzInsertContract);
      return false;
    }
    return true;
  }

  bool sub5Validation() {
    return true;
  }

  void toast(insertTypeUsage) {}
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
