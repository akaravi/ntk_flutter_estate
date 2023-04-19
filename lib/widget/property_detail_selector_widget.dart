import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/global_data.dart';

import '../screen/add/sub_new_estate_1.dart';

class PropertyDetailSelector {
  Widget viewHolder(EstatePropertyDetailModel item) {
    EnumInputDataType type = item.inputDataType ?? EnumInputDataType.string;
    //string type
    // if (type == EnumInputDataType.string) {
    //   if (item.configValueForceUseDefaultValue ?? false) {
    //     //multiple choose
    //     if (item.configValueMultipleChoice ?? false) {
    //       return multipleViewHolder(item);
    //     }
    //     //single choolse
    //     else {
    //       return singleViewHolder(item);
    //     }
    //   }
    //   //reqular string
    //   else {
    //     return StringViewHolder(item: item, keyboardType: TextInputType.text);
    // }
    // }
    // //int type
    // if (type == EnumInputDataType.int) {
    //   return StringViewHolder(item: item, keyboardType: TextInputType.number);
    // }
    // //double type
    // if (type == EnumInputDataType.float) {
    //   return StringViewHolder(
    //       item: item,
    //       keyboardType:
    //           TextInputType.numberWithOptions(signed: false, decimal: true));
    // }
    if (type == EnumInputDataType.boolean) {
      return BooleanViewHolder(item);
    }
    // if (type == EnumInputDataType.date) {
    //   return DateViewHolder(item);
    // }
    // if (type == EnumInputDataType.textArea) {
    //   return MultiLinesViewHolder(item);
    // }

    return StringViewHolder(item: item, keyboardType: TextInputType.text);
  }

  Widget StringViewHolder(
      {required EstatePropertyDetailModel item,
      required TextInputType keyboardType}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: item.text,
        keyboardType: keyboardType ?? TextInputType.number,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: GlobalColor.colorPrimary, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: GlobalColor.colorPrimary, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: item.title,
            labelStyle: TextStyle(
              color: GlobalColor.colorAccent,
            )),
      ),
    );
  }

  Widget multipleViewHolder(EstatePropertyDetailModel item) {
    return box(title: "title", widget: Text("TExt"));
  }

  Widget singleViewHolder(EstatePropertyDetailModel item) {
    return box(title: "title", widget: Text("TExt"));
  }

  Widget MultiLinesViewHolder(EstatePropertyDetailModel item) {
    return box(title: "title", widget: Text(item.text.text,));
  }

  Widget DateViewHolder(EstatePropertyDetailModel item) {
    return box(title: "title", widget: Text("TExt"));
  }

  Widget BooleanViewHolder(EstatePropertyDetailModel item) {
    return StatefulBuilder(
      builder: (context, setState) => InkWell(
        onTap: () {
          if (item.text.text == null || item.text.text == "false") {
            item.text.text = "true";
          } else {
            item.text.text = "false";
          }
          setState(() {});
        },
        child: box(
            title: "",
            widget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title ?? "",
                  style: TextStyle(
                      color: item.text.text == 'true'
                          ? GlobalColor.colorAccentDark
                          : GlobalColor.colorPrimary),
                ),
                Checkbox(
                  checkColor: GlobalColor.colorOnAccent,
                  activeColor: GlobalColor.colorAccentDark,
                  value: item.text.text == 'true' ? true : false,
                  onChanged: (value) {
                    item.text.text = (value!).toString();
                    setState(() {});
                  },
                )
              ],
            )),
      ),
    );
  }

  Container box({required String title, required Widget widget}) {
    return Container(
      width: double.infinity / 2,
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
