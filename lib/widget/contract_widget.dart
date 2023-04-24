import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:intl/intl.dart';
import '../../global_data.dart';

class ContractWidget {
  List<Widget> getPriceWidget(EstatePropertyModel model) {
    List<Widget> contracs = List.empty(growable: true);
    for (EstateContractModel m in model.contracts!) {
      List<Widget> row = List.empty(growable: true);
      if (m.contractType?.hasSalePrice ?? false) {
        row.add(getContractTitleWidget(m.contractType?.titleML ?? ""));
        if (m.salePrice != null || (m.salePriceByAgreement ?? false)) {
          String price = "";
          if (m.salePrice != null && m.salePrice != 0) {
            price =
                priceFormat(m.salePrice ?? 0) + "  " + m.currencyTitle! ?? "";
          }
          if (m.salePriceByAgreement ?? false) {
            price = (price.isEmpty ? "توافقی" : price + "||" + " توافقی");
          }
          row.add(getContractPriceWidget(price));
          contracs.add(Row(
            children: row,
          ));
        }
      }
      if (m.contractType?.hasDepositPrice ?? false) {
        row.add(getContractTitleWidget(m.contractType?.titleML ?? ""));
        if (m.depositPrice != null || (m.depositPriceByAgreement ?? false)) {
          String price = "";
          if (m.depositPrice != null && m.depositPrice != 0) {
            price =
                priceFormat(m.depositPrice ?? 0) + "  " + m.currencyTitle! ??
                    "";
          }
          if (m.depositPriceByAgreement ?? false) {
            price = (price.isEmpty ? "توافقی" : price + "||" + " توافقی");
          }
          row.add(getContractPriceWidget(price));
          contracs.add(Row(
            children: row,
          ));
        }
      }
      if (m.contractType?.hasRentPrice ?? false) {
        row.add(getContractTitleWidget(m.contractType?.titleML ?? ""));
        if (m.rentPrice != null || (m.rentPriceByAgreement ?? false)) {
          String price = "";
          if (m.rentPrice != null && m.rentPrice != 0) {
            price =
                priceFormat(m.rentPrice ?? 0) + "  " + m.currencyTitle! ?? "";
          }
          if (m.rentPriceByAgreement ?? false) {
            price = (price.isEmpty ? "توافقی" : price + "||" + " توافقی");
          }
          row.add(getContractPriceWidget(price));
          contracs.add(Row(
            children: row,
          ));
        }
      }
    }
    return contracs;
  }

  Widget getContractTitleWidget(String title) {
    return Text("$title : ",
        style: const TextStyle(
            fontSize: 13, color: GlobalColor.colorTextSecondary));
  }

  String priceFormat(int price) {
    return NumberFormat("###,###,###,###,###,###").format(price);
  }

  Widget getContractPriceWidget(String title) {
    return Text(title,
        style:
            const TextStyle(fontSize: 13, color: GlobalColor.extraPriceColor));
  }
}
