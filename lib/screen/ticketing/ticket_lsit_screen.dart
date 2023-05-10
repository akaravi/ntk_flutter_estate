import 'package:base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ntk_flutter_estate/controller/ticket_list_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/landused/list_entity_screen.dart';
import 'package:ntk_flutter_estate/screen/news/news_model_adapter.dart';
class TicketListScreen extends EntityListScreen<TicketingTaskModel> {
  TicketListScreen.withFilterScreen({super.key})
      : super.withFilterScreen(
          title: GlobalString.ticketing,
          controller: TicketListController(
              adapterCreatorFunction: (context, m, index) =>
                  TicketingTask.verticalType(
                    model: m,
                  )),
        );
}

class TicketingTask extends BaseEntityAdapter<TicketingTaskModel> {
  TicketingTask._(
      {required super.model, super.key, required super.stateCreator});

  factory TicketingTask.verticalType({required TicketingTaskModel model}) {
    return TicketingTask._(
        model: model, stateCreator: () => _TicketingTaskState());
  }
}
class _TicketingTaskState extends BaseEntityAdapterEstate<TicketingTask> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () async => {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.model.title!,
                      style: const TextStyle(color: GlobalColor.colorTextPrimary),
                    ),
                  ),
                  if (widget.model.linkFileIdsSrc != null)
                    const SizedBox(
                      width: 16,
                    ),
                  if (widget.model.linkFileIdsSrc != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.model.linkFileIdsSrc![0],
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.model.email!,
                style: TextStyle(),
              ),
              Text(
                '$_formattedReleaseDate ($_formattedDurationInMinutes)',
                style: TextStyle(),
              )
            ],
          ),
        ),
      ),
    );
  }
  String get _formattedReleaseDate =>
      DateFormat('MMM d yyyy').format(widget.model.createdDate!);
  String get _formattedDurationInMinutes {
    final durationInMinutes = 120 / 60;
    return '${durationInMinutes.toStringAsFixed(0)} mins';
  }
}
