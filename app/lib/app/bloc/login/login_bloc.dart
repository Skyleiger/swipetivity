import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:swipetivity_app/app/bloc/auth/auth_bloc.dart';
import 'package:swipetivity_app/app/model/account.dart';
import 'package:swipetivity_app/app/repository/auth_repository.dart';

part 'login_bloc.mapper.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final AuthRepository authRepository;
  final AuthBloc authBloc;

  LoginBloc({
    required this.authRepository,
    required this.authBloc,
  }) : super(const LoginState()) {
    on<EmailAddressChangedEvent>(_handleEmailAddressChange);
    on<PasswordChangedEvent>(_handlePasswordChange);
    on<LoginButtonPressedEvent>(_handleLoginButtonPressed);
  }

  void _handleEmailAddressChange(
      EmailAddressChangedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(emailAddress: event.emailAddress));
  }

  void _handlePasswordChange(
      PasswordChangedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _handleLoginButtonPressed(
      LoginButtonPressedEvent event, Emitter<LoginState> emit) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    try {
      Account account =
          await authRepository.login(state.emailAddress, state.password);

      authBloc.add(AuthenticatedEvent(account: account));
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      authBloc.add(const UnauthenticatedEvent());
      emit(state.copyWith(status: LoginStatus.failed));
    }
  }
}
