import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/global_data.dart';

import '../screen/add/sub_new_estate_1.dart';

class PropertyDetailSelector {
  Widget viewHolder(EstatePropertyDetailModel item) {
    EnumInputDataType type = item.inputDataType ?? EnumInputDataType.string;
    //string type
    if (type == EnumInputDataType.string) {
      if (item.configValueForceUseDefaultValue ?? false) {
        //multiple choose
        if (item.configValueMultipleChoice ?? false) {
          return multipleViewHolder(item);
        }
        //single choolse
        else {
          return singleViewHolder(item);
        }
      }
      //reqular string
      else {
        return StringViewHolder(item);
      }
    }
    //int type
    if (type == EnumInputDataType.int) {
      return StringViewHolder(item);
    }
    //double type
    if (type == EnumInputDataType.float) {
      return StringViewHolder(item);
    }
    if (type == EnumInputDataType.boolean) {
      return BooleanViewHolder(item);
    }
    if (type == EnumInputDataType.date) {
      return DateViewHolder(item);
    }
    if (type == EnumInputDataType.textArea) {
      return MultiLinesViewHolder(item);
    }

    return StringViewHolder(item);
  }

  Widget StringViewHolder(EstatePropertyDetailModel item) {
    return box(title: "title", widget: Text("TExt"));
  }

  Widget multipleViewHolder(EstatePropertyDetailModel item) {
    return box(title: "title", widget: Text("TExt"));
  }

  Widget singleViewHolder(EstatePropertyDetailModel item) {
    return box(title: "title", widget: Text("TExt"));
  }

  Widget MultiLinesViewHolder(EstatePropertyDetailModel item) {
    return box(title: "title", widget: Text("TExt"));
  }

  Widget DateViewHolder(EstatePropertyDetailModel item) {
    return box(title: "title", widget: Text("TExt"));
  }

  Widget BooleanViewHolder(EstatePropertyDetailModel item) {
    return box(title: "title", widget: Text("TExt"));
  }

  Container box({required String title, required Widget widget}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: GlobalColor.colorBackground),
      margin: new EdgeInsets.all(20.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(17)),
                  border:
                      Border.all(width: 1, color: GlobalColor.colorPrimary)),
              padding: EdgeInsets.only(
                right: 16,
                left: 16,
                bottom: 20,
                top: 20,
              ),
              child: widget),
          Positioned(
            top: -10,
            right: 20,
            child: Container(
              color: Colors.white,
              child: Text(title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: GlobalColor.colorAccent, fontSize: 13)),
            ),
          )
        ],
      ),
    );
  }
}
