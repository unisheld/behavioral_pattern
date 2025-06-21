import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'auth_bloc.dart';
import 'auth_bloc_proxy.dart';

class AuthScreen extends StatefulWidget {
  final AuthBlocProxy authBloc;

  const AuthScreen({super.key, required this.authBloc});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _navigated = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateToOnboarding() {
    if (!_navigated) {
      _navigated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/onboarding');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: widget.authBloc.stateStream,
      builder: (context, snapshot) {
        final state = snapshot.data ?? AuthState();

        if (state.registered) {
          _navigateToOnboarding();
        } else if (state.signedIn) {
          _navigateToOnboarding();
        }

        return Scaffold(
          appBar: AppBar(title: Text(tr('auth.title', args: ['Movie App']))),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: tr('auth.email')),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: tr('auth.password')),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                if (state.error != null)
                  Text(state.error!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                if (state.isLoading)
                  const CircularProgressIndicator()
                else ...[
                  ElevatedButton(
                    onPressed: () {
                      widget.authBloc.signIn(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                    },
                    child: Text(tr('auth.sign_in')),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.authBloc.register(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                    },
                    child: Text(tr('auth.register')),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
