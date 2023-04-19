import 'package:base/src/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/landused/list_entity_screen.dart';
class CompanyListScreen extends EntityListScreen<EstatePropertyCompanyModel> {
  CompanyListScreen.withFilterScreen({super.key})
      : super.withFilterScreen(
    title: GlobalString.news,
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
    // TODO: implement build
    throw UnimplementedError();
  }

}
