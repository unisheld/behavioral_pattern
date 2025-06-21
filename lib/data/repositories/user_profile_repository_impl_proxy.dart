import 'package:behavioral_pattern/app/logger.dart';
import 'package:behavioral_pattern/domain/entities/user_profile.dart';
import 'package:behavioral_pattern/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryProxy implements UserProfileRepository {
  final UserProfileRepository _inner;
  final Logger _logger;

  UserProfileRepositoryProxy({
    required UserProfileRepository inner,
    required Logger logger,
  })  : _inner = inner,
        _logger = logger;

  @override
  Future<UserProfile> fetchUserProfile(String userId) async {
    _logger.log('Fetching user profile for userId="$userId"');
    try {
      final profile = await _inner.fetchUserProfile(userId);
      _logger.log('Fetched user profile: ${profile.toJson()}');
      return profile;
    } catch (e) {
      _logger.log('Error fetching user profile: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateUserProfile(String userId, UserProfile profile) async {
    _logger.log('Updating user profile for userId="$userId" with ${profile.toJson()}');
    try {
      await _inner.updateUserProfile(userId, profile);
      _logger.log('User profile updated');
    } catch (e) {
      _logger.log('Error updating user profile: $e');
      rethrow;
    }
  }
}
