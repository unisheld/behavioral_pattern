import 'package:flutter/material.dart';
import '../../domain/entities/user_profile.dart';
import 'ad_handler.dart';

class CategoriesDialogHandler extends AdvertisementHandler {
  @override
  Future<void> handle(BuildContext context, UserProfile profile) async {
    final categories = profile.categories.isNotEmpty
        ? profile.categories.join(', ')
        : 'various categories';
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('New Movies'),
        content: Text('We have new movies in: $categories'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Next'),
          ),
        ],
      ),
    );

    await next?.handle(context, profile);
  }
}
