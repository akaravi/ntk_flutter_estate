import 'package:json_annotation/json_annotation.dart';
import 'package:ntk_cms_flutter_base/src/index.dart';
import 'recycler_item_model.dart';

@JsonSerializable()
class RowModel {
  @JsonKey(name: 'HeaderString')
  String? headerString;
  @JsonKey(name: 'Items')
  List<RecyclerItemModel>? items;
  @JsonKey(name: 'Filter')
  FilterModel? filter;
}
