import 'package:flutter/material.dart';

class AuthorsScreen extends StatefulWidget {
  final List<String> selectedAuthors;
  const AuthorsScreen({Key? key, required this.selectedAuthors})
      : super(key: key);

  @override
  State<AuthorsScreen> createState() => _AuthorsScreenState();
}

class _AuthorsScreenState extends State<AuthorsScreen> {
  static const allAuthors = ['Nolan', 'Spielberg', 'Villeneuve', 'Scorsese'];

  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selectedAuthors);
  }

  void _toggleAuthor(String author) {
    setState(() {
      if (_selected.contains(author)) {
        _selected.remove(author);
      } else {
        _selected.add(author);
      }
    });
  }

  void _submit() {
    if (_selected.isNotEmpty) {
      Navigator.of(context).pop(_selected);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one author')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select your favorite authors')),
      body: ListView(
        children: [
          ...allAuthors.map((author) => CheckboxListTile(
                title: Text(author),
                value: _selected.contains(author),
                onChanged: (_) => _toggleAuthor(author),
              )),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _submit,
              child: const Text('Finish'),
            ),
          ),
        ],
      ),
    );
  }
}
