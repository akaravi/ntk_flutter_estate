import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/new_customer_order_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/widget/location_model_selector_widget.dart';

class SubNewCustomerOrder4 extends SubNewCustomerOrderBase {
  SubNewCustomerOrder4(
      {Key? key, required NewCustomerOrderController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewCustomerOrder4> createState() => _Container1State();
}

class _Container1State extends State<SubNewCustomerOrder4> {
  @override
  Widget build(BuildContext context) {
    if (widget.screenWidth == -1) {
      widget.screenWidth = MediaQuery.of(context).size.width;
    }
    return Column(children: [
      widget.card(children: [
        //title
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: widget.textFieldBoxWidget(
              title: GlobalString.title,
              keyboardType: TextInputType.text,
              textController: widget.controller.titleTextWidget),
        )
      ]),
      //desc
      widget.card(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: widget.textFieldBoxWidget(
              title: GlobalString.desc,
              keyboardType: TextInputType.text,
              textController: widget.controller.descTextWidget),
        )
      ]),
      //card contract list
      widget.card(children: [
        Row(
          children: [
            Expanded(
              child: widget.box(
                title: GlobalString.location,
                widget: (widget.controller.item.locationTitles != null)
                    ? Wrap(runSpacing: 10, spacing: 12, children: [
                        if (widget.controller.item.locationTitles != null)
                          ...(widget.controller.item.locationTitles ?? [])
                              .map((e) => locationWidget(e))
                              .toList()
                      ])
                    : const Padding(
                        padding: EdgeInsets.all(8.0),
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
                        borderRadius: BorderRadius.all(Radius.circular(4))),
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
                      await LocationModelSelectorDialog().show(context);
                  if (model != null) {
                    widget.controller.item.locationTitles ??= [];
                    widget.controller.item.linkLocationIds ??= [];
                    if ((widget.controller.item.linkLocationIds ?? [])
                        .contains(model.id)) {
                      widget.controller.item.locationTitles
                          ?.add(model.title ?? "");
                      widget.controller.item.linkLocationIds
                          ?.add(model.id ?? 0);
                      setState(() {});
                    }
                  }
                },
              ),
            ),
          ],
        )
      ]),
    ]);
  }
}

Widget locationWidget(String e) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    decoration: BoxDecoration(
        color: GlobalColor.colorBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: GlobalColor.colorAccent)),
    child: Text(e,
        style: const TextStyle(color: GlobalColor.colorPrimary, fontSize: 14)),
  );
}

abstract class SubNewCustomerOrderBase extends StatefulWidget with Sub {
  NewCustomerOrderController controller;
  double screenWidth = -1;

  SubNewCustomerOrderBase({Key? key, required this.controller});
}
