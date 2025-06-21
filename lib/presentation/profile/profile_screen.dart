import 'package:behavioral_pattern/theme/factory/ui_factory.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../domain/entities/user_profile.dart';

import '../profile/profile_bloc_proxy.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileBlocProxy bloc;
  final UIFactory factory;

  const ProfileScreen({super.key, required this.bloc, required this.factory});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  DateTime? _birthday;
  List<String> _selectedCategories = [];
  List<String> _selectedAuthors = [];

  final allCategories = ['Action', 'Comedy', 'Drama', 'Horror', 'Sci-Fi'];
  final allAuthors = ['Nolan', 'Spielberg', 'Villeneuve', 'Scorsese'];

  bool _isInitializedFromProfile = false;

  @override
  void dispose() {
    _nameController.dispose();
    widget.bloc.dispose(); // Не забудь корректно закрыть bloc
    super.dispose();
  }

  Future<void> _pickBirthday() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthday ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: tr('profile.select_birthday'),
    );
    if (picked != null) {
      setState(() => _birthday = picked);
    }
  }

  void _toggleCategory(String cat) {
    setState(() {
      if (_selectedCategories.contains(cat)) {
        _selectedCategories.remove(cat);
      } else {
        _selectedCategories.add(cat);
      }
    });
  }

  void _toggleAuthor(String author) {
    setState(() {
      if (_selectedAuthors.contains(author)) {
        _selectedAuthors.remove(author);
      } else {
        _selectedAuthors.add(author);
      }
    });
  }

  Future<void> _saveProfile() async {
    final currentProfile = await widget.bloc.profileStream.first;

    final updated = UserProfile(
      name: _nameController.text.trim(),
      birthday: _birthday,
      categories: _selectedCategories,
      authors: _selectedAuthors,
      onboardingCompleted: currentProfile?.onboardingCompleted ?? false,
    );

    await widget.bloc.updateProfile(updated);
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(tr('profile.saved'))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.factory;

    return Scaffold(
      appBar: f.createAppBar(title: tr('profile.title')),
      body: StreamBuilder<UserProfile?>(
        stream: widget.bloc.profileStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: f.createText(tr('profile.load_error')));
          }

          final profile = snapshot.data;

          if (profile == null) {
            return Center(child: f.createText(tr('profile.no_data')));
          }

          if (!_isInitializedFromProfile) {
            _nameController.text = profile.name ?? '';
            _birthday = profile.birthday;
            _selectedCategories = List.from(profile.categories);
            _selectedAuthors = List.from(profile.authors);
            _isInitializedFromProfile = true;
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: tr('profile.name')),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: f.createText(
                  tr('profile.birthday'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: f.createText(
                  _birthday != null
                      ? DateFormat.yMMMMd(context.locale.toString())
                          .format(_birthday!)
                      : tr('profile.select_birthday'),
                ),
                trailing: f.createIconButton(
                  icon: Icons.calendar_today,
                  onPressed: _pickBirthday,
                ),
              ),
              const SizedBox(height: 16),
              f.createText(
                tr('profile.categories'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ...allCategories.map((cat) {
                return CheckboxListTile(
                  title: f.createText(tr('categories.$cat')),
                  value: _selectedCategories.contains(cat),
                  onChanged: (_) => _toggleCategory(cat),
                );
              }).toList(),
              const SizedBox(height: 16),
              f.createText(
                tr('profile.authors'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ...allAuthors.map((author) {
                return CheckboxListTile(
                  title: f.createText(tr('authors.$author')),
                  value: _selectedAuthors.contains(author),
                  onChanged: (_) => _toggleAuthor(author),
                );
              }).toList(),
              const SizedBox(height: 32),
              f.createButton(
                label: tr('profile.save_button'),
                onPressed: _saveProfile,
              ),
              const SizedBox(height: 50),
            ],
          );
        },
      ),
    );
  }
}
