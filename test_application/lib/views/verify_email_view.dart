import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_application/constants/routes.dart';
import 'package:test_application/services/auth/auth_service.dart';

import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';

//VERIFY EMAIL VIEW
class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        child:
          Stack(
            children: [
                Positioned.fill(
                child: Image.asset(
                    'assets/images/verify_email_view_background.jpg',
                    fit: BoxFit.cover
                  ),
                ),
                Positioned.fill(
                child: Container(
                color: Colors.black.withValues(alpha: 0.5),
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
                        height: 350,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                              "Email Verification Link has been Delivered, Please open link to Verify Account",
                              style: GoogleFonts.ooohBaby(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.white,
                              ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 80.0,
                          width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'If you have not received the email, click the button below to send it again',
                              style: GoogleFonts.handlee(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80.0,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'If you have already verified your email, go back and Login',
                              style: GoogleFonts.handlee(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white
                              )
                          ),
                        ),
                      ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: HexColor('FDEB9E'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: ()  {
                        context.read<AuthBloc>().add(
                            const AuthEventSendEmailVerification(),
                        );
                      }, child: const Text('Send Again', style: TextStyle(fontSize: 20))
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: HexColor('F6F6F6'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                          onPressed: () async{
                            context.read<AuthBloc>().add(
                                const AuthEventLogOut(),
                            );
                          },
                          child: const Text('Back to Login', style: TextStyle(fontSize: 20)),
                      ),
                    )
                  ],
                  ),
                ),
              ),
              ),
            ],
          ),
    );
  }
}