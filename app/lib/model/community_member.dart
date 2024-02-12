import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:swipetivity_app/model/base_model.dart';
import 'package:swipetivity_app/model/user.dart';

part 'community_member.mapper.dart';

@MappableClass()
@immutable
class CommunityMember extends BaseModel with CommunityMemberMappable {
  final User user;
  final DateTime joinedAt;

  const CommunityMember({
    required super.id,
    required this.user,
    required this.joinedAt,
  });
}
