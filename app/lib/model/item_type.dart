import 'dart:ui';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:swipetivity_app/model/base_model.dart';

part 'item_type.mapper.dart';

@MappableClass()
@immutable
class ItemType extends BaseModel with ItemTypeMappable {
  final String name;
  final String? description;
  final Image? image;

  const ItemType({
    required super.id,
    required this.name,
    this.description,
    this.image,
  });
}
