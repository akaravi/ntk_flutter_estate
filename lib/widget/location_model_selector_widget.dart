import 'package:flutter/material.dart';
import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ntk_flutter_estate/global_data.dart';

class LocationModelSelectorDialog {
  show(BuildContext context) async {
    var locationController = _LocationController();
    return await showDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(40)),
                child: StatefulBuilder(
                    builder: (context, setState) => Container(
                        child:
                            _widget(context, setState, locationController)))),
          );
        });
  }

  // return await showGeneralDialog(
  //   context: context,
  //   barrierLabel: "Barrier",
  //   barrierDismissible: true,
  //   barrierColor: Colors.black.withOpacity(0.5),
  //   transitionDuration: const Duration(milliseconds: 700),
  //   pageBuilder: (_, __, ___) {
  //     return Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 20),
  //       decoration: BoxDecoration(
  //           color: Colors.transparent,
  //           borderRadius: BorderRadius.circular(40)),
  //       child: StatefulBuilder(
  //         builder: (context, setState) => Container(
  //             child: _widget(context, setState, locationController)),
  //       ),
  //     );
  //   },
  // transitionBuilder: (_, anim, __, child) {
  //   Tween<Offset> tween;
  //   if (anim.status == AnimationStatus.reverse) {
  //     tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
  //   } else {
  //     tween = Tween(begin: Offset(1, 0), end: Offset.zero);
  //   }
  //
  //   return SlideTransition(
  //     position: tween.animate(anim),
  //     child: FadeTransition(
  //       opacity: anim,
  //       child: child,
  //     ),
  //   );
  // },
  // );

  Widget _widget(BuildContext context, StateSetter setState,
      _LocationController controller) {
    const double verticalPadding = 16;
    const double horizontalPadding = 20;
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //country
          FutureBuilder<List<CoreLocationModel>>(
            future: controller.getAllCountry(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: verticalPadding,
                      bottom: verticalPadding / 2,
                      right: horizontalPadding,
                      left: horizontalPadding),
                  child: DropdownSearch<CoreLocationModel>(
                      dropdownBuilder: (context, selectedItem) =>  InputDecorator(
                          decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                        label: Text(
                          GlobalString.countryLoc,
                          style: TextStyle(
                              fontSize: 13, color: GlobalColor.colorAccent),
                        ),
                      )),
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                      ),
                      compareFn: (item1, item2) => item1.id==item2.id,
                      items: (filter, loadProps) => snapshot.data ?? [],
                      itemAsString: (item) => item.title ?? "",
                      onChanged: (newValue) {
                        controller.selectedCountry = newValue!;
                        controller.selectedProvince = null;
                        controller.selectedCity = null;
                        controller.selectedArea = null;
                        setState(() {});
                      }),
                );
              }
              return indicator();
            },
          ),
          //province
          if (controller.selectedCountry != null)
            FutureBuilder<List<CoreLocationModel>>(
              future: controller.getAllProvince(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: verticalPadding / 2,
                        bottom: verticalPadding / 2,
                        right: horizontalPadding,
                        left: horizontalPadding),
                    child: DropdownSearch<CoreLocationModel>(
                        selectedItem: controller.selectedProvince,decoratorProps:
                         const DropDownDecoratorProps(
                             decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          label: Text(
                            GlobalString.provinceLoc,
                            style: TextStyle(
                                fontSize: 13, color: GlobalColor.colorAccent),
                          ),
                        )),
                        popupProps: const PopupProps.menu(
                          showSearchBox: true,
                        ),
                        compareFn: (item1, item2) => item1.id==item2.id,
                        items: (filter, loadProps) => snapshot.data ?? [],
                        itemAsString: (item) => item.title ?? "",
                        onChanged: (newValue) {
                          controller.selectedProvince = newValue!;
                          controller.selectedCity = null;
                          controller.selectedArea = null;
                          setState(() {});
                        }),
                  );
                }
                return indicator();
              },
            ),
          //city
          if (controller.selectedProvince != null)
            FutureBuilder<List<CoreLocationModel>>(
              future: controller.getAllCity(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: verticalPadding / 2,
                        bottom: verticalPadding / 2,
                        right: horizontalPadding,
                        left: horizontalPadding),
                    child: DropdownSearch<CoreLocationModel>(   selectedItem: controller.selectedCity,
                        decoratorProps: const DropDownDecoratorProps(
                            decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          label: Text(
                            GlobalString.cityLoc,
                            style: TextStyle(
                                fontSize: 13, color: GlobalColor.colorAccent),
                          ),
                        )),
                        compareFn: (item1, item2) => item1.id==item2.id,
                        popupProps: const PopupProps.menu(
                          showSearchBox: true,
                        ),
                        items: (filter, loadProps) => snapshot.data ?? [],
                        itemAsString: (item) => item.title ?? "",
                        onChanged: (newValue) {
                          controller.selectedCity = newValue!;
                          controller.selectedArea = null;

                          setState(() {});
                        }),
                  );
                }
                return indicator();
              },
            ),
          //area
          if (controller.selectedCity != null)
            FutureBuilder<List<CoreLocationModel>>(
              future: controller.getAllArea(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: verticalPadding / 2,
                        bottom: verticalPadding / 2,
                        right: horizontalPadding,
                        left: horizontalPadding),
                    child: DropdownSearch<CoreLocationModel>(   selectedItem: controller.selectedArea,
                        decoratorProps: const DropDownDecoratorProps(
                            decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          label: Text(
                            GlobalString.areaLoc,
                            style: TextStyle(
                                fontSize: 13, color: GlobalColor.colorAccent),
                          ),
                        )),
                        popupProps: const PopupProps.menu(
                          showSearchBox: true,
                        ),
                        compareFn: (item1, item2) => item1.id==item2.id,
                        items: (filter, loadProps) => snapshot.data ?? [],
                        itemAsString: (item) => item.title ?? "",
                        onChanged: (newValue) {
                          controller.selectedCity = newValue!;
                          setState(() {});
                        }),
                  );
                }
                return indicator();
              },
            ),
          //error show
          if (controller.hasError)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(GlobalString.plzSelectLocation,
                  style: TextStyle(color: GlobalColor.colorError)),
            ),
          //buttons
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: verticalPadding, horizontal: horizontalPadding),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        elevation: 10,
                        backgroundColor: GlobalColor.colorAccent),
                    onPressed: () {
                      var selectedLoc = controller.sendLocation();
                      if (selectedLoc == null) {
                        controller.hasError = true;
                        setState(
                          () {},
                        );
                      } else {
                        Navigator.of(context).pop(selectedLoc);
                      }
                    },
                    child: const Text(GlobalString.confirmLocation,
                        style: TextStyle(
                            color: GlobalColor.colorTextOnPrimary,
                            fontSize: 16)),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                cancelButton(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  cancelButton(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 1.0, color: GlobalColor.colorPrimary),
          ),
          child: const Text(
            GlobalString.back,
            style: TextStyle(color: GlobalColor.colorPrimary),
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }

  Widget indicator() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: LinearProgressIndicator(
        backgroundColor: Colors.cyanAccent,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
      ),
    );
  }
}

