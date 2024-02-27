part of 'community_list_cubit.dart';

@MappableClass()
@immutable
abstract class CommunityListState with CommunityListStateMappable {
  const CommunityListState();
}

@MappableClass()
@immutable
class CommunityListInitial extends CommunityListState
    with CommunityListInitialMappable {
  const CommunityListInitial();
}

@MappableClass()
@immutable
class CommunityListLoading extends CommunityListState
    with CommunityListLoadingMappable {
  const CommunityListLoading();
}

@MappableClass()
@immutable
class CommunityListLoaded extends CommunityListState
    with CommunityListLoadedMappable {
  final List<Community> communities;

  const CommunityListLoaded({required this.communities});
}

@MappableClass()
@immutable
class CommunityListFailure extends CommunityListState
    with CommunityListFailureMappable {
  const CommunityListFailure();
}
