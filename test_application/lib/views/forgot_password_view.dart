import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/services/auth/bloc/auth_bloc.dart';
import 'package:test_application/services/auth/bloc/auth_state.dart';
import 'package:test_application/utilities/dialogs/password_reset_email_sent_dialog.dart';

import '../services/auth/bloc/auth_event.dart';
import '../utilities/dialogs/error_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
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
          if(state is AuthStateForgotPassword){
            if(state.hasSentEmail){
              _controller.clear();
              await showPasswordResetSentDialog(context);
            }
            if(state.exception!=null){
              await showErrorDialog(context, 'Could not process request, Make sure you are Registered');
            }
          }
        },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50.0,
                child: Text('If you Forgot your Password, enter your email below to receive a password reset link'),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter Your Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: (){
                    final email= _controller.text;
                    context
                        .read<AuthBloc>()
                        .add(AuthEventForgotPassword(email: email));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Send Link'),

              ),
              ElevatedButton(
                onPressed: (){
                    context.read<AuthBloc>().add(
                      const AuthEventLogOut(),
                    );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Back'),
              ),
            ],

          ),
        ),
        
      ),
    );
  }
}
