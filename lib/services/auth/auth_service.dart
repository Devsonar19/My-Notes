import 'auth_provider.dart';
import 'auth_user.dart';

class AuthService implements AuthProvider{
  final AuthProvider provider;
  const AuthService(this.provider);

  //Create User
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password
  }) => provider.createUser(
      email: email,
      password: password
  );

  //Current User
  @override
    AuthUser? get currentUser => provider.currentUser;


  //User Login
  @override
  Future<AuthUser> logIn({
    required String email,
    required String password
  })=> provider.logIn(
      email: email,
      password: password
  );

  //User Logout
  @override
  Future<void> logOut() => provider.logOut();

  //Send Verification Email
  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

}