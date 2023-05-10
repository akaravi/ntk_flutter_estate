import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/company/project_detail_screen.dart';
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
    return Card(
      elevation: 12,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32))),
      child: InkWell(
        onTap: () async => detailScreen(context),
        child: Column(
          children: [
            Image.network(
              fit: BoxFit.fill,
              model.linkMainImageIdSrc ?? "",
              width: GlobalData.screenWidth,
              height: GlobalData.screenHeight / 3,
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
        context: context,   newWidget: (context) =>  ProjectDetailScreen(id: model.id ?? ""));
  }
}
