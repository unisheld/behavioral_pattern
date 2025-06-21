import 'package:flutter/material.dart';
import '../../domain/entities/user_profile.dart';

abstract class AdvertisementHandler {
  AdvertisementHandler? next;

  Future<void> handle(BuildContext context, UserProfile profile);
}
