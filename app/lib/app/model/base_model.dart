import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';

part 'base_model.mapper.dart';

@MappableClass()
@immutable
abstract class BaseModel with BaseModelMappable {
  final int id;

  const BaseModel({required this.id});
}
