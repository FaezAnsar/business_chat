// import 'package:business_chat/providers/bloc/auth/auth_bloc.dart';
// import 'package:business_chat/providers/bloc/auth/auth_event.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class VerifyEmailPage extends StatelessWidget {
//   const VerifyEmailPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Email Verification")),
//       body: Column(children: [
//         Text("We've sent email verification"),
//         Text("Click here to send email verification again"),
//         TextButton(
//             onPressed: () async {
//               final user = FirebaseAuth.instance.currentUser;
//               if (user != null)
//                 await user.sendEmailVerification();
//               else
//                 throw Exception("User not logged in");
//             },
//             child: Text("Send email verification")),
//         TextButton(
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut().then((_) =>
//                   context.read<AuthBloc>().add(AuthEventShouldRegister()));
//             },
//             child: Text("restart"))
//       ]),
//     );
//   }
// }
import 'package:business_chat/providers/bloc/auth/auth_bloc.dart';
import 'package:business_chat/providers/bloc/auth/auth_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(20),
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
                // Title Text
                Text(
                  "Verify Your Email",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Information text
                Text(
                  "We've sent you an email for verification.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  "If you didn't receive an email, click below to send again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),

                // Resend Verification Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.blue.shade600,
                  ),
                  onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await user.sendEmailVerification();
                    } else {
                      throw Exception("User not logged in");
                    }
                  },
                  child: Text(
                    "Resend Email Verification",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // Restart Button (sign-out and restart)
                TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut().then(
                          (_) => context
                              .read<AuthBloc>()
                              .add(AuthEventShouldRegister()),
                        );
                  },
                  child: Text(
                    "Restart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
