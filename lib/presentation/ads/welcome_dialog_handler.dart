import 'package:flutter/material.dart';
import '../../domain/entities/user_profile.dart';
import 'ad_handler.dart';

class WelcomeDialogHandler extends AdvertisementHandler {
  @override
  Future<void> handle(BuildContext context, UserProfile profile) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Welcome'),
        content: Text('Welcome, ${profile.name ?? 'User'}!'),
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
