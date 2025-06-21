import 'package:behavioral_pattern/domain/entities/user_profile.dart';

abstract class UserProfileRepository {
  Future<UserProfile> fetchUserProfile(String userId);
  Future<void> updateUserProfile(String userId, UserProfile profile);
}
