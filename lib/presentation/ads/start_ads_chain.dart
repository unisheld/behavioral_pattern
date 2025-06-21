import 'package:flutter/material.dart';
import '../../domain/entities/user_profile.dart';
import 'welcome_dialog_handler.dart';
import 'categories_dialog_handler.dart';
import 'authors_dialog_handler.dart';

Future<void> startAdsDialogChain(BuildContext context, UserProfile profile) async {
  final welcome = WelcomeDialogHandler();
  final categories = CategoriesDialogHandler();
  final authors = AuthorsDialogHandler();

  welcome.next = categories;
  categories.next = authors;

  await welcome.handle(context, profile);
}
