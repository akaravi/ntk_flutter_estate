import 'dart:io';
import 'package:latlong2/latlong.dart';
import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_4.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ntk_flutter_estate/screen/add/user_location_on_map_screen.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';

class NewEstateController {
  EstatePropertyModel item;
  late CoreCurrencyModel selectedCurrency;
  ImageUpload? mainImage;
  List<ImageUpload> otherImage = [];
  EstateContractTypeModel? selectedContractModel;
  TextEditingController areaController = TextEditingController();
  TextEditingController createdYearController = TextEditingController();
  TextEditingController partitionController = TextEditingController();
  TextEditingController codeTextWidget = TextEditingController();
  TextEditingController titleTextWidget = TextEditingController();
  TextEditingController descTextWidget = TextEditingController();
  TextEditingController locationTextController = TextEditingController();
  TextEditingController addressTextWidget = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController rentPriceController = TextEditingController();
  TextEditingController depositPriceController = TextEditingController();
  TextEditingController periodPriceController = TextEditingController();
  bool salePriceAgreement = false;
  bool rentPriceAgreement = false;
  bool depositPriceAgreement = false;
  bool periodPriceAgreement = false;

  static start(BuildContext context) {
    Future.microtask(() => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NewEstateScreen())));
  }

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
        return sub5Validation(context);
    }
    return true;
  }

  createModel(BuildContext context) async {
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
    var errorException = await EstatePropertyService().add(item);
    SubLoadingScreen.dismiss(context);
    if (errorException.isSuccess) {
      Navigator.of(context).pop();
    } else {
      toast(context, errorException.errorMessage ?? GlobalString.error);
    }
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

  bool sub1Validation(BuildContext context) {
    if (item.propertyTypeUsage == null) {
      toast(context, GlobalString.insertTypeUsage);
      return false;
    }
    if (item.propertyTypeLanduse == null) {
      toast(context, GlobalString.insertTypeUse);
      return false;
    }
    if (areaController.text.isEmpty) {
      toast(context, GlobalString.insertArea);
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

  bool sub3Validation(BuildContext context) {
    if (titleTextWidget.text.isEmpty) {
      toast(context, GlobalString.plzInsertTitle);
      return false;
    }
    if (descTextWidget.text.isEmpty) {
      toast(context, GlobalString.insertDesc);
      return false;
    }
    if (addressTextWidget.text.isEmpty) {
      toast(context, GlobalString.insertDesc);
      return false;
    }
    if (item.linkLocationId == null) {
      toast(context, GlobalString.insertLocation);
      return false;
    }
    item.title=titleTextWidget.text;
    item.description=descTextWidget.text;
    item.address=addressTextWidget.text;
    return true;
  }

  bool sub4Validation(BuildContext context) {
    if ((item.contracts ?? []).isEmpty) {
      toast(context, GlobalString.plzInsertContract);
      return false;
    }
    return true;
  }

  bool sub5Validation(BuildContext context) {
    return true;
  }

  void toast(BuildContext c, String detail) {
    MotionToast.error(description: Text(detail)).show(c);
  }

  bool addToContracts(BuildContext context) {
    EstateContractModel contract = EstateContractModel()
      ..contractType = selectedContractModel
      ..linkEstateContractTypeId = selectedContractModel?.id
      ..salePriceByAgreement = salePriceAgreement
      ..rentPriceByAgreement = rentPriceAgreement
      ..depositPriceByAgreement = depositPriceAgreement
      ..periodPriceByAgreement = periodPriceAgreement;
    if ((selectedContractModel?.hasSalePrice ?? false) ||
        (selectedContractModel?.salePriceAllowAgreement ?? false)) {
      //add price
      if (!salePriceAgreement) {
        //price is empty
        if (salePriceController.text.isEmpty) {
          toast(
            context,
            "${selectedContractModel?.titleSalePriceML ?? ""} ${GlobalString.plzInsertNum}",
          );
          return false;
        } else {
          contract.salePrice = int.parse(salePriceController.text
              .replaceAll(ThousandsSeparatorInputFormatter.separator, ""));
        }
      }
    }
    //rent
    if ((selectedContractModel?.hasRentPrice ?? false) ||
        (selectedContractModel?.rentPriceAllowAgreement ?? false)) {
      //add price
      if (!rentPriceAgreement) {
        //price is empty
        if (rentPriceController.text.isEmpty) {
          toast(
            context,
            "${selectedContractModel?.titleRentPriceML ?? ""} ${GlobalString.plzInsertNum}",
          );
          return false;
        } else {
          contract.rentPrice = int.parse(rentPriceController.text
              .replaceAll(ThousandsSeparatorInputFormatter.separator, ""));
        }
      }
    }
    //deposit
    if ((selectedContractModel?.hasDepositPrice ?? false) ||
        (selectedContractModel?.depositPriceAllowAgreement ?? false)) {
      //add price
      if (!depositPriceAgreement) {
        //price is empty
        if (depositPriceController.text.isEmpty) {
          toast(
            context,
            "${selectedContractModel?.titleDepositPriceML ?? ""} ${GlobalString.plzInsertNum}",
          );
          return false;
        } else {
          contract.depositPrice = int.parse(depositPriceController.text
              .replaceAll(ThousandsSeparatorInputFormatter.separator, ""));
        }
      }
    }
    //Period
    if ((selectedContractModel?.hasPeriodPrice ?? false) ||
        (selectedContractModel?.periodPriceAllowAgreement ?? false)) {
      //add price
      if (!periodPriceAgreement) {
        //price is empty
        if (periodPriceController.text.isEmpty) {
          toast(
            context,
            "${selectedContractModel?.titlePeriodPriceML ?? ""} ${GlobalString.plzInsertNum}",
          );
          return false;
        } else {
          contract.depositPrice = int.parse(periodPriceController.text
              .replaceAll(ThousandsSeparatorInputFormatter.separator, ""));
        }
      }
    }
    item.contracts ??= [];
    item.contracts?.add(contract);
    return true;
  }

  Future<bool> uploadMainImage(
      {required BuildContext context, required File file}) async {
    FileUploadModel? res = await FileUploadService().upload(file);
    if (res == null) {
      toast(context, GlobalString.errorInUpload);
      return false;
    }
    mainImage = ImageUpload(file.path, res.fileKey ?? "0", false);
    return true;
  }

  Future<bool> uploadOtherImage(
      {required BuildContext context, required File file}) async {
    if (otherImage
        .where((element) => element.path == file.path)
        .toList()
        .isNotEmpty) {
      toast(context, GlobalString.duplicateFileUpload);
      return false;
    }
    FileUploadModel? res = await FileUploadService().upload(file);
    if (res == null) {
      toast(context, GlobalString.errorInUpload);
      return false;
    }
    otherImage.add(ImageUpload(file.path, res.fileKey ?? "0", false));
    return true;
  }

  Future<bool> selectLocation(BuildContext context) async {
    LatLng? latLng = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LiveLocationPage()));
    if (latLng != null) {
      item.geolocationlatitude = latLng.latitude;
      item.geolocationlongitude = latLng.longitude;
      return true;
    }
    return false;
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

class ImageUpload {
  String path;
  String guId;
  bool isFromWeb = false;

  ImageUpload(this.path, this.guId, this.isFromWeb);
}
