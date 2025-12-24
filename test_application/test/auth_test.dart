import 'package:test/test.dart';
import 'package:test_application/services/auth/auth_exceptions.dart';
import 'package:test_application/services/auth/auth_provider.dart';
import 'package:test_application/services/auth/auth_user.dart';

void main() {
  group('Mock Test Authentication', () {
    late MockAuthProvider provider;

    setUp(() {
      provider = MockAuthProvider();
    });

    test('Should not be initialized to begin with', () {
      expect(provider.isInitialized, false);
    });

    test('Cannot log out if not initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });

    test('Should be able to be initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('User should be null after initialization', () async {
      await provider.initialize();
      expect(provider.currentUser, null);
    });

    test(
      'Should be able to initialize in less than 2 seconds',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    test('Create user should delegate to login function', () async {
      await provider.initialize();
      expect(
        provider.createUser(email: 'xyzzz@gmail.com', password: '123456'),
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );
      expect(
        provider.createUser(email: 'xyz@gmail.com', password: '12345'),
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );

      final user = await provider.createUser(email: 'xyz', password: '123');
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('Logged in user should be able to get verified', () async {
      await provider.initialize();
      await provider.logIn(email: 'test@test.com', password: 'password');
      await provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('Should be able to log out and log in again', () async {
      await provider.initialize();
      await provider.logIn(email: 'email', password: 'password');
      await provider.logOut();
      expect(provider.currentUser, isNull);
      final user = await provider.logIn(email: 'email', password: 'password');
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  var _isInitialized = false;
  @override
  bool get isInitialized => _isInitialized;
  AuthUser? _user;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'xyz@gmail.com') throw UserNotFoundAuthException();
    if (password == '123456') throw WrongPasswordAuthException();
    final user = AuthUser(isEmailVerified: false, email: 'something@gmail.com');
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotLoggedInAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotLoggedInAuthException();
    final newUser = AuthUser(isEmailVerified: true, email: 'something@gmail.com');
    _user = newUser;
  }

  @override
  String get providerId => 'mock';
}
