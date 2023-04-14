import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/new_estate_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';

class NewEstateScreen extends StatefulWidget {
  @override
  State<NewEstateScreen> createState() => NewEstateState();
}

class NewEstateState extends State<NewEstateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 1000,width: double.infinity,
          color: GlobalColor.colorSemiBackground,
          padding: EdgeInsets.all(8),
          child: SubNewEstate1(
            controller: NewEstateController(),
          ),
        ),
      ),
    );
  }
}
