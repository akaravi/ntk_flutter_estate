import 'package:base/src/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/company/company_detail_screen.dart';
import 'package:ntk_flutter_estate/screen/landused/list_entity_screen.dart';
class CompanyListScreen extends EntityListScreen<EstatePropertyCompanyModel> {
  CompanyListScreen.withFilterScreen({super.key})
      : super.asGridScreen(crossAxs: 2,
    title: GlobalString.companies,
    controller: EstateCompanyListController(
        adapterCreatorFunction: (context, m, index) =>
            _CompanyAdapter(
              model: m,
            )),
  );

}
class _CompanyAdapter extends StatelessWidget {
  EstatePropertyCompanyModel model;

  _CompanyAdapter({required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32))),
      child: InkWell(
        onTap: () async => detailScreen(context),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                fit: BoxFit.contain,
                model.linkMainImageIdSrc ?? "",
                width: GlobalData.screenWidth/3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(model.title ?? ""),
            )
          ],
        ),
      ),
    );
  }

  detailScreen(BuildContext context) {
    BaseController().newPage(
        context: context, newScreen: CompanyDetailScreen(id: model.id ?? ""));
  }

}
