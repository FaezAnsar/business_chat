import 'package:business_chat/constants/routes.dart';
import 'package:business_chat/firebase_options.dart';
import 'package:business_chat/main.dart';
import 'package:business_chat/pages/verify_email_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                  hintText: "Enter  Email", labelText: "Your Email"),
            ),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                  hintText: "Enter Password", labelText: "Password"),
            ),
            TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  print(email);
                  print(password);
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email, password: password);
                    final user = await FirebaseAuth.instance.currentUser;
                    if (user?.emailVerified ?? false)
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          landingPageRoute, (route) => false);
                    else
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          verfifyPageRoute, (route) => false);
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Login")),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    registerPageRoute, (route) => false);
              },
              child: Text("New?Register Here!"),
            )
          ],
        ));
  }
}
