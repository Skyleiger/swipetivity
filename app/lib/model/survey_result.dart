import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/cupertino.dart';
import 'package:swipetivity_app/model/base_model.dart';

part 'survey_result.mapper.dart';

@MappableClass()
@immutable
class SurveyResult extends BaseModel with SurveyResultMappable {
  const SurveyResult({
    required super.id,
  });
}
