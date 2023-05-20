import 'package:flutter/material.dart';
import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:ntk_flutter_estate/screen/estate/estate_list_screen.dart';
import 'package:ntk_flutter_estate/screen/estate/estate_search.dart';

import '../screen/add/sub_new_estate_1.dart';

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

  TextEditingController saleMaxController = TextEditingController();
  TextEditingController saleMinController = TextEditingController();
  TextEditingController rentMaxController = TextEditingController();
  TextEditingController rentMinController = TextEditingController();
  TextEditingController depositMaxController = TextEditingController();
  TextEditingController depositMinController = TextEditingController();
  TextEditingController periodMaxController = TextEditingController();
  TextEditingController periodMinController = TextEditingController();

  List<EstatePropertyDetailGroupModel>? propertydetailGroups;

  List<String> locationTitles = [];
  List<int> linkLocationIds = [];

  MinMax area = MinMax();
  MinMax createdYear = MinMax();
  MinMax partition = MinMax();

  static start(BuildContext context) {
    Future.microtask(() => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EstateSearchScreen())));
  }

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

  search(BuildContext context) {
    FilterModel filter = FilterModel()
      ..sortColumn = "createDate"
      ..sortType = EnumSortType.descending;

    String title = textController.text.trim();
    if (title.isNotEmpty) {
      filter.addFilter(FilterDataModel().setPropertyName("Title")
        ..value = (title)
        ..searchType = (EnumFilterDataModelSearchTypes.contains)
        ..clauseType = (EnumClauseType.or));
      filter.addFilter(FilterDataModel().setPropertyName("Description")
        ..value = (title)
        ..searchType = (EnumFilterDataModelSearchTypes.contains)
        ..clauseType = (EnumClauseType.or));
    }
    for (int locId in linkLocationIds) {
      filter.addFilter(FilterDataModel().setPropertyName("LinkLocationId")
        ..value = (locId)
        ..searchType = (EnumFilterDataModelSearchTypes.equal)
        ..clauseType = (EnumClauseType.or));
    }
    if (propertyTypeLanduse != null) {
      filter.addFilter(
          FilterDataModel().setPropertyName("LinkPropertyTypeLanduseId")
            ..value = (propertyTypeLanduse?.id)
            ..searchType = (EnumFilterDataModelSearchTypes.equal)
            ..clauseType = (EnumClauseType.and));
    }
    if (propertyTypeUsage != null) {
      filter.addFilter(
          FilterDataModel().setPropertyName("LinkPropertyTypeUsageId")
            ..value = (propertyTypeUsage?.id)
            ..searchType = (EnumFilterDataModelSearchTypes.equal)
            ..clauseType = (EnumClauseType.and));
    }
    //for contract
    if (selectedContractModel != null) {
      filter.addFilter(FilterDataModel()
          .setPropertyName("Contracts")
          .setPropertyAnyName("LinkEstateContractTypeId")
        ..value = (selectedContractModel?.id)
        ..searchType = (EnumFilterDataModelSearchTypes.equal)
        ..clauseType = (EnumClauseType.and));
      if (selectedContractModel?.hasRentPrice ?? false) {
        if (!rentPriceAgreement) {
          //for contract Type1
          if (rentMinController.text.isNotEmpty) {
            filter.addFilter(FilterDataModel()
                .setPropertyName("Contracts")
                .setPropertyAnyName("RentPrice")
              ..value = (rentMinController.text.isNotEmpty)
              ..searchType = (EnumFilterDataModelSearchTypes.greaterThan)
              ..clauseType = (EnumClauseType.and));
          }
          if (rentMaxController.text.isNotEmpty) {
            filter.addFilter(FilterDataModel()
                .setPropertyName("Contracts")
                .setPropertyAnyName("RentPrice")
              ..value = (rentMaxController.text.isNotEmpty)
              ..searchType = (EnumFilterDataModelSearchTypes.lessThan)
              ..clauseType = (EnumClauseType.and));
          }
        } else {
          filter.addFilter(FilterDataModel()
              .setPropertyName("Contracts")
              .setPropertyAnyName("RentPriceByAgreement")
            ..value = (true)
            ..searchType = (EnumFilterDataModelSearchTypes.equal)
            ..clauseType = (EnumClauseType.and));
        }
      }
      if (selectedContractModel?.hasSalePrice ?? false) {
        if (!salePriceAgreement) {
          //for contract Type2
          if (saleMinController.text.isNotEmpty) {
            filter.addFilter(FilterDataModel()
                .setPropertyName("Contracts")
                .setPropertyAnyName("SalePrice")
              ..value = (saleMinController.text.isNotEmpty)
              ..searchType = (EnumFilterDataModelSearchTypes.greaterThan)
              ..clauseType = (EnumClauseType.and));
          }
          if (saleMaxController.text.isNotEmpty) {
            filter.addFilter(FilterDataModel()
                .setPropertyName("Contracts")
                .setPropertyAnyName("SalePrice")
              ..value = (saleMaxController.text.isNotEmpty)
              ..searchType = (EnumFilterDataModelSearchTypes.lessThan)
              ..clauseType = (EnumClauseType.and));
          }
        } else {
          filter.addFilter(FilterDataModel()
              .setPropertyName("Contracts")
              .setPropertyAnyName("SalePriceByAgreement")
            ..value = (true)
            ..searchType = (EnumFilterDataModelSearchTypes.equal)
            ..clauseType = (EnumClauseType.and));
        }
      }
      if (selectedContractModel?.hasDepositPrice ?? false) {
        if (!depositPriceAgreement) {
          //for contract Type2
          if (depositMinController.text.isNotEmpty) {
            filter.addFilter(FilterDataModel()
                .setPropertyName("Contracts")
                .setPropertyAnyName("DepositPrice")
              ..value = (depositMinController.text.isNotEmpty)
              ..searchType = (EnumFilterDataModelSearchTypes.greaterThan)
              ..clauseType = (EnumClauseType.and));
          }
          if (depositMaxController.text.isNotEmpty) {
            filter.addFilter(FilterDataModel()
                .setPropertyName("Contracts")
                .setPropertyAnyName("DepositPrice")
              ..value = (depositMaxController.text.isNotEmpty)
              ..searchType = (EnumFilterDataModelSearchTypes.lessThan)
              ..clauseType = (EnumClauseType.and));
          }
        } else {
          filter.addFilter(FilterDataModel()
              .setPropertyName("Contracts")
              .setPropertyAnyName("DepositPriceByAgreement")
            ..value = (true)
            ..searchType = (EnumFilterDataModelSearchTypes.equal)
            ..clauseType = (EnumClauseType.and));
        }
      }
    }

    //for area filter
    if (area.min != null) {
      filter.addFilter(FilterDataModel().setPropertyName("Area")
        ..value = (area.min)
        ..searchType = (EnumFilterDataModelSearchTypes.greaterThan)
        ..clauseType = (EnumClauseType.and));
    }
    if (area.max != null) {
      filter.addFilter(FilterDataModel().setPropertyName("Area")
        ..value = (area.max)
        ..searchType = (EnumFilterDataModelSearchTypes.lessThan)
        ..clauseType = (EnumClauseType.and));
    }
    //for created year
    //for area filter
    if (createdYear.min != null) {
      filter.addFilter(FilterDataModel().setPropertyName("createdYaer")
        ..value = (createdYear.min)
        ..searchType = (EnumFilterDataModelSearchTypes.greaterThan)
        ..clauseType = (EnumClauseType.and));
    }
    if (createdYear.max != null) {
      filter.addFilter(FilterDataModel().setPropertyName("createdYaer")
        ..value = (createdYear.max)
        ..searchType = (EnumFilterDataModelSearchTypes.lessThan)
        ..clauseType = (EnumClauseType.and));
    }
    if (partition.min != null) {
      filter.addFilter(FilterDataModel().setPropertyName("Partition")
        ..value = (partition.min)
        ..searchType = (EnumFilterDataModelSearchTypes.greaterThan)
        ..clauseType = (EnumClauseType.and));
    }
    if (partition.max != null) {
      filter.addFilter(FilterDataModel().setPropertyName("Partition")
        ..value = (partition.max)
        ..searchType = (EnumFilterDataModelSearchTypes.lessThan)
        ..clauseType = (EnumClauseType.and));
    }
    if (propertydetailGroups != null) {
      FilterDataModel details = FilterDataModel();
      for (int i = 0; i < ((propertydetailGroups?.length) ?? 0); i++) {
        for (EstatePropertyDetailModel t
            in (propertydetailGroups?.elementAt(i).propertyDetails ?? [])) {
          if (t.value != null &&
              !t.value.equals("") &&
              !t.value.equals("false")) {
            FilterDataModel detailFilterModels = FilterDataModel();
            FilterDataModel f1 = FilterDataModel()
                .setPropertyName("PropertyDetailValues")
                .setPropertyAnyName("LinkPropertyDetailId")
              ..value = (t.id)
              ..clauseType = (EnumClauseType.and);
            FilterDataModel f2 = FilterDataModel()
                .setPropertyName("PropertyDetailValues")
                .setPropertyAnyName("Value")
              ..value = (t.value)
              ..clauseType = (EnumClauseType.and);
            detailFilterModels.addInnerFilter(f1).addInnerFilter(f2);
            details.addInnerFilter(detailFilterModels);
          }
        }
      }
      filter.addFilter(details);
    }
    BaseController().newPage(
      context: context,
      newWidget: (c) => EstateListScreen.withFilterScreen(filter: filter),
    );
  }
}

class SearchData {
  late List<EstatePropertyTypeModel> propertyTypeList;
  late List<EstatePropertyTypeUsageModel> typeUsagesList;
  late List<EstatePropertyTypeLanduseModel> landUsesList;

  late List<EstateContractTypeModel> contractsList;
}
