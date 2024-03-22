import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateLoggedIn extends AuthState {
  final User user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateLoggedOut extends AuthState {
  const AuthStateLoggedOut();
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

class AuthStateLoginFailure extends AuthState {
  final Exception exception;
  const AuthStateLoginFailure(this.exception);
}

class AuthStateLogoutFailure extends AuthState {
  final Exception exception;
  const AuthStateLogoutFailure(this.exception);
}
