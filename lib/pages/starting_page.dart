import 'package:business_chat/helpers/loading/loading_screen.dart';
import 'package:business_chat/pages/forgot_password_page.dart';
import 'package:business_chat/pages/landing_page.dart';
import 'package:business_chat/pages/login_page.dart';
import 'package:business_chat/pages/registration_page.dart';
import 'package:business_chat/pages/verify_email_page.dart';
import 'package:business_chat/providers/bloc/auth/auth_bloc.dart';
import 'package:business_chat/providers/bloc/auth/auth_event.dart';
import 'package:business_chat/providers/bloc/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          return LoadingScreen()
              .show(context: context, text: state.loadingText ?? ';()');
        } else {
          // print("hidee");
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          //print('lp');
          return const LandingPage();
        } else if (state is AuthStateNeedsVerification) {
          //print("j");
          return const VerifyEmailPage();
        } else if (state is AuthStateLoggedOut) {
          //print('redirecting');
          return LoginPage();
        } else if (state is AuthStateNeedsVerification) {
          return RegisterPage();
        } else if (state is AuthStateForgotPassword) {
          return ForgotPasswordPage();
        } else if (state is AuthStateRegistering) {
          //print("go to register");
          return RegisterPage();
        } else {
          //print("hhh");
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
