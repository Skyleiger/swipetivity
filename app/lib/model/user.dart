import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:swipetivity_app/model/base_model.dart';

part 'user.mapper.dart';

@MappableClass()
@immutable
class User extends BaseModel with UserMappable {
  final String username;

  const User({
    required super.id,
    required this.username,
  });
}
