import 'package:flutter/material.dart';
import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:intl/intl.dart';
import 'package:ntk_flutter_estate/global_data.dart';

class ContractWidget {
  List<Widget> getPriceWidget(EstatePropertyModel model, {bool? showAll}) {
    showAll ??= false;
    List<Widget> contracs = List.empty(growable: true);
    for (EstateContractModel m in model.contracts!) {
      if ((model.contracts?.length ?? 0) > 1) print(model.id);

      List<Widget> pricesColumn = List.empty(growable: true);

      if (m.contractType?.hasSalePrice ?? false) {
        if (m.salePrice != null || (m.salePriceByAgreement ?? false)) {
          String price = "";
          if (m.salePrice != null && m.salePrice != 0) {
            price = priceFormat(m.salePrice?.toInt() ?? 0) +
                    "  " +
                    m.currencyTitle! ??
                "";
          }
          if (m.salePriceByAgreement ?? false) {
            price = (price.isEmpty ? "توافقی" : price + "||" + " توافقی");
          }
          pricesColumn.add(
              getContractTitleWidget(m.contractType?.titleSalePriceML ?? ""));
          pricesColumn.add(getContractPriceWidget(price));
        }
      }
      if (m.contractType?.hasDepositPrice ?? false) {
        if (m.depositPrice != null || (m.depositPriceByAgreement ?? false)) {
          String price = "";
          if (m.depositPrice != null && m.depositPrice != 0) {
            price = priceFormat(m.depositPrice?.toInt() ?? 0) +
                    "  " +
                    m.currencyTitle! ??
                "";
          }
          if (m.depositPriceByAgreement ?? false) {
            price = (price.isEmpty ? "توافقی" : price + "||" + " توافقی");
          }
          pricesColumn.add(getContractTitleWidget(
              m.contractType?.titleDepositPriceML ?? ""));
          pricesColumn.add(getContractPriceWidget(price));
        }
      }
      if (m.contractType?.hasRentPrice ?? false) {
        if (m.rentPrice != null || (m.rentPriceByAgreement ?? false)) {
          String price = "";
          if (m.rentPrice != null && m.rentPrice != 0) {
            price = priceFormat(m.rentPrice?.toInt() ?? 0) +
                    "  " +
                    m.currencyTitle! ??
                "";
          }
          if (m.rentPriceByAgreement ?? false) {
            price = (price.isEmpty ? "توافقی" : price + "||" + " توافقی");
          }
          pricesColumn.add(
              getContractTitleWidget(m.contractType?.titleRentPriceML ?? ""));
          pricesColumn.add(getContractPriceWidget(price));
        }
      }
      if (m.contractType?.hasPeriodPrice ?? false) {
        if (m.periodPrice != null || (m.periodPriceByAgreement ?? false)) {
          String price = "";
          if (m.periodPrice != null && m.periodPrice != 0) {
            price = priceFormat(m.rentPrice?.toInt() ?? 0) +
                    "  " +
                    m.currencyTitle! ??
                "";
          }
          if (m.periodPriceByAgreement ?? false) {
            price = (price.isEmpty ? "توافقی" : price + "||" + " توافقی");
          }
          pricesColumn.add(
              getContractTitleWidget(m.contractType?.titlePeriodPriceML ?? ""));
          pricesColumn.add(getContractPriceWidget(price));
        }
      }

      Widget title =
          (getContractTypeTitleWidget(m.contractType?.titleML ?? ""));
      contracs.add(Row(children: [
        if (pricesColumn.isEmpty) title,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: pricesColumn,
        )
      ]));
      //show only one item
      if (!showAll) {
        break;
      }
    }
    return contracs;
  }

  Widget getContractTypeTitleWidget(String title) {
    return Text("$title : ",
        style: const TextStyle(
            fontSize: 13, color: GlobalColor.colorTextSecondary));
  }

  Widget getContractTitleWidget(String title) {
    return Text("$title : ",
        style: const TextStyle(fontSize: 13, color: GlobalColor.colorPrimary));
  }

  Widget getContractPriceWidget(String title) {
    return Text(title,
        style:
            const TextStyle(fontSize: 13, color: GlobalColor.extraPriceColor));
  }

  String priceFormat(int price) {
    return NumberFormat("###,###,###,###,###,###").format(price);
  }
}
