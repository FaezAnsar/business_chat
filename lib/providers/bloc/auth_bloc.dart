import 'package:business_chat/firebase_options.dart';
import 'package:business_chat/providers/bloc/auth_event.dart';
import 'package:business_chat/providers/bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLoading()) {
    on<AuthEventLogIn>(
      (event, emit) async {
        emit(const AuthStateLoading());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);

          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            emit(AuthStateLoggedIn(user));
          } else {
            throw Exception();
          }
        } on Exception catch (e) {
          emit(AuthStateLoginFailure(e));
        }
      },
    );
    on<AuthEventInitialize>(
      (event, emit) async {
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(const AuthStateLoggedOut());
        } else if (!user.emailVerified) {
          emit(const AuthStateNeedsVerification());
        } else {
          emit(AuthStateLoggedIn(user));
        }
      },
    );
    on<AuthEventLogOut>((event, emit) async {
      try {
        emit(const AuthStateLoading());
        await FirebaseAuth.instance.signOut();
        emit(const AuthStateLoggedOut());
        print("emiited logout");
      } on Exception catch (e) {
        emit(AuthStateLogoutFailure(e));
      }
    });
  }
}
