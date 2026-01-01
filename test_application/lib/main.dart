import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/services/auth/bloc/auth_bloc.dart';
import 'package:test_application/services/auth/bloc/auth_event.dart';
import 'package:test_application/services/auth/bloc/auth_state.dart';
import 'package:test_application/services/auth/firebase_auth_provider.dart';
import 'package:test_application/views/login_view.dart';
import 'package:test_application/views/notes/create_update_note_view.dart';
import 'package:test_application/views/notes/notes_view.dart';
import 'package:test_application/views/register_view.dart';
import 'package:test_application/views/verify_email_view.dart';
import 'constants/routes.dart';


//MAIN FUNCTION
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        loginRoute: (context)=> LoginView(),
        registerRoute: (context)=> RegisterView(),
        notesRoute: (context)=>NotesView(),
        verifyEmailRoute: (context)=> VerifyEmailView(),
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
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state){
      if(state is AuthStateLoggedIn){
        return const NotesView();
      }else if(state is AuthStateNeedsVerification){
        return const VerifyEmailView();
      }else if( state is AuthStateLoggedOut){
        return const LoginView();
      }else{
        return Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    });
  }
}
