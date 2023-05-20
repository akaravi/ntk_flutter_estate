import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ntk_flutter_estate/controller/faq_list_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/landused/list_entity_screen.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter_html/flutter_html.dart';

class FaqScreen extends EntityListScreen<TicketingFaqModel> {
  FaqScreen.withFilterScreen({super.key, FilterModel? filter})
      : super.withFilterScreen(
          title: GlobalString.faq,
          controller: FaqController(
              filter: filter,
              adapterCreatorFunction: (context, m, index) =>
                  FaqAdapter.vertical(
                    model: m,
                  )),
        );
}

class FaqAdapter extends BaseEntityAdapter<TicketingFaqModel> {
  FaqAdapter._({required super.model, required super.stateCreator});

  factory FaqAdapter.vertical({required TicketingFaqModel model}) {
    return FaqAdapter._(
      model: model,
      stateCreator: () => _FaqVerticalAdapterState(),
    );
  }
}

class _FaqVerticalAdapterState extends BaseEntityAdapterEstate<FaqAdapter> {
  @override
  Widget build(BuildContext context) {
    String question = widget.model.question ?? "";
    String answer = widget.model.answer ?? "";
    return Material(
      elevation: 15,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Expandable(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        firstChild: colapsedText("$question :"),
        secondChild: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: GlobalColor.colorBackground,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16))),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Html(
              data: widget.model.answer,
            ),
          ),
        ), backgroundColor: GlobalColor.colorSemiBackground,
      ),
    );
  }

  colapsedText(String title) {
    return Expanded(
        child: Container(
            child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Text(title, style: TextStyle(color: GlobalColor.colorTextPrimary)),
    )));
  }
}
