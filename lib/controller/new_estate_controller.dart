import 'package:base/src/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

class NewEstateController {
  EstatePropertyModel item;

  TextEditingController areaController = TextEditingController();
  TextEditingController createdYearController = TextEditingController();
  TextEditingController partitionController = TextEditingController();
  TextEditingController codeTextWidget = TextEditingController();
  TextEditingController titleTextWidget = TextEditingController();
  TextEditingController descTextWidget = TextEditingController();
  TextEditingController addressTextWidget = TextEditingController();

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

  bool isValidForNext() {
    return true;
    //todo
  }

  bool isValidForPrev() {
    return true;
    //todo
  }

  Future<Sub2Data> subTowLoad() async {
    Sub2Data data = Sub2Data();
    data.propertydetailGroups =
        await EstatePropertyDetailGroupService().getAll(FilterModel()
          ..addFilter(FilterDataModel()
            ..setPropertyName("linkPropertyTypeLanduseId")
            ..value = item.propertyTypeLanduse?.id ?? ""));
    return data;
  }

  Future<Sub4Data> subFourLoad() async {
    Sub4Data data = Sub4Data();
    data.contractsList = await EstateContractTypeService()
        .getAll(FilterModel()..rowPerPage = 100);

    data.currencyList =
        await CoreCurrencyService().getAll(FilterModel()..rowPerPage = 100);
    return data;
  }
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
