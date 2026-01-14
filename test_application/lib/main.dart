import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/helpers/loading/loading_screen.dart';
import 'package:test_application/services/auth/bloc/auth_bloc.dart';
import 'package:test_application/services/auth/bloc/auth_event.dart';
import 'package:test_application/services/auth/bloc/auth_state.dart';
import 'package:test_application/services/auth/firebase_auth_provider.dart';
import 'package:test_application/views/forgot_password_view.dart';
import 'package:test_application/views/login_view.dart';
import 'package:test_application/views/notes/create_update_note_view.dart';
import 'package:test_application/views/notes/notes_view.dart';
import 'package:test_application/views/register_view.dart';
import 'package:test_application/views/verify_email_view.dart';
import 'constants/routes.dart';
import 'firebase_options.dart';


//MAIN FUNCTION
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        createOrUpdateNoteRoute: (context)=> CreateUpdateNoteView(),
      },
    ),
  );
}

//HomePage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state){
        if(state.isLoading){
          LoadingScreen().show(
              context: context,
              text: state.loadingText ?? 'Please wait a Moment'
          );
        }else{
          LoadingScreen().hide();
        }
      },
        builder: (context, state){
      if(state is AuthStateLoggedIn){
        return const NotesView();
      }else if(state is AuthStateNeedsVerification){
        return const VerifyEmailView();
      }else if( state is AuthStateLoggedOut){
        return const LoginView();
      }else if(state is AuthStateForgotPassword){
        return const ForgotPasswordView();
      } else if(state is AuthStateRegistering){
        return const RegisterView();
      } else{
        return Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    });
  }
}
