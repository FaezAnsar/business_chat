import 'package:business_chat/firebase_options.dart';
import 'package:business_chat/providers/bloc/auth/auth_event.dart';
import 'package:business_chat/providers/bloc/auth/auth_state.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateUninitialized(isLoading: true)) {
    on<AuthEventLogIn>(
      (event, emit) async {
        emit(AuthStateLoggedOut(
            exception: null, isLoading: true, loadingText: 'logging in..'));
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);

          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            if (!user.emailVerified) {
              emit(AuthStateLoggedOut(exception: null, isLoading: false));
              emit(AuthStateNeedsVerification(isLoading: false));
            } else {
              emit(AuthStateLoggedOut(exception: null, isLoading: false));
              emit(AuthStateLoggedIn(user: user, isLoading: false));
            }
          } else {
            throw Exception();
          }
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(exception: e, isLoading: false));
        }
      },
    );
    on<AuthEventInitialize>(
      (event, emit) async {
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
        } else if (!user.emailVerified) {
          emit(const AuthStateNeedsVerification(isLoading: false));
        } else {
          emit(AuthStateLoggedIn(user: user, isLoading: false));
        }
      },
    );
    on<AuthEventLogOut>(
      (event, emit) async {
        try {
          emit(const AuthStateLoggedOut(exception: null, isLoading: true));
          await FirebaseAuth.instance.signOut();
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          print("emiited logout");
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(exception: e, isLoading: false));
        }
      },
    );
    on<AuthEventRegister>(
      (event, emit) async {
        try {
          final email = event.email;
          final password = event.password;
          final user = (await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: email, password: password))
              .user;
          if (user != null) {
            user.sendEmailVerification();
            emit(const AuthStateNeedsVerification(isLoading: false));
          } else {
            throw Exception("No User");
          }
        } on Exception catch (e) {
          emit(AuthStateRegistering(isLoading: false, exception: e));
        }
      },
    );
    on<AuthEventSendEmailVerification>(
      (event, emit) async {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        emit(state);
      },
    );
    on<AuthEventForgotPassword>((event, emit) async {
      emit(AuthStateForgotPassword(
          exception: null, hasSentEmail: false, isLoading: false));
      final email = event.email;
      if (email == null) {
        return;
      }
      emit(AuthStateForgotPassword(
          exception: null, hasSentEmail: false, isLoading: true));
      bool hasSentEmail;
      Exception? exception;
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        hasSentEmail = true;
        exception = null;
      } on FirebaseAuthException catch (e) {
        hasSentEmail = false;
        exception = e;
      }
      print(hasSentEmail.toString());
      emit(AuthStateForgotPassword(
          exception: exception, hasSentEmail: hasSentEmail, isLoading: false));
    });
    on<AuthEventShouldRegister>((event, emit) {
      emit(AuthStateRegistering(exception: null, isLoading: false));
    });
  }
}
