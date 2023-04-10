import 'dart:io';
import 'package:intl/intl.dart';
import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:url_launcher/url_launcher.dart';

class EstatePropertyVerticalAdapter extends StatefulWidget {
  const EstatePropertyVerticalAdapter({
    required this.model,
    Key? key,
  }) : super(key: key);
  final EstatePropertyModel model;

  @override
  State<EstatePropertyVerticalAdapter> createState() =>
      _EstatePropertyVerticalAdapterState();
}

class _EstatePropertyVerticalAdapterState
    extends State<EstatePropertyVerticalAdapter> {
  static double width = 0;

  @override
  Widget build(BuildContext context) {
    // if (width == 0) {
    width = MediaQuery.of(context).size.width * (3 / 8);
    // }
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () async => _launchURL(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          //as Column
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //1st's of Column is a row
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //image container
                  Stack(
                    fit: StackFit.loose,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          fit: BoxFit.fill,
                          width: width,
                          widget.model.linkMainImageIdSrc!,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  //title and price container
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          widget.model.title!,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 14,
                              color: GlobalColor.colorTextPrimary),
                        ),
                        ...getPriceWidget()
                      ],
                    ),
                  ),
                ],
              ),
              //2's of Column is row of property
              Row(
                children: [
                  StarDisplay(
                      ViewCount: widget.model.viewCount,
                      ScoreSumPercent: widget.model.scoreSumPercent,
                      color: GlobalColor.colorAccent),
                  Spacer(
                    flex: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      widget.model.viewCount.toString(),
                      style: const TextStyle(
                          fontSize: 15, color: GlobalColor.colorAccent),
                    ),
                  ),
                  const Icon(
                    Icons.remove_red_eye,
                    size: 15,
                    color: GlobalColor.colorAccent,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    //see detail
  }

  List<Widget> getPriceWidget() {
    List<Widget> contracs = List.empty(growable: true);
    for (EstateContractModel m in widget.model.contracts!) {
      List<Widget> row = List.empty(growable: true);
      if (m.contractType?.hasSalePrice ?? false) {
        row.add(getContractTitleWidget(m.contractType?.titleML ?? ""));
        if (m.salePrice != null || (m.salePriceByAgreement ?? false)) {
          String price = "";
          if (m.salePrice != null && m.salePrice != 0) {
            price =
                PriceFormat(m.salePrice ?? 0) + "  " + m.currencyTitle! ?? "";
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
                PriceFormat(m.depositPrice ?? 0) + "  " + m.currencyTitle! ??
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
                PriceFormat(m.rentPrice ?? 0) + "  " + m.currencyTitle! ?? "";
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

  String PriceFormat(double price) {
    return NumberFormat("###,###,###,###,###,###").format(price);
  }

  Widget getContractPriceWidget(String title) {
    return Text("$title : ",
        style:
            const TextStyle(fontSize: 13, color: GlobalColor.extraPriceColor));
  }
}
