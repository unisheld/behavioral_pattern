import 'package:behavioral_pattern/domain/usecases/register_usecase.dart';
import 'package:behavioral_pattern/domain/usecases/sign_in_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final bool registered;
  final bool signedIn;

  AuthState({
    this.isLoading = false,
    this.error,
    this.registered = false,
    this.signedIn = false,
  });
}

class AuthBloc {
  final SignInUseCase signInUseCase;
  final RegisterUseCase registerUseCase;

  final _stateController = BehaviorSubject<AuthState>.seeded(AuthState());
  Stream<AuthState> get stateStream => _stateController.stream;
  AuthState get currentState => _stateController.value;

  Stream<User?> get userStream => FirebaseAuth.instance.authStateChanges();

  bool _isClosed = false;
  bool isNewlyRegistered = false;

  AuthBloc(this.signInUseCase, this.registerUseCase) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        reset();
      } else {
        _stateController.add(AuthState(isLoading: false, signedIn: true));
      }
    });
  }

  Future<void> signIn(String email, String password) async {
    if (_isClosed) return;
    _stateController.add(AuthState(isLoading: true));
    try {
      await signInUseCase.call(email, password);
      isNewlyRegistered = false;
      if (_isClosed) return;
      _stateController.add(AuthState(isLoading: false, signedIn: true));
    } catch (e) {
      if (_isClosed) return;
      _stateController.add(AuthState(isLoading: false, error: e.toString()));
    }
  }

  Future<void> register(String email, String password) async {
    if (_isClosed) return;
    _stateController.add(AuthState(isLoading: true));
    try {
      await registerUseCase.call(email, password);
      isNewlyRegistered = true;
      if (_isClosed) return;
      _stateController.add(AuthState(isLoading: false, registered: true));
    } catch (e) {
      if (_isClosed) return;
      _stateController.add(AuthState(isLoading: false, error: e.toString()));
    }
  }

  void reset() {
    isNewlyRegistered = false;
    _stateController.add(AuthState());
  }

  void dispose() {
    _isClosed = true;
    _stateController.close();
  }
}
