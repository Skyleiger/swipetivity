import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:swipetivity_app/model/base_model.dart';
import 'package:swipetivity_app/model/item_type.dart';
import 'package:swipetivity_app/model/survey_result.dart';

part 'survey.mapper.dart';

@MappableClass()
@immutable
class Survey extends BaseModel with SurveyMappable {
  final String name;
  final String description;
  final ItemType itemType;
  final SurveyResult? result;

  const Survey({
    required super.id,
    required this.name,
    required this.description,
    required this.itemType,
    this.result,
  });
}
