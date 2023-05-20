import 'package:ntk_cms_flutter_base/src/models/entity/estate/estate_property_type_usage_model.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:collection/collection.dart';

class WrapWidgetModel<model> extends StatefulWidget {
  List<model> models;

  Color colorBackground;
  Color colorSelectedBackground;
  Color colorSelectedText;
  Color borderColor;
  int index;
  bool clickable;

  WrapWidgetModel(
      {Key? key,
      required this.models,
      required this.titleModelMethod,
      required this.selectMethod,
      Color? colorBackground,
      Color? colorSelectedText,
      Color? colorSelectedBackground,
      Color? borderColor,
      bool? selectable,
      bool Function(model)? isSelected})
      : colorSelectedBackground =
            colorSelectedBackground ?? GlobalColor.colorAccent,
        colorSelectedText = colorSelectedText ?? GlobalColor.colorOnAccent,
        colorBackground = colorBackground ?? GlobalColor.colorBackground,
        borderColor = borderColor ?? GlobalColor.colorPrimary,
        clickable = selectable ?? true,
        index = isSelected != null ? models.indexWhere(isSelected) : -1,
        super(key: key);

  @override
  State<WrapWidgetModel<model>> createState() =>
      _WrapWidgetModelState<model>(index);

  String Function(model item) titleModelMethod;
  void Function(model item) selectMethod;
}

class _WrapWidgetModelState<model> extends State<WrapWidgetModel<model>> {
  int selectedIndex;

  _WrapWidgetModelState(this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 12,
      spacing: 18,
      children: <Widget>[
        ...widget.models.mapIndexed((index, item) {
          return InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? widget.colorSelectedBackground
                        : widget.colorBackground,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: widget.borderColor)),
                child: Text(widget.titleModelMethod(item),
                    style: TextStyle(
                        color: selectedIndex == index
                            ? widget.colorSelectedText
                            : widget.borderColor,
                        fontSize: 14)),
              ),
              onTap: () {
                if (widget.clickable) {
                  if (selectedIndex != index) {
                    setState(() {
                      selectedIndex = index;
                      widget.selectMethod(item);
                    });
                  }
                }
              });
        })
      ],

      // children: [...widget.models.forEach((i,e) {
      //   return Container(
      //     decoration: BoxDecoration(color: widget.bg, border: Border.all()),
      //   );
      // })],
    );
  }
}
