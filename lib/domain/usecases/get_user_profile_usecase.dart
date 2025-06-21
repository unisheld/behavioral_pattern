import 'package:behavioral_pattern/domain/entities/user_profile.dart';
import 'package:behavioral_pattern/domain/repositories/user_profile_repository.dart';

class GetUserProfileUseCase {
  final UserProfileRepository repository;
  GetUserProfileUseCase(this.repository);

  Future<UserProfile> call(String userId) => repository.fetchUserProfile(userId);
}

class UpdateUserProfileUseCase {
  final UserProfileRepository repository;
  UpdateUserProfileUseCase(this.repository);

  Future<void> call(String userId, UserProfile profile) =>
      repository.updateUserProfile(userId, profile);
}
