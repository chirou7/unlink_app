import 'package:flutter/material.dart';

class DeviceSettingsPage extends StatelessWidget {
  final dynamic device;
  const DeviceSettingsPage({super.key, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('DeviceSettingsPage')));
  }
}
