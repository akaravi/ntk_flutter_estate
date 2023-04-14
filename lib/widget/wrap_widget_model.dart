import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:collection/collection.dart';

class WrapWidgetModel<model> extends StatefulWidget {
  List<model> models;

  Color bg;
  Color borderColor;

  WrapWidgetModel(
      {Key? key,
      required this.models,
      required this.titleModel,
      Color? color,
      Color? borderColor})
      : bg = color ?? GlobalColor.colorAccent,
        borderColor = borderColor ?? GlobalColor.colorPrimary,
        super(key: key);

  @override
  State<WrapWidgetModel<model>> createState() => _WrapWidgetModelState<model>();

  String Function(model item) titleModel;
}

class _WrapWidgetModelState<model> extends State<WrapWidgetModel<model>> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ...widget.models.mapIndexed((idx, item) {
          return InkWell(
              child: Text(widget.titleModel(item),
                  style: TextStyle(color: widget.borderColor, fontSize: 15)),
              onTap: () {
                setState(() {});
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
