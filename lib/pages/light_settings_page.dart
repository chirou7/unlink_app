import 'package:flutter/material.dart';

class LightSettingsPage extends StatelessWidget {
  final dynamic mode;
  final dynamic device;
  const LightSettingsPage({super.key, this.mode, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('LightSettingsPage')));
  }
}
