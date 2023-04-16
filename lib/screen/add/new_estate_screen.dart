import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/new_estate_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:base/src/index.dart';

import 'sub_new_estate_2.dart';
import 'sub_new_estate_3.dart';
import 'sub_new_estate_4.dart';
import 'sub_new_estate_5.dart';

class NewEstateScreen extends StatefulWidget {
  NewEstateController controller = NewEstateController();

  @override
  State<NewEstateScreen> createState() => NewEstateState();
}

class NewEstateState extends State<NewEstateScreen> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTitle(),
          style: const TextStyle(color: GlobalColor.colorAccent),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: GlobalColor.colorAccent),
          onPressed: () => BaseController().close(context),
        ),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(

              width: double.infinity,
              color: GlobalColor.colorSemiBackground,
              padding: EdgeInsets.all(8),
              child: currentSub()),
        ),
        Positioned.fill(
            bottom: 0,left: 12,right: 12,
            child: Row(children: [nextButton(), Spacer(), prevButton()]))
      ]),
    );
  }

  String getTitle() {
    String s = "";
    switch (index) {
      case 1:
        s = GlobalString.newEstateProperties;
        break;
      case 2:
        s = GlobalString.newEstateDetails;
        break;
      case 3:
        s = GlobalString.newEstateFeatures;
        break;
      case 4:
        s = GlobalString.newEstateContracts;
        break;
      case 5:
        s = GlobalString.newEstatePictures;
        break;
    }

    return "${GlobalString.newEstate} / $s";
  }

  currentSub() {
    switch (index) {
      case 1:
        return SubNewEstate1(controller: widget.controller);
      case 2:
        return SubNewEstate2(controller: widget.controller);
      case 3:
        return SubNewEstate3(controller: widget.controller);
      case 4:
        return SubNewEstate4(controller: widget.controller);
      case 5:
        return SubNewEstate5(controller: widget.controller);
    }
    return Container();
  }

  nextButton() {
    return TextButton(
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          elevation: 10,
          backgroundColor: GlobalColor.colorPrimary),
      onPressed: () {
        if (widget.controller.isValidForNext()) {
          index++;
          setState(() {});
        }
      },
      child: Text(index != 5 ? GlobalString.continueStr : GlobalString.add,
          style:
              const TextStyle(color: GlobalColor.colorTextOnPrimary, fontSize: 16)),
    );
  }

  prevButton() {
    if (index > 1) {
      return OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 1.0, color: GlobalColor.colorPrimary),
          ),
          child: const Text(
            GlobalString.back,
            style: TextStyle(color: GlobalColor.colorPrimary),
          ),
          onPressed: () {
            if (widget.controller.isValidForPrev()) {
              index--;
              setState(() {});
            }
          });
    } else {
      return Container();
    }
  }
}
