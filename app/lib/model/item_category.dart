import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:swipetivity_app/model/base_model.dart';

part 'item_category.mapper.dart';

@MappableClass()
@immutable
class ItemCategory extends BaseModel with ItemCategoryMappable {
  final String name;

  const ItemCategory({
    required super.id,
    required this.name,
  });
}
