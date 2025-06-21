import 'package:flutter/material.dart';
import '../../domain/entities/user_profile.dart';
import 'ad_handler.dart';

class AuthorsDialogHandler extends AdvertisementHandler {
  @override
  Future<void> handle(BuildContext context, UserProfile profile) async {
    final authors = profile.authors.isNotEmpty
        ? profile.authors.join(', ')
        : 'various authors';
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Recommended Authors'),
        content: Text('You might like: $authors'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Finish'),
          ),
        ],
      ),
    );

    await next?.handle(context, profile);
  }
}
