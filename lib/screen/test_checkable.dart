import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/widget/location_model_selector_widget.dart';
import 'package:ntk_flutter_estate/widget/property_detail_selector_widget.dart';

class TestCheck extends StatelessWidget {
  const TestCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var es = EstatePropertyDetailModel()
      ..title = "javad"
      ..configValueForceUseDefaultValue = true
      ..configValueMultipleChoice = false
      ..configValueDefaultValues = [
        "1",
        "3",
        "2",
        "1",
        "3",
        "2",
        "3",
        "1",
        "3",
        "2",
        "3",
        "1",
        "2",
        "3" "3",
        "2",
        "3",
        "1",
        "2",
        "3" "3",
        "2",
        "3",
        "1",
        "2",
        "3" "2",
        "3"
      ];
    return Scaffold(
      // body: PropertyDetailSelector().multipleViewHolder(
      //   es),
      body: TextButton(
          child: Center(child: Text("asdasd")),
          onPressed: () async => print(await LocationModelSelectorDialog().show(context))),
    );
  }
}
