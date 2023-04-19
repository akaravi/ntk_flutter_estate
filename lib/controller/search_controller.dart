import 'package:flutter/material.dart';
import 'package:base/src/index.dart';

class SearchController {
  TextEditingController textController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController createdYearController = TextEditingController();
  TextEditingController partitionController = TextEditingController();

  EstatePropertyTypeUsageModel? propertyTypeUsage;
  EstatePropertyTypeLanduseModel? propertyTypeLanduse;
  EstateContractTypeModel? selectedContractModel;

  bool salePriceAgreement = false;
  bool rentPriceAgreement = false;
  bool depositPriceAgreement = false;
  bool periodPriceAgreement = false;

  List<EstatePropertyDetailGroupModel>? propertydetailGroups;

  Future<SearchData> getData() async {
    var data = SearchData();
    data.propertyTypeList =
        await EstatePropertyTypeService().getAll(FilterModel()
          ..rowPerPage = 100
          ..currentPageNumber = 1);
    data.typeUsagesList =
        await EstatePropertyTypeUsageService().getAll(FilterModel()
          ..rowPerPage = 100
          ..currentPageNumber = 1);
    data.landUsesList =
        await EstatePropertyTypeLandUseService().getAll(FilterModel()
          ..rowPerPage = 100
          ..currentPageNumber = 1);
    data.contractsList = await EstateContractTypeService()
        .getAll(FilterModel()..rowPerPage = 100);
    return data;
  }

  List<EstatePropertyTypeLanduseModel> usageList(SearchData data) {
    List<EstatePropertyTypeModel> mappers = (data?.propertyTypeList ?? [])
        .where((element) =>
            element.linkPropertyTypeUsageId == propertyTypeUsage?.id)
        .toList();
    return (data?.landUsesList ?? [])
        .where((t) => mappers.any((k) => k.linkPropertyTypeLanduseId == t.id))
        .toList();
  }

  Future<List<EstatePropertyDetailGroupModel>> getproperties() async {
    var list = await EstatePropertyDetailGroupService().getAll(FilterModel()
      ..addFilter(FilterDataModel()
        ..setPropertyName("linkPropertyTypeLanduseId")
        ..value = propertyTypeLanduse?.id ?? ""));
    return list;
  }
}

class SearchData {
  late List<EstatePropertyTypeModel> propertyTypeList;
  late List<EstatePropertyTypeUsageModel> typeUsagesList;
  late List<EstatePropertyTypeLanduseModel> landUsesList;

  late List<EstateContractTypeModel> contractsList;
}
