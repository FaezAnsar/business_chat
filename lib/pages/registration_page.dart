// import 'package:business_chat/error_dialogs/general_error_dialog.dart';
// import 'package:business_chat/providers/bloc/auth/auth_bloc.dart';
// import 'package:business_chat/providers/bloc/auth/auth_event.dart';
// import 'package:business_chat/providers/bloc/auth/auth_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class RegisterPage extends StatelessWidget {
//   RegisterPage({super.key});

//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _password = TextEditingController();
//   final TextEditingController _confirmPassword = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) async {
//         if (state is AuthStateRegistering) {
//           await showErrorDialog(context, state.exception.toString());
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(),
//         body: Column(
//           children: [
//             TextFormField(
//               controller: _email,
//               decoration: InputDecoration(
//                   hintText: "Enter  Email", labelText: "Your Email"),
//             ),
//             TextFormField(
//               controller: _password,
//               keyboardType: TextInputType.emailAddress,
//               obscureText: true,
//               decoration: InputDecoration(
//                   hintText: "Enter Password", labelText: "Password"),
//             ),
//             TextFormField(
//               controller: _confirmPassword,
//               autocorrect: false,
//               enableSuggestions: false,
//               obscureText: true,
//               decoration: InputDecoration(
//                   hintText: "Re-enter password", labelText: "Confirm password"),
//             ),
//             TextButton(
//               onPressed: () async {
//                 final password = _password.text;
//                 final email = _email.text;
//                 final rePassword = _confirmPassword.text;

//                 if (password == rePassword) {
//                   context.read<AuthBloc>().add(
//                         AuthEventRegister(
//                           email,
//                           password,
//                         ),
//                       );
//                 } else {
//                   await showErrorDialog(context, "PasswordNotMatched");
//                 }
//               },
//               child: Text("Register"),
//             ),
//             TextButton(
//                 onPressed: () {
//                   context.read<AuthBloc>().add(
//                         AuthEventLogOut(),
//                       );
//                 },
//                 child: Text("LogIn Here!"))
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';

import 'package:business_chat/error_dialogs/general_error_dialog.dart';
import 'package:business_chat/providers/bloc/auth/auth_bloc.dart';
import 'package:business_chat/providers/bloc/auth/auth_event.dart';
import 'package:business_chat/providers/bloc/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        log(state.toString());
        if (state is AuthStateRegistering) {
          await showErrorDialog(context, state.exception.toString());
        }
        if (state is AuthStateLoggedOut) {}
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // Add a gradient background for visual appeal
        body: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.blue.shade800],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add a logo or title at the top
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40),
                  // Email field with styling
                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.white),
                      hintText: "Enter Email",
                      //labelText: "Your Email",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  // Password field with styling
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      hintText: "Enter Password",
                      //labelText: "Password",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _confirmPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      hintText: "Re-Enter Password",
                      //labelText: "Password",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Register  Button with rounded corners
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.blue.shade600,
                    ),
                    onPressed: () async {
                      final password = _password.text;
                      final email = _email.text;
                      final rePassword = _confirmPassword.text;

                      if (password == rePassword) {
                        context.read<AuthBloc>().add(
                              AuthEventRegister(
                                email,
                                password,
                              ),
                            );
                      } else {
                        await showErrorDialog(context, "PasswordNotMatched");
                      }
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Register and Forgot Password buttons with more emphasis
                  TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            AuthEventLogOut(),
                          );
                    },
                    child: Text(
                      'Login Here!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
