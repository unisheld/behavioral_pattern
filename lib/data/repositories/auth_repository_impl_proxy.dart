import 'package:firebase_auth/firebase_auth.dart';
import 'package:behavioral_pattern/app/logger.dart';
import 'package:behavioral_pattern/domain/repositories/auth_repository.dart';

class AuthRepositoryProxy implements AuthRepository {
  final AuthRepository _inner;
  final Logger _logger;

  AuthRepositoryProxy({
    required AuthRepository inner,
    required Logger logger,
  })  : _inner = inner,
        _logger = logger;

  @override
  Future<User?> signIn(String email, String password) async {
    _logger.log('signIn: email="$email"');
    try {
      final user = await _inner.signIn(email, password);
      _logger.log('signIn successful: uid=${user?.uid}');
      return user;
    } catch (e) {
      _logger.log('signIn error: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    _logger.log('signOut called');
    try {
      await _inner.signOut();
      _logger.log('signOut successful');
    } catch (e) {
      _logger.log('signOut error: $e');
      rethrow;
    }
  }

  @override
  User? get currentUser {
    final user = _inner.currentUser;
    _logger.log('currentUser: ${user?.email ?? "null"}');
    return user;
  }

  @override
  Stream<User?> authStateChanges() {
    _logger.log('authStateChanges stream subscribed');
    return _inner.authStateChanges();
  }

  @override
  Future<User?> register(String email, String password) async {
    _logger.log('register: email="$email"');
    try {
      final user = await _inner.register(email, password);
      _logger.log('register successful: uid=${user?.uid}');
      return user;
    } catch (e) {
      _logger.log('register error: $e');
      rethrow;
    }
  }
}
