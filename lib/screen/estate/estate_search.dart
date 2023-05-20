import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/search_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_4.dart';
import 'package:ntk_flutter_estate/widget/checkbox_widget.dart';
import 'package:ntk_flutter_estate/widget/location_model_selector_widget.dart';
import 'package:ntk_flutter_estate/widget/property_detail_selector_widget.dart';
import 'package:ntk_flutter_estate/widget/wrap_widget_model.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';

class EstateSearchScreen extends StatelessWidget {
  SearchController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            GlobalString.back,
            style: TextStyle(color: GlobalColor.colorAccent),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: GlobalColor.colorAccent),
            onPressed: () => BaseController().close(context),
          ),
        ),
        body: Container(
            color: GlobalColor.colorSemiBackground,
            child: FutureBuilder<SearchData>(
                future: controller.getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MyHomePage(
                        controller, snapshot.data ?? SearchData());
                  }
                  return SubLoadingScreen();
                })));
  }
}

class MyHomePage extends StatefulWidget with Sub {
  SearchController controller;
  SearchData data;

  double screenWidth = -1;

  MyHomePage(this.controller, this.data);

  @override
  State createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.screenWidth == -1) {
      widget.screenWidth = MediaQuery.of(context).size.width;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              divider(),
              //search card
              searchCard(
                  title: GlobalString.keywords,
                  //search edittext
                  expandedWidget: TextField(
                    controller: widget.controller.textController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: GlobalColor.colorPrimary, width: 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: GlobalColor.colorPrimary, width: 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: GlobalString.title,
                        labelStyle: TextStyle(
                          color: GlobalColor.colorAccent,
                        )),
                  )),
              //some space
              divider(),
              //location Card
              searchCard(
                  isFilled: true,
                  title: GlobalString.location,
                  expandedWidget: Row(
                    children: [
                      Expanded(
                        child: widget.box(
                          title: GlobalString.location,
                          widget: (widget.controller.locationTitles.isNotEmpty)
                              ? Wrap(runSpacing: 10, spacing: 12, children: [
                                  ...(widget.controller.locationTitles)
                                      .map((e) => locationWidget(e))
                                      .toList()
                                ])
                              : const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(GlobalString.noContractsAdd),
                                ),
                        ),
                      ),
                      //add button
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: InkWell(
                          child: Material(
                            elevation: 12,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: GlobalColor.colorAccent, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.add_location_alt,
                                size: 24,
                                color: GlobalColor.colorAccent,
                              ),
                            ),
                          ),
                          onTap: () async {
                            CoreLocationModel? model =
                                await LocationModelSelectorDialog()
                                    .show(context);
                            if (model != null) {
                              widget.controller.locationTitles ??= [];
                              widget.controller.linkLocationIds ??= [];
                              if (!(widget.controller.linkLocationIds ?? [])
                                  .contains(model.id)) {
                                widget.controller.locationTitles
                                    .add(model.title ?? "");
                                widget.controller.linkLocationIds
                                    .add(model.id ?? 0);
                                setState(() {});
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  )),
              //some space
              divider(),
              //contract type card
              searchCard(
                  title: GlobalString.contractType,
                  expandedWidget: WrapWidgetModel<EstateContractTypeModel>(
                      models: widget.data.contractsList ?? [],
                      titleModelMethod: (item) => item.title ?? "",
                      selectMethod: (item) {
                        widget.controller.selectedContractModel = item;
                        setState(() {});
                      })),
              //some sapce
              divider(),
              if (widget.controller.selectedContractModel != null)
                ...contractsProperties(widget.data),

              //propertyTypeUsages card
              searchCard(
                  title: GlobalString.estateTypeUsage,
                  expandedWidget: WrapWidgetModel<EstatePropertyTypeUsageModel>(
                    selectMethod: (item) {
                      widget.controller.propertyTypeUsage = item;
                      widget.controller.propertyTypeLanduse = null;
                      setState(() {});
                    },
                    models: widget.data.typeUsagesList ?? [],
                    titleModelMethod: (item) => item.title ?? "",
                  )),
              //some space
              divider(),
              //property type usage if selected
              if (widget.controller.propertyTypeUsage != null) ...[
                searchCard(
                    title: GlobalString.estateType,
                    expandedWidget:
                        WrapWidgetModel<EstatePropertyTypeLanduseModel>(
                      selectMethod: (item) {
                        setState(() {
                          widget.controller.propertyTypeLanduse = item;
                        });
                      },
                      models: widget.controller.usageList(widget.data),
                      titleModelMethod: (item) => item.title ?? "",
                    )),
                divider()
              ],
              //area partition...
              if (widget.controller.propertyTypeUsage != null) ...[
                searchCard(
                    title: GlobalString.estateTypeUsageProperties,
                    expandedWidget: Column(children: [
                      if (widget.controller.propertyTypeUsage != null) ...[
                        widget.fromToTextFieldBoxWidget(
                          context: context,
                          title: GlobalString.areaAsMeter,
                          changeState: () {
                            setState(() {});
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                          minMax: widget.controller.area,
                        ),
                        //created year
                        if ((widget.controller.propertyTypeLanduse
                                        ?.titleCreatedYaer ??
                                    "")
                                .isNotEmpty &&
                            (widget.controller.propertyTypeLanduse
                                        ?.titleCreatedYaer ??
                                    "") !=
                                ("---"))
                          widget.fromToTextFieldBoxWidget(
                              context: context,
                              title: widget.controller.propertyTypeLanduse
                                      ?.titleCreatedYaer ??
                                  "",
                              changeState: () {
                                setState(() {});
                              },
                              keyboardType: TextInputType.number,
                              minMax: widget.controller.createdYear),
                        //created year
                        if ((widget.controller.propertyTypeLanduse
                                        ?.titlePartition ??
                                    "")
                                .isNotEmpty &&
                            (widget.controller.propertyTypeLanduse
                                        ?.titlePartition ??
                                    "") !=
                                ("---"))
                          widget.fromToTextFieldBoxWidget(
                              context: context,
                              title: widget.controller.propertyTypeLanduse
                                      ?.titlePartition ??
                                  "",
                              changeState: () {
                                setState(() {});
                              },
                              keyboardType: TextInputType.number,
                              minMax: widget.controller.partition)
                      ],
                    ])),
                divider()
              ],
              //add property detail group
              if (widget.controller.propertyTypeUsage != null &&
                  widget.controller.propertydetailGroups == null)
                FutureBuilder<List<EstatePropertyDetailGroupModel>>(
                    future: widget.controller.getproperties(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                            children: (snapshot.data ?? [])
                                .map((e) => Column(
                                      children: [
                                        widget.card(children: [
                                          searchCard(
                                              title: e.title ?? "",
                                              expandedWidget: Wrap(
                                                children: ((e.propertyDetails ??
                                                        [])
                                                    .map((t) =>
                                                        PropertyDetailSelector()
                                                            .viewHolder(context,
                                                                t))).toList(),
                                              )),
                                        ]),
                                        divider(),
                                      ],
                                    ))
                                .toList());
                      }
                      return Container();
                    }),

              divider(),

              divider()
            ],
          ),
          Positioned(
              bottom: 5,
              left: 5,
              right: 5,
              child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 10,
                    backgroundColor: GlobalColor.colorPrimary),
                onPressed: () => widget.controller.search(context),
                child: const Text(GlobalString.searchResult,
                    style: TextStyle(
                        color: GlobalColor.colorTextOnPrimary, fontSize: 16)),
              ))
        ],
      ),
    );
  }

  searchCard(
      {required String title, required expandedWidget, bool isFilled = false}) {
    return Material(
      elevation: 15,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Expandable(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        firstChild: colapsedText("$title :"),
        secondChild: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: GlobalColor.colorBackground,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16))),
          child: Padding(
            padding: isFilled
                ? EdgeInsets.all(0)
                : const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: expandedWidget,
          ),
        ),
        backgroundColor: GlobalColor.colorPrimary,
        arrowWidget: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: GlobalColor.colorAccent,
            size: 20.0,
          ),
        ),
      ),
    );
  }

  colapsedText(String title) {
    return Expanded(
        child: Container(
            child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Text(title, style: TextStyle(color: GlobalColor.colorAccent)),
    )));
  }

  divider() {
    return const SizedBox(
      height: 18,
    );
  }

  List<Widget> contractsProperties(SearchData data) {
    List<Widget> children = [
      //sale price
      if (widget.controller.selectedContractModel?.hasSalePrice ?? false)
        rowContract(
            hintPriceMl:
                widget.controller.selectedContractModel?.titleSalePrice ?? "",
            maxTextController: widget.controller.saleMaxController,
            minTextController: widget.controller.saleMinController,
            value: widget.controller.salePriceAgreement,
            clickListener: () => widget.controller.salePriceAgreement =
                !widget.controller.salePriceAgreement,
            allowAgreement: widget.controller.selectedContractModel
                    ?.salePriceAllowAgreement ??
                false),
      //rent price
      if (widget.controller.selectedContractModel?.hasRentPrice ?? false)
        rowContract(
            hintPriceMl:
                widget.controller.selectedContractModel?.titleRentPrice ?? "",
            value: widget.controller.rentPriceAgreement,
            clickListener: () => widget.controller.rentPriceAgreement =
                !widget.controller.rentPriceAgreement,
            maxTextController: widget.controller.rentMaxController,
            minTextController: widget.controller.rentMinController,
            allowAgreement: widget.controller.selectedContractModel
                    ?.rentPriceAllowAgreement ??
                false),
      //deposit price
      if (widget.controller.selectedContractModel?.hasDepositPrice ?? false)
        rowContract(
            hintPriceMl:
                widget.controller.selectedContractModel?.titleDepositPrice ??
                    "",
            value: widget.controller.depositPriceAgreement,
            maxTextController: widget.controller.depositMaxController,
            minTextController: widget.controller.depositMinController,
            clickListener: () => widget.controller.depositPriceAgreement =
                !widget.controller.depositPriceAgreement,
            allowAgreement: widget.controller.selectedContractModel
                    ?.depositPriceAllowAgreement ??
                false),
      //period price
      if (widget.controller.selectedContractModel != null)
        if (widget.controller.selectedContractModel?.hasPeriodPrice ?? false)
          rowContract(
              hintPriceMl:
                  widget.controller.selectedContractModel?.titlePeriodPrice ??
                      "",
              value: widget.controller.periodPriceAgreement,
              clickListener: () => widget.controller.periodPriceAgreement =
                  !widget.controller.periodPriceAgreement,
              maxTextController: widget.controller.periodMaxController,
              minTextController: widget.controller.periodMinController,
              allowAgreement: widget.controller.selectedContractModel
                      ?.periodPriceAllowAgreement ??
                  false),
    ];
    if (children.length > 0) {
      return [
        searchCard(
            isFilled: true,
            title: GlobalString.contractProperties,
            expandedWidget: Column(
              children: children,
            )),
        divider()
      ];
    } else {
      return [
        Container(
          width: 1,
        )
      ];
    }
  }

  Widget rowContract(
      {required String hintPriceMl,
      required TextEditingController maxTextController,
      required TextEditingController minTextController,
      required bool allowAgreement,
      required Function() clickListener,
      required bool value}) {
    TextEditingController _txt = TextEditingController();
    if (minTextController.text.trim().isNotEmpty) {
      _txt.text = GlobalString.from +
          widget.priceFormat(
              int.tryParse(minTextController.text.toString()) ?? 0);
    }
    if (maxTextController.text.trim().isNotEmpty) {
      _txt.text = _txt.text +
          GlobalString.to +
          widget.priceFormat(
              int.tryParse(maxTextController.text.toString()) ?? 0);
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 6),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: GlobalColor.colorAccent.withOpacity(.3),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            SizedBox(
              width: (2 * widget.screenWidth / 5),
              child: TextField(
                readOnly: true,
                controller: _txt,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(3),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: hintPriceMl,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [ThousandsSeparatorInputFormatter()],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            CheckInk(
                clickListener: () {
                  setState(() {
                    clickListener();
                  });
                },
                widget: Check(
                  title: GlobalString.agreement,
                  checked: value,
                )),
          ]),
        ));
  }

  Widget locationWidget(String e) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: GlobalColor.colorBackground,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: GlobalColor.colorAccent)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(e,
              style: const TextStyle(
                  color: GlobalColor.colorPrimary, fontSize: 14)),
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 8),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(color: GlobalColor.colorError, width: 1),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.delete_forever,
                  size: 13,
                  color: GlobalColor.colorError,
                ),
              ),
              onTap: () {
                setState(() {
                  int? index = widget.controller.locationTitles.indexOf(e);
                  widget.controller.locationTitles.remove(e);
                  widget.controller.linkLocationIds.removeAt(index ?? 0);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
