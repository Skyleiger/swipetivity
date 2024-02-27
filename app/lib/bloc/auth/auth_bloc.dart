import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipetivity_app/model/account.dart';
import 'package:swipetivity_app/repository/auth_repository.dart';

part 'auth_bloc.mapper.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({
    required this.authRepository,
  }) : super(const UnauthenticatedState()) {
    on<AuthenticatedEvent>(_handleAuthenticated);
    on<UnauthenticatedEvent>(_handleUnauthenticated);
  }

  void _handleAuthenticated(AuthenticatedEvent event, Emitter<AuthState> emit) {
    if (state is AuthenticatedState) {
      return;
    }

    emit(AuthenticatedState(account: event.account));
  }

  void _handleUnauthenticated(
      UnauthenticatedEvent event, Emitter<AuthState> emit) {
    if (state is UnauthenticatedState) {
      return;
    }

    emit(const UnauthenticatedState());
  }

  Account? get account {
    if (state is AuthenticatedState) {
      return (state as AuthenticatedState).account;
    }

    return null;
  }
}
