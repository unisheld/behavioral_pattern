import 'package:behavioral_pattern/app/logger.dart';
import 'package:behavioral_pattern/presentation/auth/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AuthBlocProxy implements AuthBloc {
  final AuthBloc _inner;
  final Logger _logger;

  AuthBlocProxy({
    required AuthBloc inner,
    required Logger logger,
  })  : _inner = inner,
        _logger = logger {
    _logger.log('AuthBlocProxy: created');
  }

  @override
  Stream<AuthState> get stateStream {
    _logger.log('AuthBlocProxy: stateStream listened');
    return _inner.stateStream.doOnData((state) {
      _logger.log(
          'AuthBlocProxy: new AuthState -> isLoading=${state.isLoading}, error=${state.error}, registered=${state.registered}, signedIn=${state.signedIn}');
    });
  }

  @override
  AuthState get currentState {
    _logger.log('AuthBlocProxy: currentState requested');
    return _inner.currentState;
  }

  @override
  Stream<User?> get userStream {
    _logger.log('AuthBlocProxy: userStream accessed');
    return _inner.userStream;
  }

  @override
  Future<void> signIn(String email, String password) async {
    _logger.log('AuthBlocProxy: signIn called with email=$email');
    await _inner.signIn(email, password);
  }

  @override
  Future<void> register(String email, String password) async {
    _logger.log('AuthBlocProxy: register called with email=$email');
    await _inner.register(email, password);
  }

  @override
  void reset() {
    _logger.log('AuthBlocProxy: reset called');
    _inner.reset();
  }

  @override
  void dispose() {
    _logger.log('AuthBlocProxy: dispose called');
    _inner.dispose();
  }

  @override
  get registerUseCase => _inner.registerUseCase;

  @override
  get signInUseCase => _inner.signInUseCase;

  @override
  bool get isNewlyRegistered => _inner.isNewlyRegistered;

  @override
  set isNewlyRegistered(bool value) {
    _inner.isNewlyRegistered = value;
  }
}
