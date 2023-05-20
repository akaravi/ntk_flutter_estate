import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';

class SubErrorScreen extends StatelessWidget {
  String title;

  String? message;

  VoidCallback tryAgainMethod;

   SubErrorScreen(
      {super.key,
      required this.title,
      required this.tryAgainMethod,
      this.message});

  @override
  Widget build(BuildContext context) {

  return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              height: MediaQuery.of(context).size.height / 6,
              child: Lottie.asset(
                'assets/lottie/sub_error.json',
                repeat: true,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: GlobalColor.colorTextPrimary, fontSize: 14)),
            if (message != null)
              const SizedBox(
                height: 16,
              ),
            if (message != null)
              Text(message ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: GlobalColor.colorTextPrimary, fontSize: 12)),
            const SizedBox(
              height: 16,
            ), TextButton(style: TextButton.styleFrom(
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                elevation: 10,
                backgroundColor: GlobalColor.colorPrimary),
              onPressed: tryAgainMethod,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(GlobalString.reTry ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          color: GlobalColor.colorOnAccent,
                        )),
                    Icon(
                      Icons.error,
                      color: GlobalColor.colorOnAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
