import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';

class Check extends StatelessWidget {
  bool value = false;
  String title;

  Check({required bool checked, required this.title, Key? key})
      : value = checked,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IgnorePointer(
          child: Checkbox(
            checkColor: GlobalColor.colorOnAccent,
            activeColor: GlobalColor.colorAccentDark,
            value: value,
            onChanged: (value) {},
          ),
        ) , Text(
          title ?? "",
          style: TextStyle(
              color: value
                  ? GlobalColor.colorAccentDark
                  : GlobalColor.colorPrimary),
        ),
      ],
    );
  }
}
