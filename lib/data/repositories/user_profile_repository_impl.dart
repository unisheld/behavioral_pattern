import 'package:behavioral_pattern/domain/entities/user_profile.dart';
import 'package:behavioral_pattern/domain/repositories/user_profile_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final FirebaseFirestore firestore;

  UserProfileRepositoryImpl(this.firestore);

  @override
  Future<UserProfile> fetchUserProfile(String userId) async {
    final doc = await firestore.collection('users').doc(userId).get();
    if (!doc.exists || doc.data() == null) {
      return const UserProfile(); // freezed классы обычно имеют константные конструкторы
    }
    return UserProfile.fromJson(doc.data()!);
  }

  @override
  Future<void> updateUserProfile(String userId, UserProfile profile) async {
    await firestore
        .collection('users')
        .doc(userId)
        .set(profile.toJson(), SetOptions(merge: true));
  }
}
