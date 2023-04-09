import 'dart:io';

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
    return Card(elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () async => _launchURL(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          //as Column
          child: Column(mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                //1st's of Column is a row
                Row(mainAxisSize: MainAxisSize.min,
                  children: [
                    //image container
                    Stack(fit: StackFit.loose,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            fit: BoxFit.fill,  width: width,
                            widget.model.linkMainImageIdSrc!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 4,),
                    //title and price container
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            widget.model.title!,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 14, color: GlobalColor.colorTextPrimary),
                          ),
                          getPriceWidget()
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

  getPriceWidget() {
    for (EstateContractModel m in
    widget.model.contracts!) {

      if (m.contractType?.hasSalePrice??false) {
      //   priceTitle1.setText(m.ContractType.TitleML+" : ");
      //   if (m.SalePrice != null || m.SalePriceByAgreement) {
      //     priceTitle1.setVisibility(View.VISIBLE);
      //     price1.setVisibility(View.VISIBLE);
      //     String price = "";
      //     if (m.SalePrice != null && m.SalePrice != 0)
      //       price = NViewUtils.PriceFormat(m.SalePrice) + "  " + m.UnitSalePrice;
      //     if (m.SalePriceByAgreement)
      //       price=(price.isEmpty() ? "توافقی" : price + "||" + " توافقی");
      //     price1.setText(price);
      //   } else {
      //     priceTitle1.setVisibility(View.VISIBLE);
      //     priceTitle1.setText("جهت :" + m.ContractType.TitleML);
      //   }
      // } else {
      //   priceTitle1.setVisibility(View.GONE);
      //   price1.setVisibility(View.GONE);
      //
      // }
      // if (m.ContractType.HasDepositPrice) {
      //   priceTitle2.setText(m.ContractType.TitleML+" :");
      //   if (m.DepositPrice != null || m.DepositPriceByAgreement) {
      //     priceTitle2.setVisibility(View.VISIBLE);
      //     price2.setVisibility(View.VISIBLE);
      //     String price = "";
      //     if (m.DepositPrice != null && m.DepositPrice != 0)
      //       price=(NViewUtils.PriceFormat(m.DepositPrice) + "  " + m.UnitSalePrice);
      //     if (m.DepositPriceByAgreement)
      //       price=(price.isEmpty() ? "توافقی" : price + "||" + " توافقی");
      //     price2.setText(price);
      //   } else {
      //     priceTitle2.setVisibility(View.VISIBLE);
      //     priceTitle2.setText("جهت :" + m.ContractType.TitleML);
      //   }
      // } else {
      //   priceTitle2.setVisibility(View.GONE);
      //   price2.setVisibility(View.GONE);
      //
      // }
      // if (m.ContractType.HasRentPrice) {
      //   priceTitle3.setText(m.ContractType.TitleML+" :");
      //   if (m.RentPrice != null || m.RentPriceByAgreement) {
      //     priceTitle3.setVisibility(View.VISIBLE);
      //     price3.setVisibility(View.VISIBLE);
      //     String price = "";
      //     if (m.RentPrice != null && m.RentPrice != 0)
      //       price=(NViewUtils.PriceFormat(m.RentPrice) + "  " + m.UnitSalePrice);
      //     if (m.RentPriceByAgreement)
      //       price=(price.isEmpty() ? "توافقی" : price + "||" + " توافقی");
      //     price3.setText(price);
      //   } else {
      //     priceTitle3.setVisibility(View.VISIBLE);
      //     priceTitle3.setText("جهت :" + m.ContractType.TitleML);
      //   }
      // } else {
      //   priceTitle3.setVisibility(View.GONE);
      //   price3.setVisibility(View.GONE);
      }

    }
  }
}
