import 'package:behavioral_pattern/domain/entities/user_profile.dart';
import 'package:behavioral_pattern/domain/usecases/get_user_profile_usecase.dart';
import 'package:behavioral_pattern/presentation/ads/start_ads_chain.dart';
import 'package:behavioral_pattern/presentation/auth/auth_bloc_proxy.dart';
import 'package:behavioral_pattern/presentation/auth/auth_screen.dart';
import 'package:behavioral_pattern/presentation/onboarding/start_onboarding.dart';
import 'package:behavioral_pattern/presentation/profile/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthStateListener extends StatefulWidget {
  final AuthBlocProxy authBloc;

  const AuthStateListener({required this.authBloc, super.key});

  @override
  State<AuthStateListener> createState() => _AuthStateListenerState();
}

class _AuthStateListenerState extends State<AuthStateListener> {
  User? _lastUser;
  bool _navigated = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = Provider.of<User?>(context);

    if (user != _lastUser) {
      _navigated = false;
      _lastUser = user;
    }

    if (_navigated) {
      return;
    }

    final profileBloc = Provider.of<ProfileBloc?>(context, listen: false);
    final updateProfileUseCase =
        Provider.of<UpdateUserProfileUseCase>(context, listen: false);
    final authBloc = widget.authBloc;

    if (user == null) {
      _navigated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/auth', (route) => false);
      });
      return;
    }

    if (profileBloc == null) {
      return;
    }

    _navigated = true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final profile = await profileBloc.profileStream.first;

        final isProfileIncomplete = profile == null ||
            profile.name?.isEmpty != false ||
            profile.birthday == null ||
            profile.categories.isEmpty ||
            profile.authors.isEmpty;

        if (authBloc.isNewlyRegistered ||
            isProfileIncomplete ||
            !(profile?.onboardingCompleted ?? false)) {
          final newProfile =
              await startOnboardingFlow(context, profile ?? UserProfile());

          if (newProfile == null) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/auth', (route) => false);
            return;
          }

          final updated = newProfile.copyWith(onboardingCompleted: true);
          await updateProfileUseCase.call(user.uid, updated);
          await profileBloc.reload();
          await startAdsDialogChain(context, updated);
        } else {
          await startAdsDialogChain(context, profile);
        }

        authBloc.reset();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } catch (e, stacktrace) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/auth', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return AuthScreen(authBloc: widget.authBloc);
    }

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
