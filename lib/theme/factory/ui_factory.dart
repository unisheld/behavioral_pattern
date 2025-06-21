import 'package:flutter/material.dart';

abstract class UIFactory {
  Widget createButton({required String label, required VoidCallback onPressed});
  Widget createText(String text, {TextStyle? style});
  Widget createIconButton({required IconData icon, required VoidCallback onPressed});
  PreferredSizeWidget createAppBar({required String title});
}
