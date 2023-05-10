import 'package:ntk_flutter_estate/controller/history_list_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/landused/list_entity_screen.dart';
import 'package:base/src/index.dart';

class HistoryListScreen extends EntityListScreen<EstatePropertyHistoryModel> {
  HistoryListScreen.withFilterScreen({super.key, FilterModel? filter})
      : super.withFilterScreen(
            title: GlobalString.history,
            controller: HistoryListController(
              filter: filter,
            ));
}
