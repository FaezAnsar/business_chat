import 'package:business_chat/constants/routes.dart';
import 'package:business_chat/firebase_options.dart';
import 'package:business_chat/pages/landing_page.dart';
import 'package:business_chat/pages/login_page.dart';
import 'package:business_chat/pages/registration_page.dart';
import 'package:business_chat/pages/verify_email_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return LandingPage();
              }
              return VerifyEmailPage();
            }
            return LoginPage();
          default:
            return CircularProgressIndicator();
        }
      },
    );
  }
}
