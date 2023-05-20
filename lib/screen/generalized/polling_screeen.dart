import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/polling_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/landused/list_entity_screen.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:motion_toast/motion_toast.dart';

class PollingScreen extends EntityListScreen<PollingContentModel> {
  PollingScreen.withFilterScreen({super.key, FilterModel? filter})
      : super.withFilterScreen(
          title: GlobalString.faq,
          controller: PollingController(
              filter: filter,
              adapterCreatorFunction: (context, m, index) =>
                  _PollAdapter.vertical(
                    model: m,
                  )),
        );
}

class _PollAdapter extends BaseEntityAdapter<PollingContentModel> {
  _PollAdapter._({required super.model, required super.stateCreator});

  factory _PollAdapter.vertical({required PollingContentModel model}) {
    return _PollAdapter._(
      model: model,
      stateCreator: () => _FaqVerticalAdapterState(),
    );
  }
}

class _FaqVerticalAdapterState extends BaseEntityAdapterEstate<_PollAdapter> {
  @override
  Widget build(BuildContext context) {
    String question = widget.model.title ?? "";
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
              child:
                 generatePoll(),
             ),
        ),
        backgroundColor: GlobalColor.colorSemiBackground,
      ),
    );
  }

  colapsedText(String title) {
    return Expanded(
        child: Container(
            child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Text(title, style: TextStyle(color: GlobalColor.colorAccent)),
    )));
  }

  generatePoll() {
    PollingOptionModel lastSelected =
        widget.model.options?.elementAt(0) ?? PollingOptionModel();
    bool isLoad = false;
    if (widget.model.maxVoteForThisContent == 1) {
      return Column(
        children: [
          StatefulBuilder(builder: (context, setState) {
            return RadioGroup<PollingOptionModel>.builder(
                groupValue: lastSelected,
                onChanged: (p0) => setState(() {
                      lastSelected = p0 ?? PollingOptionModel();
                    }),
                items: widget.model.options ?? [],
                itemBuilder: (value) => RadioButtonBuilder(
                      value.option ?? "",
                      textPosition: RadioButtonTextPosition.left,
                    ));
          }),
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoad = true;
                    });

                    try {
                      await PollingVoteService().add(PollingVoteModel()
                        ..linkPollingContentId =
                            lastSelected.linkPollingContentId
                        ..optionScore = 1
                        ..linkPollingOptionId = lastSelected.id);
                      MotionToast.success(description: Text(GlobalString.successfullyAddVote));
                    } on Exception catch (e) {
                      MotionToast.error(description: Text(e.toString()));
                    }
                    isLoad=false;
                    setState(() {

                    });
                  },
                  child: const Text(GlobalString.confirm))
            ],
          )
        ],
      );
    }
  }
}
