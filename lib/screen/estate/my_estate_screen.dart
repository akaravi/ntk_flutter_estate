import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/edit_estate_controller.dart';
import 'package:ntk_flutter_estate/controller/history_list_controller.dart';
import 'package:ntk_flutter_estate/controller/my_estate_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/edit_estate_screen.dart';
import 'package:ntk_flutter_estate/screen/landused/list_entity_screen.dart';
import 'package:url_launcher/url_launcher.dart';
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

  @override
  Widget build(BuildContext context) {
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
                        width: GlobalData.screenWidth / 2,
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
                      model.title??"",
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
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(
                  title: GlobalString.edit,
                  color: Colors.green,
                  icon: Icons.edit,
                  onPressed: () =>
                      EditEstateController.start(context, model.id ?? ""),
                ),
                SizedBox(
                  width: 16,
                ),
                button(
                  title: GlobalString.delete,
                  color: GlobalColor.colorError,
                  icon: Icons.delete,
                  onPressed: () {
                   MyEstateController.delete(context,model);
                  },
                ),
              ]),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button(
                title: GlobalString.history,
                color: GlobalColor.colorPrimary,
                icon: Icons.work_history,
                onPressed: () {
                  HistoryListController.start(context);
                },
              ),
              SizedBox(
                width: 16,
              ),
              button(
                  title: GlobalString.share,
                  color: GlobalColor.colorAccent,
                  icon: Icons.share_rounded,
                  onPressed: () async {
                    var _url = Uri.parse(model.urlViewContent ?? "");
                    if (!await launchUrl(_url,mode: LaunchMode.externalApplication)) {
                      throw Exception('Could not launch $_url');
                    }
                  })
            ],
          )
          //   child: Row(
          //     children: gePropertyWidget(),
          //   ),
          // )
        ],
      ),
    );
  }

  button(
      {required title,
      required color,
      required icon,
      required void Function() onPressed}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: GlobalData.screenWidth / 3,
      child: Expanded(
        child: TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                elevation: 10,
                backgroundColor: color),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: GlobalColor.colorTextOnPrimary),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  icon,
                  color: GlobalColor.colorTextOnPrimary,
                )
              ],
            )),
      ),
    );
  }
}
