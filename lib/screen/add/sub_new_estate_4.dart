import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:ntk_flutter_estate/widget/wrap_widget_model.dart';

import '../../controller/new_estate_controller.dart';
import '../sub_loading_screen.dart';

class SubNewEstate4 extends SubNewEstateBase {
  SubNewEstate4({Key? key, required NewEstateController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewEstate4> createState() => _Container1State();
  bool salePriceAgreement = false;
  bool rentPriceAgreement = false;
  bool depositPriceAgreement = false;
  bool periodPriceAgreement = false;
}

class _Container1State extends State<SubNewEstate4> {
  @override
  Widget build(BuildContext context) {
    if (widget.screenWidth == -1) {
      widget.screenWidth = MediaQuery.of(context).size.width;
    }
    return FutureBuilder<Sub4Data>(
        future: widget.controller.subFourLoad(),
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
                    title: GlobalString.location,
                    widget: DropdownButton<CoreCurrencyModel>(
                      items: (snapshot.data?.currencyList ?? [])
                          .map((e) => DropdownMenuItem<CoreCurrencyModel>(
                              value: e,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                ],
              ),
              //card contract list
              widget.card(children: [Text("for next")]),
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
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: hintPriceMl,
              border: const OutlineInputBorder(),
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
            const Text(
              GlobalString.agreementSale,
              style: TextStyle(fontSize: 17.0),
            ),
            Checkbox(
              value: value,
              onChanged: (val) {
                value = val!;
                setState(() {});
              },
            )
          ],
        )
      ],
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
