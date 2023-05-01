import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/widget/show_dialog_super.dart';

class FeedBackDialog {
  static bool dissimed = false;

  static show(BuildContext context) {
    double score = 60;
    bool isLoad = false;
    bool error = false;
    dissimed = false;
    String errorText = "";
    TextEditingController txtController = TextEditingController();
    showDialogSuper(
        context: context,
        barrierDismissible: true,
        onDismissed: (p0) => dissimed = true,
        builder: (context) {
          return Container(
              color: Colors.transparent,
              child: Column(children: [
                Container(
                  decoration: const BoxDecoration(
                      color: GlobalColor.colorPrimary,
                      borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(8),
                          topEnd: Radius.circular(8))),
                  child: const Text(GlobalString.feedback),
                ),
                StatefulBuilder(builder: (context, setState) {
                  return Column(
                    children: [
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          score = (rating * 20) % 100;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: txtController,
                        ),
                      ),
                      if (error) Text(errorText),
                      TextButton(
                        child: isLoad
                            ? CircularProgressIndicator()
                            : Text(GlobalString.submit),
                        onPressed: () async {
                          if (!isLoad) {
                            if (txtController.text.isEmpty) {
                              error = true;
                              return;
                            }
                            ApplicationScoreDtoModel model =
                                ApplicationScoreDtoModel()
                                  ..scorePercent = score.toInt()
                                  ..scoreComment = txtController.text;
                            try {
                              isLoad = true;
                              var errorExceptionBase =
                                  await ApplicationAppService().appScore(model);
                              if (errorExceptionBase.isSuccess) {
                                if (!dissimed) Navigator.pop(context);
                              } else {
                                setState(
                                  () {
                                    isLoad = true;
                                    error = true;
                                    errorText =
                                        errorExceptionBase.errorMessage ?? "";
                                  },
                                );
                              }
                            } catch (e) {
                              isLoad = true;
                              errorText = e.toString();
                              setState(() => error = true);
                            }
                          }
                        },
                      )
                    ],
                  );
                }),
              ]));
        });
  }
}
