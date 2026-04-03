import 'package:flutter/material.dart';

class DeviceCheckPage extends StatelessWidget {
  final dynamic device;
  const DeviceCheckPage({super.key, this.device});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('DeviceCheckPage')));
  }
}
