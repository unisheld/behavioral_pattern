import 'package:behavioral_pattern/presentation/profile/profile_bloc_proxy.dart';
import 'package:behavioral_pattern/presentation/profile/profile_screen.dart';
import 'package:behavioral_pattern/presentation/settings/settings_screen.dart';
import 'package:behavioral_pattern/presentation/movies/movies_screen.dart';
import 'package:behavioral_pattern/theme/factory/ui_factory.dart';
import 'package:flutter/material.dart';
import '../auth/auth_bloc_proxy.dart';

class HomeScreen extends StatefulWidget {
  final UIFactory factory;
  final ProfileBlocProxy profileBlocProxy;
  final AuthBlocProxy authBlocProxy;
  final String omdbApiKey;

  const HomeScreen({
    super.key,
    required this.factory,
    required this.profileBlocProxy,
    required this.authBlocProxy,
    required this.omdbApiKey,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      MoviesScreen(
        profileBloc: widget.profileBlocProxy,
        factory: widget.factory,
        omdbApiKey: widget.omdbApiKey,
      ),
      ProfileScreen(
        bloc: widget.profileBlocProxy,
        factory: widget.factory,
      ),
      SettingsScreen(authBloc: widget.authBlocProxy),
    ];
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
