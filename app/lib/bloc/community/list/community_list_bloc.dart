import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipetivity_app/bloc/auth/auth_bloc.dart';
import 'package:swipetivity_app/model/community.dart';
import 'package:swipetivity_app/repository/community_repository.dart';

part 'community_list_bloc.mapper.dart';

part 'community_list_event.dart';

part 'community_list_state.dart';

class CommunityListBloc extends Bloc<CommunityListEvent, CommunityListState> {
  final AuthBloc authBloc;
  final CommunityRepository repository;

  CommunityListBloc({
    required this.authBloc,
    required this.repository,
  }) : super(const CommunityListState(status: CommunityListStatus.loading)) {
    on<CommunityListLoadEvent>(_loadCommunityList);
    on<CommunityListRefreshEvent>(_refreshCommunityList);
  }

  Future<void> _loadCommunityList(
      CommunityListLoadEvent event, Emitter<CommunityListState> emit) async {
    emit(state.copyWith(status: CommunityListStatus.loading));

    return repository.fetchCommunities(authBloc.account!).then((communities) {
      emit(state.copyWith(
        status: CommunityListStatus.success,
        communities: communities,
      ));
    }).catchError((error) {
      emit(state.copyWith(status: CommunityListStatus.failure));
    });
  }

  Future<void> _refreshCommunityList(
      CommunityListRefreshEvent event, Emitter<CommunityListState> emit) async {
    return repository.fetchCommunities(authBloc.account!).then((communities) {
      emit(state.copyWith(
        status: CommunityListStatus.success,
        communities: [],
      ));

      emit(state.copyWith(
        status: CommunityListStatus.success,
        communities: communities,
      ));
    }).catchError((error) {
      emit(state.copyWith(status: CommunityListStatus.failure));
    });
  }
}
