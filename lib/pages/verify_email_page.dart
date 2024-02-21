import 'package:business_chat/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Email Verification")),
      body: Column(children: [
        Text("We've sent email verification"),
        Text("Click here to send email verification again"),
        TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null)
                await user.sendEmailVerification();
              else
                throw Exception("User not logged in");
            },
            child: Text("Send email verification")),
        TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((_) =>
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      registerPageRoute, (route) => false));
            },
            child: Text("restart"))
      ]),
    );
  }
}
