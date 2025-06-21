import 'package:behavioral_pattern/presentation/onboarding/screens/authors_screen.dart';
import 'package:behavioral_pattern/presentation/onboarding/screens/birthday_screen.dart';
import 'package:behavioral_pattern/presentation/onboarding/screens/categories_screen.dart';
import 'package:behavioral_pattern/presentation/onboarding/screens/name_screen.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/user_profile.dart';

Future<UserProfile?> startOnboardingFlow(
    BuildContext context, UserProfile initialProfile) async {
  final String? name = await Navigator.of(context).push<String>(
    MaterialPageRoute(
      builder: (_) => NameScreen(initialName: initialProfile.name),
    ),
  );
  if (name == null || name.isEmpty) return null;

  final DateTime? birthday = await Navigator.of(context).push<DateTime>(
    MaterialPageRoute(
      builder: (_) => BirthdayScreen(initialBirthday: initialProfile.birthday),
    ),
  );
  if (birthday == null) return null;

  final List<String>? categories =
      await Navigator.of(context).push<List<String>>(
    MaterialPageRoute(
      builder: (_) =>
          CategoriesScreen(selectedCategories: initialProfile.categories),
    ),
  );
  if (categories == null || categories.isEmpty) return null;

  final List<String>? authors = await Navigator.of(context).push<List<String>>(
    MaterialPageRoute(
      builder: (_) => AuthorsScreen(selectedAuthors: initialProfile.authors),
    ),
  );
  if (authors == null) return null;

  return UserProfile(
    name: name,
    birthday: birthday,
    categories: categories,
    authors: authors,
    onboardingCompleted: true,
  );
}
