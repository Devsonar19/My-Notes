import 'package:flutter/foundation.dart' show immutable;
import 'package:test_application/services/auth/auth_user.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText='Please Wait a Moment...',
  });
}

class AuthStateUninitialized extends AuthState{
  const AuthStateUninitialized({required bool isLoading}) : super(isLoading: isLoading);
}

class AuthStateRegistering extends AuthState with EquatableMixin{
  final Exception? exception;
  final bool isLoading;
  const AuthStateRegistering({required this.exception, required this.isLoading}) : super(isLoading: isLoading);

  @override
  List<Object?> get props => [exception, isLoading];
}

class AuthStateLoggedIn extends AuthState{
  final AuthUser user;
  const AuthStateLoggedIn({required this.user, required bool isLoading}) : super(isLoading: isLoading);
}

class AuthStateNeedsVerification extends AuthState{
  const AuthStateNeedsVerification({required bool isLoading}): super(isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin{
  final Exception? exception;
  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText})
      :super(
      isLoading: isLoading,
      loadingText: loadingText,
      );


  @override
  List<Object?> get props => [exception, isLoading];
}
