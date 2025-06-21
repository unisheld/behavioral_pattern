import 'package:behavioral_pattern/presentation/profile/profile_bloc.dart';
import 'package:behavioral_pattern/domain/entities/user_profile.dart';
import 'package:behavioral_pattern/app/logger.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBlocProxy implements ProfileBloc {
  final ProfileBloc _inner;
  final Logger _logger;

  ProfileBlocProxy(this._inner, this._logger) {
    _logger.log('ProfileBlocProxy created');
  }

  
  @override
  get getUserProfileUseCase => _inner.getUserProfileUseCase;

  @override
  get updateUserProfileUseCase => _inner.updateUserProfileUseCase;

  @override
  String get userId => _inner.userId;

  @override
  Stream<UserProfile?> get profileStream {
    _logger.log('profileStream listened');
    return _inner.profileStream.doOnData((profile) {
      _logger.log('New profile data: $profile');
    });
  }

  @override
  Future<void> updateProfile(UserProfile profile) async {
    _logger.log('updateProfile called');
    await _inner.updateProfile(profile);
    _logger.log('updateProfile done');
  }

  @override
  Future<void> reload() async {
    _logger.log('reload called');
    await _inner.reload();
    _logger.log('reload done');
  }

  @override
  void dispose() {
    _logger.log('dispose called');
    _inner.dispose();
  }
}
