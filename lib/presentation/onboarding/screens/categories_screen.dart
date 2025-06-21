import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  final List<String> selectedCategories;
  const CategoriesScreen({Key? key, required this.selectedCategories}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  static const allCategories = ['Action', 'Comedy', 'Drama', 'Horror', 'Sci-Fi'];

  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selectedCategories);
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selected.contains(category)) {
        _selected.remove(category);
      } else {
        _selected.add(category);
      }
    });
  }

  void _submit() {
    if (_selected.isNotEmpty) {
      Navigator.of(context).pop(_selected);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one category')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select your favorite categories')),
      body: ListView(
        children: [
          ...allCategories.map((cat) => CheckboxListTile(
                title: Text(cat),
                value: _selected.contains(cat),
                onChanged: (_) => _toggleCategory(cat),
              )),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _submit,
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
