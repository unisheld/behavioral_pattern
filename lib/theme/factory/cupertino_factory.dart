import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ui_factory.dart';

class CupertinoFactory implements UIFactory {
  @override
  Widget createButton({required String label, required VoidCallback onPressed}) {
    return CupertinoButton.filled(child: Text(label), onPressed: onPressed);
  }

  @override
  Widget createText(String text, {TextStyle? style}) {
    return Text(text, style: style);
  }

  @override
  Widget createIconButton({required IconData icon, required VoidCallback onPressed}) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Icon(icon),
      onPressed: onPressed,
    );
  }

  @override
  PreferredSizeWidget createAppBar({required String title}) {
    return CupertinoNavigationBar(middle: Text(title));
  }
}
