import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';

/// Basic layout for empty list.
class SubEmptyScreen extends StatelessWidget {
  const SubEmptyScreen({
    required this.title,
    this.message,
    this.addNewItem,
    this.addNewItemTitle,
    Key? key,
  })  : assert(title != null),
        super(key: key);
  final String title;
  final String? message;
  final VoidCallback? addNewItem;
  final String? addNewItemTitle;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                height: MediaQuery.of(context).size.height / 6,
                child: Lottie.asset(
                  'assets/lottie/sub_empty.json',
                  repeat: true,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: GlobalColor.colorTextPrimary,fontSize: 14)
              ),
              if (message != null)
                const SizedBox(
                  height: 16,
                ),
              if (message != null)
                Text(
                  message ?? '',
                  textAlign: TextAlign.center,
                    style: const TextStyle(color: GlobalColor.colorTextPrimary,fontSize: 12)
                ),
              if (addNewItem != null) const Spacer(),
              if (addNewItem != null)
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: addNewItem,
                    child: Column(
                      children: [
                        Text(addNewItemTitle ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              color: GlobalColor.colorOnAccent,
                            )),
                        const Icon(
                          Icons.add,
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
