import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';

class NewEstateController {
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

  NewEstateController({EstatePropertyModel? model})
      : item = model ?? EstatePropertyModel();

  Future<Sub1Data> subOneLoad() async {
    var sub1data = Sub1Data();
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

  List<EstatePropertyTypeLanduseModel> usageList(Sub1Data? data) {
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

  Future<Sub2Data> subTowLoad() async {
    if (item.propertyDetailGroups == null) {
      Sub2Data data = Sub2Data();
      data.propertydetailGroups =
          await EstatePropertyDetailGroupService().getAll(FilterModel()
            ..addFilter(FilterDataModel()
              ..setPropertyName("linkPropertyTypeLanduseId")
              ..value = item.propertyTypeLanduse?.id ?? ""));
      item.propertyDetailGroups = data.propertydetailGroups;
      return data;
    } else {
      await Future.delayed(const Duration(microseconds: 1000));
      Sub2Data data = Sub2Data();
      data.propertydetailGroups = item.propertyDetailGroups ?? [];
      return data;
    }
  }

  Future<Sub4Data> subFourLoad() async {
    Sub4Data data = Sub4Data();
    data.contractsList = await EstateContractTypeService()
        .getAll(FilterModel()..rowPerPage = 100);

    data.currencyList =
        await CoreCurrencyService().getAll(FilterModel()..rowPerPage = 100);
    selectedCurrency = data.currencyList[0];
    return data;
  }

  static start(BuildContext context) {
    Future.microtask(() => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NewEstateScreen())));
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
    //for renewing details
    if (item.linkPropertyTypeLanduseId != null &&
        item.linkPropertyTypeLanduseId !=
            (item.propertyTypeLanduse?.id ?? "")) {
      item.propertyDetailGroups = null;
      item.propertyDetailValues = null;
    }
    item.linkPropertyTypeLanduseId = item.propertyTypeLanduse?.id;
    item.linkPropertyTypeUsageId = item.propertyTypeUsage?.id;
    item.area = double.parse(areaController.text);
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

class Sub1Data {
  late List<EstatePropertyTypeModel> propertyTypeList;
  late List<EstatePropertyTypeUsageModel> typeUsagesList;
  late List<EstatePropertyTypeLanduseModel> landUsesList;
}

class Sub2Data {
  late List<EstatePropertyDetailGroupModel> propertydetailGroups;
}

class Sub4Data {
  late List<CoreCurrencyModel> currencyList;
  late List<EstateContractTypeModel> contractsList;
}
