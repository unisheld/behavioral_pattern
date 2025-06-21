import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signIn(String email, String password);
  Future<User?> register(String email, String password);
  Future<void> signOut();
  User? get currentUser;
  Stream<User?> authStateChanges();
}
