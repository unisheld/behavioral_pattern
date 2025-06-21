import 'package:flutter/material.dart';
import 'ui_factory.dart';

class MaterialFactory implements UIFactory {
  @override
  Widget createButton({required String label, required VoidCallback onPressed}) {
    return ElevatedButton(onPressed: onPressed, child: Text(label));
  }

  @override
  Widget createText(String text, {TextStyle? style}) {
    return Text(text, style: style);
  }

  @override
  Widget createIconButton({required IconData icon, required VoidCallback onPressed}) {
    return IconButton(icon: Icon(icon), onPressed: onPressed);
  }

  @override
  PreferredSizeWidget createAppBar({required String title}) {
    return AppBar(title: Text(title));
  }
}
