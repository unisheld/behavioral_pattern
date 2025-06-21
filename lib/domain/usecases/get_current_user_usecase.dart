import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  User? call() => repository.currentUser;
}