class _LocationController {
  CoreLocationModel? selectedCountry;
  CoreLocationModel? selectedProvince;
  CoreLocationModel? selectedCity;
  CoreLocationModel? selectedArea;

  // late List<CoreLocationModel> countries;
  // late List<CoreLocationModel> provinces;
  // late List<CoreLocationModel> cities;
  //
  // late List<CoreLocationModel> areas;

  bool hasError = false;

  CoreLocationModel? sendLocation() {
    if (selectedArea != null) {
      return (selectedArea);
    } else if (selectedCity != null) {
      return (selectedCity);
    } else if (selectedProvince != null) {
      return (selectedProvince);
    } else if (selectedCountry != null) {
      return (selectedCountry);
    } else {
      return null;
    }
  }

  Future<List<CoreLocationModel>> getAllCountry() async {
    var list = await CoreLocationService()
        .getAllCountry(FilterModel()..rowPerPage = 500);
    return list;
  }

  Future<List<CoreLocationModel>> getAllProvince() async {
    var list = await CoreLocationService().getAllProvince(FilterModel()
      ..rowPerPage = 500
      ..addFilter(FilterDataModel()
        ..propertyName = 'LinkParentId'
        ..value = selectedCountry?.id));
    return list;
  }

  Future<List<CoreLocationModel>> getAllCity() async {
    var list = await CoreLocationService().getAll(FilterModel()
      ..rowPerPage = 500
      ..addFilter(FilterDataModel()
        ..propertyName = 'LinkParentId'
        ..value = selectedProvince?.id));
    return list;
  }

  Future<List<CoreLocationModel>> getAllArea() async {
    var list = await CoreLocationService().getAll(FilterModel()
      ..rowPerPage = 500
      ..addFilter(FilterDataModel()
        ..propertyName = 'LinkParentId'
        ..value = selectedCity?.id));
    return list;
  }
}
