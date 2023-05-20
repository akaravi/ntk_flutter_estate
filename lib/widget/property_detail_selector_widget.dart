import 'package:flutter/material.dart';
import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/widget/checkbox_widget.dart';

import '../screen/add/sub_new_estate_1.dart';

class PropertyDetailSelector {
  Widget viewHolder(BuildContext context, EstatePropertyDetailModel item) {
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
          return singleViewHolder( item);
        }
      }
      //reqular string
      else {
        return StringViewHolder(item: item, keyboardType: TextInputType.text);
      }
    }
    //int type
    if (type == EnumInputDataType.int) {
      return StringViewHolder(item: item, keyboardType: TextInputType.number);
    }
    //double type
    if (type == EnumInputDataType.float) {
      return StringViewHolder(
          item: item,
          keyboardType:
              TextInputType.numberWithOptions(signed: false, decimal: true));
    }
    if (type == EnumInputDataType.boolean) {
      return booleanViewHolder(item);
    }
    if (type == EnumInputDataType.date) {
      return DateViewHolder(item);
    }
    if (type == EnumInputDataType.textArea) {
      return multiLinesViewHolder(item);
    }

    return StringViewHolder(item: item, keyboardType: TextInputType.text);
  }

  Widget StringViewHolder(
      {required EstatePropertyDetailModel item,
      required TextInputType keyboardType}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: item.text,
        keyboardType: keyboardType,
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
    return MultipleViewHolder(item: item);
  }

  Widget singleViewHolder(
      EstatePropertyDetailModel item) {
    return SingleViewHolder(item: item);
  }

  Widget multiLinesViewHolder(EstatePropertyDetailModel item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        readOnly: true,
        controller: item.text,
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

  Widget DateViewHolder(EstatePropertyDetailModel item) {
    return box(title: "title", widget: Text("TExt"));
  }

  Widget booleanViewHolder(EstatePropertyDetailModel item) {
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
                Expanded(
                  child: Text( overflow: TextOverflow.ellipsis,
                    item.title ?? "",softWrap: false,
                    maxLines: 1,
                    style: TextStyle(fontSize: 12,
                        color: item.text.text == 'true'
                            ? GlobalColor.colorAccentDark
                            : GlobalColor.colorPrimary),
                  ),
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
      margin: new EdgeInsets.all(10.0),
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
                right: 8,
                left: 8,
                bottom: 4,
                top: 6,
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

class SingleViewHolder extends StatefulWidget {
  EstatePropertyDetailModel item;

  SingleViewHolder({required this.item, Key? key}) : super(key: key);

  @override
  State<SingleViewHolder> createState() => _SingleViewHolderState();
}

class MultipleViewHolder extends StatefulWidget {
  EstatePropertyDetailModel item;

  MultipleViewHolder({required this.item, Key? key}) : super(key: key);

  @override
  State<MultipleViewHolder> createState() => _MultipleViewHolder();
}

class _SingleViewHolderState extends State<SingleViewHolder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        readOnly: true,
        style: TextStyle(color: GlobalColor.colorPrimary),
        controller: widget.item.text,
        onTap: () async {
          var index = await ModalBottomSheetSingleList(
              context, widget.item.configValueDefaultValue ?? []);
          print("index $index");
          if (index != null) {
            if (index != -1) {
              widget.item.text.text =
                  (widget.item.configValueDefaultValue ?? [])[index];
            } else {
              widget.item.text.text = "";
            }
            setState(() {});
          }
        },
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
            labelText: widget.item.title,
            labelStyle: TextStyle(
              color: GlobalColor.colorAccent,
            )),
      ),
    );
  }

  ModalBottomSheetSingleList(
      BuildContext c, List<String> configValueDefaultValue) async {
    int value = -1;
    int res = await showModalBottomSheet(
        context: c,
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.2,
            maxChildSize: 1,
            expand: false,
            builder: (_, controller) => Column(children: [
                  Icon(
                    Icons.remove,
                    color: Colors.red[600],
                  ),
                  TextButton(
                      onPressed: () => Navigator.pop(c, value),
                      child: Text(GlobalString.select)),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Expanded(
                        child: ListView.builder(
                            controller: controller,
                            itemCount: configValueDefaultValue.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  if (value == index) {
                                    value = -1;
                                  } else {
                                    value = index;
                                  }
                                  setState(
                                    () {},
                                  );
                                },
                                child: ListTile(
                                    title: Check(
                                  checked: index == value,
                                  title: configValueDefaultValue[index],
                                )),
                              );
                            }),
                      );
                    },
                  )
                ])));
    return res;
  }
}

class _MultipleViewHolder extends State<MultipleViewHolder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        readOnly: true,
        style: TextStyle(color: GlobalColor.colorPrimary),
        controller: widget.item.text,
        onTap: () async {
          var index = await ModalBottomSheetMultiList(
              context, widget.item.configValueDefaultValue ?? []);
          print("index $index");
          if (index != null) {
            if ((index as List<int>).isNotEmpty) {
              List<String> selected = [];
              for (int e in index) {
                selected.add((widget.item.configValueDefaultValue ?? [])[e]);
              }
              widget.item.text.text = selected.join(",");
            } else {
              widget.item.text.text = "";
            }
            setState(() {});
          }
        },
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
            labelText: widget.item.title,
            labelStyle: TextStyle(
              color: GlobalColor.colorAccent,
            )),
      ),
    );
  }

  ModalBottomSheetMultiList(
      BuildContext c, List<String> configValueDefaultValue) async {
    List<int> value = [];
    List<int> res = await showModalBottomSheet(
        context: c,
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.2,
            maxChildSize: 1,
            expand: false,
            builder: (_, controller) => Column(children: [
                  Icon(
                    Icons.remove,
                    color: Colors.red[600],
                  ),
                  TextButton(
                      onPressed: () => Navigator.pop(c, value),
                      child: Text(GlobalString.select)),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Expanded(
                        child: ListView.builder(
                            controller: controller,
                            itemCount: configValueDefaultValue.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  if (value.contains(index)) {
                                    value.removeAt(index);
                                  } else {
                                    value.add(index);
                                  }
                                  setState(
                                    () {},
                                  );
                                },
                                child: ListTile(
                                    title: Check(
                                  checked: value.contains(index),
                                  title: configValueDefaultValue[index],
                                )),
                              );
                            }),
                      );
                    },
                  )
                ])));
    return res;
  }
}
