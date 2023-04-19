import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/new_estate_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_2.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height, color: GlobalColor.colorSemiBackground,
        child:
        Stack(children: [
          Positioned.fill(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                    child: Container(
                        color: Colors.deepPurple,
                        padding: EdgeInsets.only(bottom: 78),
                        child: SubNewEstate2(controller: NewEstateController(),)),
                  ),
          ),
          Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Container(
                height: 70, color: Colors.deepPurpleAccent, child: Text("asd"),))
        ]
        ),
      ),
    );
  }
}
