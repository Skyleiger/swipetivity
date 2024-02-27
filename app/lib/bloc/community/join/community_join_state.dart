part of 'community_join_bloc.dart';

@immutable
@MappableClass()
abstract class CommunityJoinState with CommunityJoinStateMappable {
  const CommunityJoinState();
}

@immutable
@MappableClass()
class CommunityJoinInitialState extends CommunityJoinState
    with CommunityJoinInitialStateMappable {
  final String pin;

  const CommunityJoinInitialState({
    this.pin = "",
  });
}

@immutable
@MappableClass()
class CommunityJoinLoadingState extends CommunityJoinState
    with CommunityJoinLoadingStateMappable {
  const CommunityJoinLoadingState();
}

@immutable
@MappableClass()
class CommunityJoinSuccessState extends CommunityJoinState
    with CommunityJoinSuccessStateMappable {
  final Community community;

  const CommunityJoinSuccessState({required this.community});
}

@immutable
@MappableClass()
class CommunityJoinErrorState extends CommunityJoinInitialState
    with CommunityJoinErrorStateMappable {
  final ErrorType errorType;

  const CommunityJoinErrorState({
    required super.pin,
    required this.errorType,
  });
}

enum ErrorType {
  communityNotFound,
  userAlreadyInCommunity,
  unknown,
}
