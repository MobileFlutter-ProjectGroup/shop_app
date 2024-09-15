import 'package:flutter/material.dart';

class MySanckBar {
  void onButtonTapped(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
