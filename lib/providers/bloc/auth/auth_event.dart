import 'package:flutter/foundation.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogIn({required this.email, required this.password});
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  const AuthEventRegister(this.email, this.password);
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

// class AuthEventJoinRoom extends AuthEvent{
//   const AuthEventJoinRoom();
// }

class AuthEventForgotPassword extends AuthEvent {
  final String? email;
  const AuthEventForgotPassword({this.email});
}