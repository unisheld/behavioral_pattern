import 'package:flutter/material.dart';
import 'ui_factory.dart';

class CustomFactory implements UIFactory {
  @override
  Widget createButton({required String label, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget createText(String text, {TextStyle? style}) {
    return Text(
      text,
      style: style ?? const TextStyle(fontFamily: 'CustomFont', fontSize: 18, color: Colors.purple),
    );
  }

  @override
  Widget createIconButton({required IconData icon, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(icon, color: Colors.purple),
    );
  }

  @override
  PreferredSizeWidget createAppBar({required String title}) {
    return AppBar(
      backgroundColor: Colors.purple,
      title: Text(title, style: const TextStyle(fontFamily: 'CustomFont')),
    );
  }
}
