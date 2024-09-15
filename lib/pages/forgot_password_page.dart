import 'package:business_chat/error_dialogs/general_error_dialog.dart';
import 'package:business_chat/providers/bloc/auth/auth_bloc.dart';
import 'package:business_chat/providers/bloc/auth/auth_event.dart';
import 'package:business_chat/providers/bloc/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthStateForgotPassword) {
            if (state.hasSentEmail) {
              _controller.clear();
              await showErrorDialog(context, "Email sent");
            }

            if (state.exception != null) {
              await showErrorDialog(context, state.exception.toString());
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              TextField(
                controller: _controller,
                autocorrect: false,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: "Email..."),
              ),
              TextButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(AuthEventForgotPassword(email: _controller.text));
                  },
                  child: Text("Send reset link")),
              TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthEventLogOut());
                  },
                  child: Text("Back to login"))
            ],
          ),
        ));
  }
}
