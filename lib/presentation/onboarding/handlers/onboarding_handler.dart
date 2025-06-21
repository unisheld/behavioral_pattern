import 'package:flutter/material.dart';

abstract class OnboardingHandler {
  OnboardingHandler? next;
  void setNext(OnboardingHandler handler) {
    next = handler;
  }

  Future<void> handle(BuildContext context, OnboardingStepData data);
}

class OnboardingStepData {
  String? name;
  DateTime? birthday;
  List<String> categories = [];
  List<String> authors = [];

  OnboardingStepData copyWith({
    String? name,
    DateTime? birthday,
    List<String>? categories,
    List<String>? authors,
  }) {
    return OnboardingStepData()
      ..name = name ?? this.name
      ..birthday = birthday ?? this.birthday
      ..categories = categories ?? List.from(this.categories)
      ..authors = authors ?? List.from(this.authors);
  }
}
