import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/search_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_4.dart';
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
      child: ListView(
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
                      borderSide:
                          BorderSide(color: GlobalColor.colorPrimary, width: 1),
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
              title: GlobalString.location,
              expandedWidget: Text(GlobalString.location)),
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
                expandedWidget: WrapWidgetModel<EstatePropertyTypeLanduseModel>(
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
          if (widget.controller.propertyTypeUsage != null) ...[
            searchCard(
                title: GlobalString.estateTypeUsageProperties,
                expandedWidget: Column(children: [
                  if (widget.controller.propertyTypeUsage != null) ...[
                    widget.textFieldBoxWidget(
                        title: GlobalString.areaAsMeter,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        textController: widget.controller.areaController),
                    //created year
                    if ((widget.controller.propertyTypeLanduse
                                    ?.titleCreatedYaer ??
                                "")
                            .isNotEmpty &&
                        (widget.controller.propertyTypeLanduse
                                    ?.titleCreatedYaer ??
                                "") !=
                            ("---"))
                      widget
                          .textFieldBoxWidget(
                              title: widget.controller.propertyTypeLanduse
                                      ?.titleCreatedYaer ??
                                  "",
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: false, decimal: false),
                              textController:
                                  widget.controller.createdYearController),
                    //created year
                    if ((widget.controller.propertyTypeLanduse
                                    ?.titlePartition ??
                                "")
                            .isNotEmpty &&
                        (widget.controller.propertyTypeLanduse
                                    ?.titlePartition ??
                                "") !=
                            ("---"))
                      widget.textFieldBoxWidget(
                          title: widget.controller.propertyTypeLanduse
                                  ?.titlePartition ??
                              "",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: false),
                          textController: widget.controller.partitionController)
                  ],
                ])),
            divider()
          ],
          //add property detail group
          if (widget.controller.propertyTypeUsage != null&&widget.controller.propertydetailGroups == null)
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
                                            children: ((e.propertyDetails ?? [])
                                                .map((t) => PropertyDetailSelector()
                                                    .viewHolder(t))).toList(),
                                          )),
                                    ]),    divider(),
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
    );
  }

  searchCard({required String title, required expandedWidget}) {
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
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
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
            value: widget.controller.salePriceAgreement,
            allowAgreement: widget.controller.selectedContractModel
                    ?.salePriceAllowAgreement ??
                false),
      //rent price
      if (widget.controller.selectedContractModel?.hasRentPrice ?? false)
        rowContract(
            hintPriceMl:
                widget.controller.selectedContractModel?.titleRentPrice ?? "",
            value: widget.controller.rentPriceAgreement,
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
              allowAgreement: widget.controller.selectedContractModel
                      ?.periodPriceAllowAgreement ??
                  false),
    ];
    if (children.length > 0) {
      return [
        searchCard(
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
      required bool allowAgreement,
      required bool value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: (2 * widget.screenWidth / 5),
            child: TextField(
              decoration: InputDecoration(
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
          Row(
            children: [
              Checkbox(
                value: value,
                onChanged: (val) {},
              ),
              const Text(
                GlobalString.agreementSale,
                style: TextStyle(fontSize: 17.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
