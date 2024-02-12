import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:swipetivity_app/model/base_model.dart';

part 'survey.mapper.dart';

@MappableClass()
@immutable
class Survey extends BaseModel with SurveyMappable {
  final String name;
  final String description;

  const Survey({
    required super.id,
    required this.name,
    required this.description,
  });
}
