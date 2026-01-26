import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_application/services/auth/auth_service.dart';
import 'package:test_application/services/auth/bloc/auth_state.dart';

import '../constants/routes.dart';
import '../services/auth/auth_exceptions.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';
import '../utilities/dialogs/error_dialog.dart';


//REGISTRATION VIEW
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    child:  BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if(state.exception is WeakPasswordAuthException){
            await showErrorDialog(context, 'Weak password');
          }else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email is already in use');
          }else if(state.exception is GenericAuthException){
            await showErrorDialog(context, 'Failed to register');
          }else if(state.exception is InvalidEmailAuthException){
            await showErrorDialog(context, 'Invalid email');
          }
        }
      },
      child: Stack(
        children:[
          Positioned.fill(
              child: Image.asset(
                'assets/images/register_view_background.jpg',
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 490.0,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        'Register\nTo Start\nYour Journey',
                        style: GoogleFonts.ooohBaby(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Register to Embark on Your Journey...',
                          style: GoogleFonts.ooohBaby(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white
                          )
                      ),
                    ),
                  ),
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Enter Email',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.email_rounded, color: Colors.white,),
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.birthstone().fontFamily,
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
                  const SizedBox(height: 15.0),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Enter Your Password: ',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.password_rounded, color: Colors.white,),
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
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                          onPressed: () async {
                            final email = _email.text;
                            final password = _password.text;
                            context.read<AuthBloc>().add(
                              AuthEventRegister(
                                email,
                                password,
                              ),
                            );
                            const Text('Register on Clicking');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor('B6AE9F'),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                          ),child: const Text('Register Here', style: TextStyle(fontSize: 20))
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        //To loginRoute
                        context.read<AuthBloc>().add(
                          const AuthEventLogOut(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('EFE9E3'),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text('Already Registered? Login Here', style: TextStyle(fontSize: 20)),
                    ),
                  )
                ],
              ),
            ),
          ),
          ),
        ],
      ),
      ),
    );
  }
}