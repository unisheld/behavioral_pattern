import 'package:flutter/material.dart';
import 'onboarding_handler.dart';


class BirthdayHandler extends OnboardingHandler {
  @override
  Future<void> handle(BuildContext context, OnboardingStepData data) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: data.birthday ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      data = data.copyWith(birthday: pickedDate);
    }
    if (next != null) {
      await next!.handle(context, data);
    }
  }
}
