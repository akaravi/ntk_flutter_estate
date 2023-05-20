import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ntk_flutter_estate/controller/new_customer_order_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_4.dart';
import 'package:ntk_flutter_estate/screen/customer_order/sub_new_customer_order_1.dart';
import 'package:ntk_flutter_estate/widget/wrap_widget_model.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';

import '../../controller/new_estate_controller.dart';

class SubNewCustomerOrder3 extends SubNewCustomerOrderBase {
  SubNewCustomerOrder3(
      {Key? key, required NewCustomerOrderController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewCustomerOrder3> createState() => _Container1State();
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
                          titleModelMethod: (item) => item.title ?? "",
                          isSelected: (p0) =>
                              p0.id ==
                              widget.controller.selectedContractModel?.id,
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
                  const SizedBox(
                    height: 6,
                  ),
                  //sale price
                  if (widget.controller.selectedContractModel != null)
                    if (widget.controller.selectedContractModel?.hasSalePrice ??
                        false)
                      rowContract(
                        hintPriceMl: widget.controller.selectedContractModel
                                ?.titleSalePrice ??
                            "",
                        maxTextController:
                            widget.controller.maxSalePriceController,
                        minTextController:
                            widget.controller.minSalePriceController,
                      ),
                  //rent price
                  if (widget.controller.selectedContractModel != null)
                    if (widget.controller.selectedContractModel?.hasRentPrice ??
                        false)
                      rowContract(
                        hintPriceMl: widget.controller.selectedContractModel
                                ?.titleRentPrice ??
                            "",
                        maxTextController:
                            widget.controller.maxRentPriceController,
                        minTextController:
                            widget.controller.minRentPriceController,
                      ),
                  //deposit price
                  if (widget.controller.selectedContractModel != null)
                    if (widget.controller.selectedContractModel
                            ?.hasDepositPrice ??
                        false)
                      rowContract(
                        hintPriceMl: widget.controller.selectedContractModel
                                ?.titleDepositPrice ??
                            "",
                        maxTextController:
                            widget.controller.maxDepositPriceController,
                        minTextController:
                            widget.controller.minDepositPriceController,
                      ),
                  //period price
                  if (widget.controller.selectedContractModel != null)
                    if (widget
                            .controller.selectedContractModel?.hasPeriodPrice ??
                        false)
                      rowContract(
                        hintPriceMl: widget.controller.selectedContractModel
                                ?.titlePeriodPrice ??
                            "",
                        maxTextController:
                            widget.controller.maxPeriodPriceController,
                        minTextController:
                            widget.controller.minPeriodPriceController,
                      ),
                ],
              ),
            ]);
          }
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const SubLoadingScreen());
        });
  }

  Widget rowContract({
    required String hintPriceMl,
    required TextEditingController minTextController,
    required TextEditingController maxTextController,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 6),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: GlobalColor.colorAccent.withOpacity(.3),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: (2 * widget.screenWidth / 5),
              child: TextField(
                controller: minTextController,
                style: TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(3),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: "${GlobalString.min} $hintPriceMl",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [ThousandsSeparatorInputFormatter()],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: (2 * widget.screenWidth / 5),
              child: TextField(
                controller: maxTextController,
                style: TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(3),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: "${GlobalString.max} $hintPriceMl",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [ThousandsSeparatorInputFormatter()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
