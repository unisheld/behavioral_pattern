import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(this.firebaseAuth);

  @override
  Future<User?> signIn(String email, String password) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  @override
  Future<void> signOut() => firebaseAuth.signOut();

  @override
  User? get currentUser => firebaseAuth.currentUser;

  @override
  Stream<User?> authStateChanges() => firebaseAuth.authStateChanges();

  @override
Future<User?> register(String email, String password) async {
  final credential = await firebaseAuth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  return credential.user;
}

}
