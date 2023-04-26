import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/my_estate_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/landused/list_entity_screen.dart';

import '../../widget/contract_widget.dart';

class MyEstateListScreen extends EntityListScreen<EstatePropertyModel> {
  MyEstateListScreen.withFilterScreen({super.key})
      : super.withFilterScreen(
          title: GlobalString.myEstate,
          controller: MyEstateController(
              adapterCreatorFunction: (context, m, index) => _Adapter(
                    model: m,
                  )),
        );
}

class _Adapter extends StatelessWidget {
  EstatePropertyModel model;

  _Adapter({required this.model});

  static double width = 0;

  @override
  Widget build(BuildContext context) {
    if (width == 0) {
      width = MediaQuery.of(context).size.width * (3 / 8);
    }
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //1st's of Column is a row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //image container
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.loose,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        fit: BoxFit.fill,
                        width: width,
                        model.linkMainImageIdSrc!,
                      ),
                    ),
                    //shade
                    Positioned.fill(
                        child: Container(
                      color: Color(0x620B0505),
                    )),
                    //location
                    Positioned(
                      bottom: 0,
                      child: Text(
                        "${model.linkLocationIdTitle ?? ""} - ${model.linkLocationIdParentTitle ?? ""}",
                        style: const TextStyle(
                            color: GlobalColor.colorTextOnPrimary,
                            fontSize: 13),
                      ),
                    ),
                    //picture count
                  ],
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              //title and price container
              Expanded(
                child: Column(
                  children: [
                    Text(
                      model.title!,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 14, color: GlobalColor.colorTextPrimary),
                    ),
                    ...ContractWidget().getPriceWidget(model)
                  ],
                ),
              ),
            ],
          ),
          //2's of Column is row of property
          //todo add properties container
          // Container(
          //   margin: EdgeInsets.only(top: 8),
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       width: 1,
          //       color: GlobalColor.colorSemiBackground,
          //     ),
          //     borderRadius: const BorderRadius.only(
          //         bottomLeft: Radius.circular(6),
          //         bottomRight: Radius.circular(6)),
          //     color: GlobalColor.colorBackground,
          //   ),
          //   child: Row(
          //     children: gePropertyWidget(),
          //   ),
          // )
        ],
      ),
    );
  }
}
