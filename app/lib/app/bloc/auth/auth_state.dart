part of 'auth_bloc.dart';

@MappableClass()
@immutable
sealed class AuthState with AuthStateMappable {
  const AuthState();
}

@MappableClass()
@immutable
class UnauthenticatedState extends AuthState with UnauthenticatedStateMappable {
  const UnauthenticatedState();
}

@MappableClass()
@immutable
class AuthenticatedState extends AuthState with AuthenticatedStateMappable {
  final Account account;

  const AuthenticatedState({
    required this.account,
  });
}
