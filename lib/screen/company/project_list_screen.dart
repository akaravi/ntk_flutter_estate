import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/landused/list_entity_screen.dart';
class ProjectListScreen extends EntityListScreen<EstatePropertyProjectModel> {
  ProjectListScreen.withFilterScreen({super.key})
      : super.withFilterScreen(
    title: GlobalString.projects,
    controller: EstateProjectListController(
        adapterCreatorFunction: (context, m, index) =>
            ProjectModelAdapter(
              model: m,
            )),
  );
}

class ProjectModelAdapter extends StatelessWidget {
  EstatePropertyProjectModel model;

  ProjectModelAdapter({required this.model});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}