part of 'login_bloc.dart';

@MappableClass()
@immutable
class LoginState with LoginStateMappable {
  final String emailAddress;
  final String password;
  final LoginStatus status;

  const LoginState({
    this.emailAddress = "",
    this.password = "",
    this.status = LoginStatus.initial,
  });
}

enum LoginStatus {
  initial,
  loading,
  success,
  failed,
}
