import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
        )
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        child:
        BlocListener<AuthBloc, AuthState>(
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
      child: Stack(
        children:[
          Positioned.fill(
            child: Image.asset(
                'assets/images/forgot_password_view_background.jpg',
                fit: BoxFit.cover
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.6),
            ),
          ),
          Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 500.0,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                          'Forgot Password ?\nNo Worries',
                        style: GoogleFonts.ooohBaby(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 40,
                    width: double.infinity,
                    child: Text(
                        'Enter Your Email to Get A Reset Link',
                      style: GoogleFonts.ooohBaby(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autofocus: true,
                    controller: _controller,
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.email_rounded, color: Colors.white,),
                      labelStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.birthstone().fontFamily,
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: (){
                          final email= _controller.text;
                          context
                              .read<AuthBloc>()
                              .add(AuthEventForgotPassword(email: email));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor('16476A'),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text('Send Link', style: TextStyle(fontSize: 20)),

                    ),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                          context.read<AuthBloc>().add(
                            const AuthEventLogOut(),
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('2F5755'),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text('Back', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],

              ),
            ),
          ),

        ),
        ]
      ),
    ),
    );
  }
}
