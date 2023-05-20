import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/new_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';
import 'package:ntk_flutter_estate/widget/checkbox_widget.dart';
import 'package:ntk_flutter_estate/widget/wrap_widget_model.dart';
import 'package:intl/intl.dart';
import '../../controller/new_estate_controller.dart';

class SubNewEstate4 extends SubNewEstateBase {
  SubNewEstate4({Key? key, required NewEstateController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewEstate4> createState() => _Container1State();
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
                          titleModelMethod: (item) => item.title ?? "",
                          isSelected: (p0) =>
                              p0.id ==
                              widget.controller.selectedContractModel?.id,
                          selectMethod: (item) {
                            widget.controller.selectedContractModel = item;
                            setState(() {});
                          })),
                  widget.box(
                    verticalPadding: 0,
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
                          textController: widget.controller.salePriceController,
                          value: widget.controller.salePriceAgreement,
                          clickListener: () =>
                              widget.controller.salePriceAgreement =
                                  !widget.controller.salePriceAgreement,
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
                          value: widget.controller.rentPriceAgreement,
                          clickListener: () =>
                              widget.controller.rentPriceAgreement =
                                  !widget.controller.rentPriceAgreement,
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
                          value: widget.controller.depositPriceAgreement,
                          clickListener: () =>
                              widget.controller.depositPriceAgreement =
                                  !widget.controller.depositPriceAgreement,
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
                          textController:
                              widget.controller.periodPriceController,
                          value: widget.controller.periodPriceAgreement,
                          clickListener: () =>
                              widget.controller.periodPriceAgreement =
                                  !widget.controller.periodPriceAgreement,
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
                        var isAdded = widget.controller.addToContracts(context);
                        if (isAdded) {
                          setState(() {});
                        }
                      },
                      child: const Text(GlobalString.addToContract,
                          style: TextStyle(
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
          return SizedBox(
              width: GlobalData.screenWidth,
              height: GlobalData.screenHeight,
              child: const SubLoadingScreen());
        });
  }

  Widget rowContract(
      {required String hintPriceMl,
      required bool allowAgreement,
      required TextEditingController textController,
      required Function() clickListener,
      required bool value}) {
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
                controller: textController,
                style: TextStyle(fontSize: 13),
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
          ],
        ),
      ),
    );
  }

  Widget contractWidget(EstateContractModel e) {
    return Row(
      children: [
        Container(
          color: GlobalColor.colorPrimary,
          child: RotatedBox(
            quarterTurns: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(e.contractType?.titleML ?? "",
                  style: const TextStyle(
                      color: GlobalColor.colorTextOnPrimary, fontSize: 15)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (e.contractType?.hasSalePrice ?? false)
                  Text.rich(
                    TextSpan(
                        text: "${e.contractType?.titleSalePriceML ?? ""} : ",
                        children: [
                          if (e.salePrice != null && e.salePrice != 0)
                            TextSpan(
                              text: ThousandsSeparatorString.stringValue(
                                  e.salePrice?.toInt() ?? 0),
                            ),
                          if (e.salePrice != null &&
                              e.salePrice != 0 &&
                              (e.salePriceByAgreement ?? false))
                            const WidgetSpan(
                              child: Icon(Icons.numbers_rounded),
                            ),
                          if (e.salePriceByAgreement ?? false)
                            TextSpan(text: GlobalString.agreement)
                        ]),
                  ),
                if (e.contractType?.hasRentPrice ?? false)
                  Text.rich(
                    TextSpan(
                        text: "${e.contractType?.titleRentPriceML ?? ""} : ",
                        children: [
                          if (e.rentPrice != null && e.rentPrice != 0)
                            TextSpan(
                                text: ThousandsSeparatorString.stringValue(
                                    e.rentPrice?.toInt() ?? 0)),
                          if (e.rentPrice != null &&
                              e.rentPrice != 0 &&
                              (e.rentPriceByAgreement ?? false))
                            const WidgetSpan(
                              child: Icon(Icons.numbers_rounded),
                            ),
                          if (e.rentPriceByAgreement ?? false)
                            TextSpan(text: GlobalString.agreement)
                        ]),
                  ),
                if (e.contractType?.hasDepositPrice ?? false)
                  Text.rich(
                    TextSpan(
                        text: "${e.contractType?.titleDepositPriceML ?? ""} : ",
                        children: [
                          if (e.depositPrice != null && e.depositPrice != 0)
                            TextSpan(
                                text: ThousandsSeparatorString.stringValue(
                                    e.depositPrice?.toInt() ?? 0)),
                          if (e.depositPrice != null &&
                              e.depositPrice != 0 &&
                              (e.depositPriceByAgreement ?? false))
                            const WidgetSpan(
                              child: Icon(Icons.numbers_rounded),
                            ),
                          if (e.depositPriceByAgreement ?? false)
                            TextSpan(text: GlobalString.agreement)
                        ]),
                  ),
                if (e.contractType?.hasPeriodPrice ?? false)
                  Text.rich(
                    TextSpan(
                        text: "${e.contractType?.titlePeriodPriceML ?? ""} : ",
                        children: [
                          if (e.periodPrice != null && e.periodPrice != 0)
                            TextSpan(
                                text: ThousandsSeparatorString.stringValue(
                                    e.periodPrice?.toInt() ?? 0)),
                          if (e.periodPrice != null &&
                              e.periodPrice != 0 &&
                              (e.periodPriceByAgreement ?? false))
                            const WidgetSpan(
                              child: Icon(Icons.numbers_rounded),
                            ),
                          if (e.salePriceByAgreement ?? false)
                            TextSpan(text: GlobalString.agreement)
                        ]),
                  )
              ],
            ),
          ),
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: InkWell(
            child: Material(
              elevation: 12,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: GlobalColor.colorError, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.delete_forever,
                  size: 24,
                  color: GlobalColor.colorError,
                ),
              ),
            ),
            onTap: () {
              setState(() {
                widget.controller.item.contracts?.remove(e);
              });
            },
          ),
        ),
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

class ThousandsSeparatorString {
  static String stringValue(int val) {
    var formatter = NumberFormat("###,###,###,###,###,###");
    return formatter.format(val);
  }
}
