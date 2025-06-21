import 'package:behavioral_pattern/presentation/onboarding/handlers/onboarding_handler.dart';
import 'package:behavioral_pattern/presentation/onboarding/screens/name_screen.dart';
import 'package:flutter/material.dart';

class NameHandler extends OnboardingHandler {
  @override
  Future<void> handle(BuildContext context, OnboardingStepData data) async {
    final name = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => NameScreen(initialName: data.name),
      ),
    );
    if (name != null && name.isNotEmpty) {
      data = data.copyWith(name: name);
    }
    if (next != null) {
      await next!.handle(context, data);
    }
  }
}
