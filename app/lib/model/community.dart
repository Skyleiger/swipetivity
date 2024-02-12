import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:swipetivity_app/model/base_model.dart';
import 'package:swipetivity_app/model/community_member.dart';

part 'community.mapper.dart';

@MappableClass()
@immutable
class Community extends BaseModel with CommunityMappable {
  final String name;
  final String pin;
  final List<CommunityMember> members;

  const Community({
    required super.id,
    required this.name,
    required this.pin,
    required this.members,
  });
}
