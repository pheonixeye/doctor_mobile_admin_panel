import 'package:flutter/material.dart';

class ShellPage extends StatelessWidget {
  const ShellPage({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
