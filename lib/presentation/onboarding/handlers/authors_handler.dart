import 'package:behavioral_pattern/domain/entities/user_profile.dart';
import 'package:behavioral_pattern/domain/usecases/get_user_profile_usecase.dart';

import 'package:behavioral_pattern/presentation/onboarding/handlers/onboarding_handler.dart';
import 'package:behavioral_pattern/presentation/onboarding/screens/authors_screen.dart';
import 'package:flutter/material.dart';

class AuthorsHandler extends OnboardingHandler {
  final UpdateUserProfileUseCase updateUserProfileUseCase;
  final String userId;

  AuthorsHandler({
    required this.updateUserProfileUseCase,
    required this.userId,
  });

  @override
  Future<void> handle(BuildContext context, OnboardingStepData data) async {
    final selectedAuthors = await Navigator.of(context).push<List<String>>(
      MaterialPageRoute(
        builder: (_) => AuthorsScreen(
          selectedAuthors: data.authors,
        ),
      ),
    );

    if (selectedAuthors != null) {
      data = data.copyWith(authors: selectedAuthors);
    }

    final profileToSave = UserProfile(
      name: data.name,
      birthday: data.birthday,
      categories: data.categories,
      authors: data.authors,
    );

    await updateUserProfileUseCase.call(userId, profileToSave);

    if (next != null) {
      await next!.handle(context, data);
    }
  }
}
