import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  final dynamic mode;
  final dynamic device;
  const LanguagePage({super.key, this.mode, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('LanguagePage')));
  }
}
