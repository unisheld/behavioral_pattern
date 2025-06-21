import 'package:behavioral_pattern/domain/entities/user_profile.dart';
import 'package:behavioral_pattern/domain/usecases/get_user_profile_usecase.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;
  final String userId;

  final BehaviorSubject<UserProfile?> _profileController =
      BehaviorSubject<UserProfile?>();
  Stream<UserProfile?> get profileStream => _profileController.stream;

  ProfileBloc({
    required this.getUserProfileUseCase,
    required this.updateUserProfileUseCase,
    required this.userId,
  }) {
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final profile = await getUserProfileUseCase.call(userId);
      _profileController.add(profile);
    } catch (e) {
      _profileController.addError(e);
    }
  }

  Future<void> updateProfile(UserProfile updatedProfile) async {
    try {
      await updateUserProfileUseCase.call(userId, updatedProfile);
      _profileController.add(updatedProfile);
    } catch (e) {
      _profileController.addError(e);
    }
  }

  void dispose() {
    _profileController.close();
  }

  Future<void> reload() async {
    await _loadUserProfile();
  }
}
