import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_4.dart';
import 'package:intl/intl.dart';

class FromToBottomSheet {
  dynamic show(
    BuildContext context, {
    required String title,
    required TextInputType? keyboardType,
    required num? min,
    required num? max,
  }) async {
    TextEditingController minController = TextEditingController();
    if (min != null && min != 0) {
      minController.text = priceFormat(min);
    }
    TextEditingController maxController = TextEditingController();
    if (max != null && max !=0) {
      maxController.text = priceFormat(max);
    }
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                    onPressed: () {
                      num? minString;
                      num? maxString;
                      if (minController.text.trim().isNotEmpty) {
                        minString =num.tryParse( minController.text
                            .trim()
                            .toString()
                            .replaceAll(
                            ThousandsSeparatorInputFormatter.separator, ""));
                      }
                      if (maxController.text.trim().isNotEmpty) {
                        maxString = num.tryParse(maxController.text
                            .trim()
                            .toString()
                            .replaceAll(
                                ThousandsSeparatorInputFormatter.separator, ""));
                      }
                      Navigator.pop(context, [minString, maxString]);
                    },
                    child: const Text(GlobalString.confirm,
                        style: TextStyle(
                            color: GlobalColor.colorOnAccent, fontSize: 16)),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: minController,
                    keyboardType: keyboardType,
                    inputFormatters: [ThousandsSeparatorInputFormatter()],
                    decoration: InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      fillColor: GlobalColor.colorAccentDark
                          .withOpacity(.6)
                          .withAlpha(20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: GlobalColor.colorAccentDark.withOpacity(.4),
                            width: 1.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: GlobalColor.colorAccentDark, width: 2),
                      ),
                      labelText: GlobalString.from,
                      prefixIcon: const Icon(Icons.download_outlined, size: 18),
                    ),
                  )),
                  Expanded(
                      child: TextField(
                    controller: maxController,
                    keyboardType: keyboardType,
                    inputFormatters: [ThousandsSeparatorInputFormatter()],
                    decoration: InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      fillColor: GlobalColor.colorAccentDark
                          .withOpacity(.6)
                          .withAlpha(20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: GlobalColor.colorAccentDark.withOpacity(.4),
                            width: 1.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: GlobalColor.colorAccentDark, width: 2),
                      ),
                      labelText: GlobalString.to,
                      prefixIcon: const Icon(Icons.download_outlined, size: 18),
                    ),
                  ))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

String priceFormat(dynamic price) {
  return NumberFormat("###,###,###,###,###,###").format(price);
}
