import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:test_application/services/auth/auth_service.dart';
import 'package:test_application/views/login_view.dart';
import 'package:test_application/views/notes/new_notes_view.dart';
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
      home: const HomePage(),
      routes: {
        loginRoute: (context)=> LoginView(),
        registerRoute: (context)=> RegisterView(),
        notesRoute: (context)=>NotesView(),
        verifyEmailRoute: (context)=> VerifyEmailView(),
        newNotesRoute: (context)=> NewNotesView(),
      },

    ),
  );
}

//HomePage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
          final user= AuthService.firebase().currentUser;
          if(user!=null){
            if(user.isEmailVerified){
              return const NotesView();
            }else{
              return const VerifyEmailView();
            }
          }else{
            return const LoginView();
          }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}