import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/widget/show_dialog_super.dart';

class DeleteDialog {
  showConfirm(
      {required BuildContext context,
      required Future<void> Function() delete}) {
    bool isLoad = false;
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(GlobalString.no),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = StatefulBuilder(
      builder: (context, setState) => isLoad
          ? Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator())
          : TextButton(
              child: const Text(GlobalString.yes),
              onPressed: () async {
                setState(() {
                  isLoad = true;
                });
                await delete();
                Navigator.of(context).pop();
              },
            ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(GlobalString.alert),
      content: Text(GlobalString.deleteConfirm),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
