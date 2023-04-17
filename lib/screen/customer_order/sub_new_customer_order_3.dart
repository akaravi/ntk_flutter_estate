import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ntk_flutter_estate/controller/new_customer_order_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_4.dart';
import 'package:ntk_flutter_estate/screen/customer_order/sub_new_customer_order_1.dart';
import 'package:ntk_flutter_estate/widget/wrap_widget_model.dart';

import '../../controller/new_estate_controller.dart';
import '../sub_loading_screen.dart';

class SubNewCustomerOrder3 extends SubNewCustomerOrderBase {
  SubNewCustomerOrder3(
      {Key? key, required NewCustomerOrderController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewCustomerOrder3> createState() => _Container1State();
  bool salePriceAgreement = false;
  bool rentPriceAgreement = false;
  bool depositPriceAgreement = false;
  bool periodPriceAgreement = false;
}

class _Container1State extends State<SubNewCustomerOrder3> {
  @override
  Widget build(BuildContext context) {
    if (widget.screenWidth == -1) {
      widget.screenWidth = MediaQuery.of(context).size.width;
    }
    return FutureBuilder<Sub3Data>(
        future: widget.controller.subThreeLoad(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(children: [
              //card select contract
              widget.card(
                children: [
                  //box select contract
                  widget.box(
                      title: GlobalString.contractType,
                      widget: WrapWidgetModel<EstateContractTypeModel>(
                          models: snapshot.data?.contractsList ?? [],
                          titleModelMethod: (item) => item?.title ?? "",
                          selectMethod: (item) {
                            widget.controller.selectedContractModel = item;
                            setState(() {});
                          })),
                  widget.box(
                    title: GlobalString.currency,
                    fitContainer: true,
                    widget: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButton<CoreCurrencyModel>(
                        isExpanded: true,
                        items: (snapshot.data?.currencyList ?? [])
                            .map((e) => DropdownMenuItem<CoreCurrencyModel>(
                                value: e,
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Text(
                                    e.title ?? "",
                                    style: const TextStyle(
                                        color: GlobalColor.colorPrimary,
                                        fontSize: 13),
                                  ),
                                )))
                            .toList(),
                        onChanged: (newVal) {
                          widget.controller.selectedCurrency =
                              newVal ?? CoreCurrencyModel();
                          setState(() {});
                        },
                        value: widget.controller.selectedCurrency,
                      ),
                    ),
                  ),
                  //sale price
                  if (widget.controller.selectedContractModel != null)
                    if (widget.controller.selectedContractModel?.hasSalePrice ??
                        false)
                      rowContract(
                          hintPriceMl: widget.controller.selectedContractModel
                                  ?.titleSalePrice ??
                              "",
                          textController: widget.controller.salePriceController,
                          value: widget.salePriceAgreement,
                          allowAgreement: widget
                                  .controller
                                  .selectedContractModel
                                  ?.salePriceAllowAgreement ??
                              false),
                  //rent price
                  if (widget.controller.selectedContractModel != null)
                    if (widget.controller.selectedContractModel?.hasRentPrice ??
                        false)
                      rowContract(
                          hintPriceMl: widget.controller.selectedContractModel
                                  ?.titleRentPrice ??
                              "",
                          textController: widget.controller.rentPriceController,
                          value: widget.rentPriceAgreement,
                          allowAgreement: widget
                                  .controller
                                  .selectedContractModel
                                  ?.rentPriceAllowAgreement ??
                              false),
                  //deposit price
                  if (widget.controller.selectedContractModel != null)
                    if (widget.controller.selectedContractModel
                            ?.hasDepositPrice ??
                        false)
                      rowContract(
                          hintPriceMl: widget.controller.selectedContractModel
                                  ?.titleDepositPrice ??
                              "",
                          textController:
                              widget.controller.depositPriceController,
                          value: widget.depositPriceAgreement,
                          allowAgreement: widget
                                  .controller
                                  .selectedContractModel
                                  ?.depositPriceAllowAgreement ??
                              false),
                  //period price
                  if (widget.controller.selectedContractModel != null)
                    if (widget
                            .controller.selectedContractModel?.hasPeriodPrice ??
                        false)
                      rowContract(
                          hintPriceMl: widget.controller.selectedContractModel
                                  ?.titlePeriodPrice ??
                              "",
                          textController: widget.controller.salePriceController,
                          value: widget.periodPriceAgreement,
                          allowAgreement: widget
                                  .controller
                                  .selectedContractModel
                                  ?.periodPriceAllowAgreement ??
                              false),
                  //add button
                  if (widget.controller.selectedContractModel != null)
                    TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          elevation: 10,
                          backgroundColor: GlobalColor.colorAccent),
                      onPressed: () {
                        //todo
                      },
                      child: Text(GlobalString.addToContract,
                          style: const TextStyle(
                              color: GlobalColor.colorTextOnPrimary,
                              fontSize: 16)),
                    ),
                ],
              ),
              //card contract list
              widget.card(children: [
                widget.box(
                    fitContainer: true,
                    title: GlobalString.contractsList,
                    widget: Column(
                      children: [
                        if (widget.controller.item.contracts != null)
                          ...(widget.controller.item.contracts ?? [])
                              .map((e) => contractWidget(e))
                              .toList()
                        else
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(GlobalString.noContractsAdd),
                          )
                      ],
                    ))
              ]),
            ]);
          }
          return SubLoadingScreen();
        });
  }

  Widget rowContract(
      {required String hintPriceMl,
      required bool allowAgreement,
      required TextEditingController textController,
      required bool value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: (2 * widget.screenWidth / 5),
            child: TextField(
              controller: textController,
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

  Widget contractWidget(EstateContractModel e) {
    return Text("");
  }
}
