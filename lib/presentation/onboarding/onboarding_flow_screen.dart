import 'package:behavioral_pattern/domain/usecases/get_user_profile_usecase.dart';
import 'package:behavioral_pattern/presentation/ads/start_ads_chain.dart';
import 'package:behavioral_pattern/presentation/onboarding/start_onboarding.dart';
import 'package:behavioral_pattern/presentation/profile/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkOnboarding();
    });
  }

  Future<void> _checkOnboarding() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/auth');
      }
      return;
    }

    final getProfileUseCase =
        Provider.of<GetUserProfileUseCase>(context, listen: false);
    final updateProfileUseCase =
        Provider.of<UpdateUserProfileUseCase>(context, listen: false);

    final profile = await getProfileUseCase.call(user.uid);

    if (profile.onboardingCompleted) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
      return;
    }

    final updatedProfile = await startOnboardingFlow(context, profile);

    if (updatedProfile == null) {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/auth');
      }
      return;
    }

    final finalProfile = updatedProfile.copyWith(onboardingCompleted: true);
    await updateProfileUseCase.call(user.uid, finalProfile);
    final profileBloc = Provider.of<ProfileBloc>(context, listen: false);
    await profileBloc.reload();

    await startAdsDialogChain(context, finalProfile);

    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
