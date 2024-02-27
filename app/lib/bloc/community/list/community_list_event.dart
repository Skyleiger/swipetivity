part of 'community_list_bloc.dart';

@immutable
abstract class CommunityListEvent {
  const CommunityListEvent();
}

class CommunityListLoadEvent extends CommunityListEvent {
  const CommunityListLoadEvent();
}

class CommunityListRefreshEvent extends CommunityListEvent {
  const CommunityListRefreshEvent();
}
