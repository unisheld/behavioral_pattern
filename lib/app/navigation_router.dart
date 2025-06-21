import 'package:behavioral_pattern/presentation/auth/auth_bloc_proxy.dart';
import 'package:behavioral_pattern/presentation/profile/profile_bloc.dart';
import 'package:behavioral_pattern/presentation/profile/profile_bloc_proxy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation/auth/auth_screen.dart';
import '../presentation/home/home_screen.dart';
import '../presentation/onboarding/onboarding_flow_screen.dart';
import '../theme/theme_notifier.dart';
import 'logger.dart';

class NavigationRouter {
  final AuthBlocProxy authBlocProxy;

  NavigationRouter({required this.authBlocProxy});

  static const String auth = '/auth';
  static const String onboarding = '/onboarding';
  static const String home = '/home';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case auth:
        return MaterialPageRoute(
          builder: (_) => AuthScreen(authBloc: authBlocProxy),
        );

      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingFlowScreen(),
        );

      case home:
        return MaterialPageRoute(builder: (context) {
          final profileBloc = Provider.of<ProfileBloc?>(context, listen: false);
          if (profileBloc == null) {
            return _errorWidget('ProfileBloc is null');
          }

          final profileBlocProxy = ProfileBlocProxy(
            profileBloc,
            ConsoleLogger(),
          );

          final factory =
              Provider.of<ThemeNotifier>(context, listen: false).factory;

          return HomeScreen(
            factory: factory,
            profileBlocProxy: profileBlocProxy,
            authBlocProxy: authBlocProxy,
            omdbApiKey: '9089c438',
          );
        });

      default:
        return _errorRoute('Unknown route: ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute([String? message]) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text(message ?? 'Unknown route')),
      ),
    );
  }

  static Widget _errorWidget(String message) {
    return Scaffold(
      body: Center(child: Text(message)),
    );
  }
}
