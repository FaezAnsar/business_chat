import 'package:business_chat/constants/routes.dart';
import 'package:business_chat/firebase_options.dart';
import 'package:business_chat/pages/landing_page.dart';
import 'package:business_chat/pages/login_page.dart';
import 'package:business_chat/pages/registration_page.dart';
import 'package:business_chat/pages/verify_email_page.dart';
import 'package:business_chat/providers/bloc/auth_bloc.dart';
import 'package:business_chat/providers/bloc/auth_event.dart';
import 'package:business_chat/providers/bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const LandingPage();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailPage();
        } else if (state is AuthStateLoggedOut) {
          return LoginPage();
        } else {
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
