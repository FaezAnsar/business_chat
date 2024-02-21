import 'package:business_chat/constants/routes.dart';
import 'package:business_chat/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
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
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Enter Password", labelText: "Password"),
          ),
          TextFormField(
            controller: _confirmPassword,
            autocorrect: false,
            enableSuggestions: false,
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Re-enter password", labelText: "Confirm password"),
          ),
          TextButton(
            onPressed: () async {
              final password = _password.text;
              final email = _email.text;
              final rePassword = _confirmPassword.text;

              if (password == rePassword) {
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
                final user = FirebaseAuth.instance.currentUser;

                await user?.sendEmailVerification();
                Navigator.of(context).pushNamed(verfifyPageRoute);
                print(userCredential);
              } else
                print("password not matched");
            },
            child: Text("Register"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginPageRoute, (route) => false);
              },
              child: Text("LogIn Here!"))
        ],
      ),
    );
  }
}
