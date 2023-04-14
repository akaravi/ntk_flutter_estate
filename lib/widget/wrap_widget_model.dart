import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:collection/collection.dart';

class WrapWidgetModel<model> extends StatefulWidget {
  List<model> models;

  Color colorBackground;
  Color colorSelectedBackground;
  Color borderColor;

  WrapWidgetModel(
      {Key? key,
      required this.models,
      required this.titleModelMethod,
      required this.selectMethod,
      Color? colorBackground,
      Color? colorSelectedBackground,
      Color? borderColor})
      : colorSelectedBackground =
            colorSelectedBackground ?? GlobalColor.colorAccent,
        colorBackground = colorBackground ?? GlobalColor.colorBackground,
        borderColor = borderColor ?? GlobalColor.colorPrimary,
        super(key: key);

  @override
  State<WrapWidgetModel<model>> createState() => _WrapWidgetModelState<model>();

  String Function(model item) titleModelMethod;
  void Function(model item) selectMethod;
}

class _WrapWidgetModelState<model> extends State<WrapWidgetModel<model>> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Wrap(runSpacing: 12,
      spacing: 18,
      children: <Widget>[
        ...widget.models.mapIndexed((index, item) {
          return InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? widget.colorSelectedBackground
                        : widget.colorBackground,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: widget.borderColor)),
                child: Text(widget.titleModelMethod(item),
                    style: TextStyle(color: widget.borderColor, fontSize: 15)),
              ),
              onTap: () {
                if (selectedIndex != index) {
                  setState(() {
                    selectedIndex = index;
                    widget.selectMethod(item);
                  });
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
