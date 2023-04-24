import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';

class FromToBottomSheet {
  show(
    BuildContext context, {
    required String title,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            Row(
              children: [
                Text(title),
                Spacer(
                  flex: 1,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      elevation: 10,
                      backgroundColor: GlobalColor.colorAccent),
                  onPressed: () {},
                  child: const Text(GlobalString.confirm,
                      style: TextStyle(
                          color: GlobalColor.colorOnAccent, fontSize: 16)),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(),
                ),
                Expanded(
                  child: TextField(),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
