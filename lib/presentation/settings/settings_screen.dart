import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../theme/theme_notifier.dart';

import '../auth/auth_bloc.dart';

class SettingsScreen extends StatefulWidget {
  final AuthBloc authBloc;

  const SettingsScreen({super.key, required this.authBloc});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = widget.authBloc;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();
    final currentTheme = themeNotifier.theme;
    final factory = themeNotifier.factory;
    final currentLocale = context.locale;

    return Scaffold(
      appBar: factory.createAppBar(title: tr('settings.title')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          factory.createText(
            tr('settings.select_theme'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          RadioListTile<AppTheme>(
            title: factory.createText(tr('settings.material')),
            value: AppTheme.material,
            groupValue: currentTheme,
            onChanged: (val) {
              if (val != null) themeNotifier.setTheme(val);
            },
          ),
          RadioListTile<AppTheme>(
            title: factory.createText(tr('settings.cupertino')),
            value: AppTheme.cupertino,
            groupValue: currentTheme,
            onChanged: (val) {
              if (val != null) themeNotifier.setTheme(val);
            },
          ),
          RadioListTile<AppTheme>(
            title: factory.createText(tr('settings.custom')),
            value: AppTheme.custom,
            groupValue: currentTheme,
            onChanged: (val) {
              if (val != null) themeNotifier.setTheme(val);
            },
          ),
          const SizedBox(height: 24),
          factory.createText(
            tr('settings.select_language'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          RadioListTile<Locale>(
            title: const Text('English'),
            value: const Locale('en'),
            groupValue: currentLocale,
            onChanged: (val) {
              if (val != null) context.setLocale(val);
            },
          ),
          RadioListTile<Locale>(
            title: const Text('Русский'),
            value: const Locale('ru'),
            groupValue: currentLocale,
            onChanged: (val) {
              if (val != null) context.setLocale(val);
            },
          ),
          const SizedBox(height: 24),
          factory.createButton(
            label: tr('settings.logout'),
            onPressed: () async {
              debugPrint('🟡 [SettingsScreen] Sign out started');
              await FirebaseAuth.instance.signOut();

              _authBloc.reset();

              debugPrint('🟢 [SettingsScreen] Sign out complete');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(tr('settings.logged_out')),
                  duration: const Duration(seconds: 2),
                ),
              );

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/auth', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
