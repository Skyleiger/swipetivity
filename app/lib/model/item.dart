import 'dart:ui';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:swipetivity_app/model/base_model.dart';

part 'item.mapper.dart';

@MappableClass()
@immutable
class Item extends BaseModel with ItemMappable {
  final String name;
  final String description;
  final Image? image;

  const Item({
    required super.id,
    required this.name,
    required this.description,
    required this.image,
  });
}
