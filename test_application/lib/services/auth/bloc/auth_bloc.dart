import 'package:bloc/bloc.dart';
import 'package:test_application/services/auth/bloc/auth_event.dart';
import 'package:test_application/services/auth/bloc/auth_state.dart';

import '../auth_provider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()){
    
    on<AuthEventShouldRegister>((event, emit) {
      emit(const AuthStateRegistering(exception: null, isLoading: false));
    });
    on<AuthEventSendEmailVerification>((event, emit)async{
      await provider.sendEmailVerification();
      emit(state);
    });

    on<AuthEventRegister>((event, emit)async{
      emit(const AuthStateRegistering(exception: null, isLoading: true));
      final email=event.email;
      final password= event.password;

      try{
        await provider.createUser(
            email: email,
            password: password
        );
        await provider.sendEmailVerification();
        emit(const AuthStateNeedsVerification());
      }on Exception catch(e){
        emit(AuthStateRegistering(exception: e, isLoading: false));
      }
    });
    
    on<AuthEventInitialize>((event, emit)async{
      await provider.initialize();
      final user= provider.currentUser;
      if(user==null){
        emit(
          const AuthStateLoggedOut(
              exception: null,
              isLoading: false
          ),
        );
      }else if(!user.isEmailVerified){
        emit(const AuthStateNeedsVerification());
      }else {
        emit(AuthStateLoggedIn(user));
      }
    });

    //Log In
    on<AuthEventLogIn>((event, emit) async {
      emit(
        const AuthStateLoggedOut(
          exception: null,
            isLoading: true,
        ),
      );
      final email=event.email;
      final password= event.password;
      try{
        final user= await provider.logIn(
          email: email,
          password: password,
        );

        if(!user.isEmailVerified){
          emit(
            const AuthStateLoggedOut(
              exception: null,
              isLoading: false
            ),
          );
          emit(const AuthStateNeedsVerification());
        }else{
          const AuthStateLoggedOut(
              exception: null,
              isLoading: false
          );
          emit(AuthStateLoggedIn(user));
        }

        emit(AuthStateLoggedIn(user));
      }on Exception catch(e){
        emit(
          AuthStateLoggedOut(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });
    //Log Out
    on<AuthEventLogOut>((event, emit)async{
      try{
        await provider.logOut();
        emit(
          const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ),
        );
      }on Exception catch(e){
        emit(
          AuthStateLoggedOut(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });
  }
}
