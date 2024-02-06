part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {
  const LoginEvent();
}

class EmailAddressChangedEvent extends LoginEvent {
  final String emailAddress;

  const EmailAddressChangedEvent({required this.emailAddress});
}

class PasswordChangedEvent extends LoginEvent {
  final String password;

  const PasswordChangedEvent({required this.password});
}

class LoginButtonPressedEvent extends LoginEvent {
  const LoginButtonPressedEvent();
}
