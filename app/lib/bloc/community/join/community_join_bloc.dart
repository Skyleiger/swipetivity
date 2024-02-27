import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipetivity_app/bloc/auth/auth_bloc.dart';
import 'package:swipetivity_app/exception/community_exceptions.dart';
import 'package:swipetivity_app/model/community.dart';
import 'package:swipetivity_app/repository/community_repository.dart';

part 'community_join_bloc.mapper.dart';

part 'community_join_event.dart';

part 'community_join_state.dart';

class CommunityJoinBloc extends Bloc<CommunityJoinEvent, CommunityJoinState> {
  final AuthBloc authBloc;
  final CommunityRepository repository;

  CommunityJoinBloc({
    required this.authBloc,
    required this.repository,
  }) : super(const CommunityJoinInitialState()) {
    on<CommunityPinChangedEvent>(_handleCommunityPinChangedEvent);
    on<CommunityJoinButtonPressedEvent>(_handleCommunityJoinButtonPressedEvent);
  }

  void _handleCommunityPinChangedEvent(
      CommunityPinChangedEvent event, Emitter<CommunityJoinState> emit) {
    CommunityJoinState state = this.state;

    if (state is CommunityJoinInitialState) {
      emit(state.copyWith(pin: event.pin));
    }
  }

  void _handleCommunityJoinButtonPressedEvent(
      CommunityJoinButtonPressedEvent event,
      Emitter<CommunityJoinState> emit) async {
    CommunityJoinState state = this.state;

    if (state is! CommunityJoinInitialState) {
      return;
    }

    String pin = state.pin;
    emit(const CommunityJoinLoadingState());

    try {
      Community community = await repository.fetchCommunityByPin(pin);
      await repository.joinCommunity(community, authBloc.account!);

      emit(CommunityJoinSuccessState(community: community));
    } on CommunityByPinNotFoundException {
      emit(CommunityJoinErrorState(
        pin: pin,
        errorType: ErrorType.communityNotFound,
      ));
      return;
    } on UserAlreadyInCommunityException {
      emit(CommunityJoinErrorState(
        pin: pin,
        errorType: ErrorType.userAlreadyInCommunity,
      ));
      return;
    } catch (e) {
      emit(CommunityJoinErrorState(
        pin: pin,
        errorType: ErrorType.unknown,
      ));
      return;
    }
  }
}
