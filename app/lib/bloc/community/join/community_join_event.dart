part of 'community_join_bloc.dart';

@immutable
abstract class CommunityJoinEvent {
  const CommunityJoinEvent();
}

class CommunityPinChangedEvent extends CommunityJoinEvent {
  final String pin;

  const CommunityPinChangedEvent({
    required this.pin,
  });
}

class CommunityJoinButtonPressedEvent extends CommunityJoinEvent {
  const CommunityJoinButtonPressedEvent();
}
