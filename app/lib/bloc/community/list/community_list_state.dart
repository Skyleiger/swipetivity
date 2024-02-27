part of 'community_list_bloc.dart';

@MappableClass()
@immutable
class CommunityListState with CommunityListStateMappable {
  final CommunityListStatus status;
  final List<Community> communities;

  const CommunityListState({
    required this.status,
    this.communities = const [],
  });
}

enum CommunityListStatus {
  initial,
  loading,
  success,
  failure,
}
