import 'package:flutter/material.dart';
import 'onboarding_handler.dart';
import '../screens/categories_screen.dart';

class CategoriesHandler extends OnboardingHandler {
  @override
  Future<void> handle(BuildContext context, OnboardingStepData data) async {
    final selectedCategories = await Navigator.of(context).push<List<String>>(
      MaterialPageRoute(
        builder: (_) => CategoriesScreen(
          selectedCategories: data.categories,
        ),
      ),
    );
    if (selectedCategories != null) {
      data = data.copyWith(categories: selectedCategories);
    }
    if (next != null) {
      await next!.handle(context, data);
    }
  }
}
