import 'package:json_annotation/json_annotation.dart';
import 'package:ntk_cms_flutter_base/src/index.dart';
class RecyclerItemModel{
  @JsonKey(name: 'Image')
  String? image;
  @JsonKey(name: 'Title')
  String? title;
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'Filter')
  FilterModel? filter;
}