part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

@immutable
class AuthenticatedEvent extends AuthEvent {
  final Account account;

  const AuthenticatedEvent({required this.account});
}

class UnauthenticatedEvent extends AuthEvent {
  const UnauthenticatedEvent();
}
