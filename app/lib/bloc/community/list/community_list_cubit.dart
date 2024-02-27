import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipetivity_app/bloc/auth/auth_bloc.dart';
import 'package:swipetivity_app/model/community.dart';
import 'package:swipetivity_app/repository/community_repository.dart';

part 'community_list_cubit.mapper.dart';

part 'community_list_state.dart';

class CommunityListCubit extends Cubit<CommunityListState> {
  final AuthBloc authBloc;
  final CommunityRepository repository;

  CommunityListCubit({
    required this.authBloc,
    required this.repository,
  }) : super(const CommunityListInitial()) {
    loadCommunities();
  }

  Future<void> loadCommunities() async {
    emit(const CommunityListLoading());
    return refreshCommunities();
  }

  Future<void> refreshCommunities() async {
    return repository.fetchCommunities(authBloc.account!).then((communities) {
      if (isClosed) {
        return;
      }

      emitIgnoreClosed(CommunityListLoaded(communities: communities));
    }).catchError((error) {
      emitIgnoreClosed(const CommunityListFailure());
    });
  }

  void emitIgnoreClosed(CommunityListState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
