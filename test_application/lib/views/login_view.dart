import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/services/auth/bloc/auth_bloc.dart';
import 'package:test_application/services/auth/bloc/auth_event.dart';
import 'package:test_application/services/auth/bloc/auth_state.dart';
import 'package:test_application/utilities/dialogs/loading_dialog.dart';
import '../constants/routes.dart';
import '../services/auth/auth_exceptions.dart';
import '../utilities/dialogs/error_dialog.dart';


//LOGIN VIEW
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late final TextEditingController _email;
  late final TextEditingController _password;
  CloseDialog? _closeDialogHandle;

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async{
        // if(state is AuthStateLoggedOut){
        //
        //   final closeDialog= _closeDialogHandle;
        //
        //   if(!state.isLoading && closeDialog!=null){
        //     closeDialog();
        //     _closeDialogHandle=null;
        //   }else if(state.isLoading && closeDialog==null){
        //     _closeDialogHandle= showLoadingDialog(
        //       context: context,
        //       text: 'Loading...',
        //     );
        //   }
        // }

        final closeDialog=_closeDialogHandle;
        // SHOW loading(modified)
        if (state is AuthStateLoggedOut) {

          if (closeDialog == null) {
            _closeDialogHandle = showLoadingDialog(
              context: context,
              text: 'Loading...',
            );
          }
          return;
        }
        // CLOSE loading for all non-loading states
        if (closeDialog != null) {
          closeDialog();
          _closeDialogHandle = null;
        }



        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context, 'User not found');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong credentials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login View'),),
        body: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter Your Email: ',
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Enter Your Password: ',
              ),
            ),
            TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  context.read<AuthBloc>().add(
                    AuthEventLogIn(
                      email,
                      password,
                    ),
                  );
                },
                child: const Text('Login'),
              ),
            TextButton(
              onPressed: () {
                //To registerRoute
                context.read<AuthBloc>().add(
                    const AuthEventShouldRegister()
                );
              }, child: const Text('Not Registered? Register Here'),
            ),
          ],
        ),
      ),
    );
  }
}
